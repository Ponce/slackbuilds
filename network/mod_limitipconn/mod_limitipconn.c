/*
 * Copyright (C) 2000-2002 David Jao <[EMAIL PROTECTED]>
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice, this permission notice, and the
 * following disclaimer shall be included in all copies or substantial
 * portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 */

#include "httpd.h"
#include "http_config.h"
#include "http_request.h"
#include "http_protocol.h"
#include "http_core.h"
#include "http_main.h"
#include "http_log.h"
#include "ap_mpm.h"
#include "apr_strings.h"
#include "scoreboard.h"

#define MODULE_NAME "mod_limitipconn"
#define MODULE_VERSION "0.22"

module AP_MODULE_DECLARE_DATA limitipconn_module;

static int server_limit, thread_limit;

typedef struct {
    signed int limit;       /* max number of connections per IP */

    /* array of MIME types exempt from limit checking */
    apr_array_header_t *no_limit;
    int no_limit_set;

    /* array of MIME types to limit check; all other types are exempt */
    apr_array_header_t *excl_limit;
    int excl_limit_set;
} limitipconn_config;

static void *limitipconn_create_config(apr_pool_t *p, server_rec *s)
{
    limitipconn_config *cfg = (limitipconn_config *)
                               apr_pcalloc(p, sizeof (*cfg));

    /* default configuration: no limit (unset), and both arrays are empty */
    cfg->limit = -1;
    cfg->no_limit = apr_array_make(p, 0, sizeof(char *));
    cfg->excl_limit = apr_array_make(p, 0, sizeof(char *));

    return cfg;
}

/* Simple merge: Per vhost entries overrides main server entries */
static void *limitipconn_merge_config(apr_pool_t *p, void *BASE, void *ADD)
{
    limitipconn_config *base = BASE;
    limitipconn_config *add  = ADD;

    limitipconn_config *cfg = (limitipconn_config *)
                               apr_pcalloc(p, sizeof (*cfg));

    cfg->limit = (add->limit == -1) ? base->limit : add->limit;
    cfg->no_limit = add->no_limit_set ? add->no_limit : base->no_limit;
    cfg->excl_limit = add->excl_limit_set ? add->excl_limit : base->excl_limit;

    return cfg;
}

/* The handler runs as a quick handler so we can arrange for it to be called
   before mod_cache. Being a quick handler means that we have a lot of
   limitations, the basic ones are that the only thing we know is the URL and
   that if we return OK it means that we handle the entire reply of the
   request including populating the brigades with data. */
static int limitipconn_handler(request_rec *r, int lookup)
{
    /* get configuration information */
    limitipconn_config *cfg = (limitipconn_config *)
            ap_get_module_config(r->server->module_config, &limitipconn_module);

    /* convert Apache arrays to normal C arrays */
    char **nolim = (char **) cfg->no_limit->elts;
    char **exlim = (char **) cfg->excl_limit->elts;

    const char *address;

    /* loop index variables */
    int i;
    int j;

    /* running count of number of connections from this address */
    int ip_count = 0;

    /* Content-type of the current request */
    const char *content_type;

    /* scoreboard data structure */
    worker_score *ws_record;

    /* We decline to handle subrequests: otherwise, in the next step we
     * could get into an infinite loop. */
    if (!ap_is_initial_req(r)) {
        ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
                     "mod_limitipconn: SKIPPED: Not initial request");
        return DECLINED;
    }

    /* A limit value of 0 by convention means no limit, negative means
       unset (no limit). */
    if (cfg->limit <= 0) {
        ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
                     "mod_limitipconn: OK: No limit");
        return DECLINED;
    }

#ifdef RECORD_FORWARD
    if ((address = apr_table_get(r->headers_in, "X-Forwarded-For")) == NULL)
#endif
        address = r->connection->remote_ip;

    /* Only check the MIME-type if we have MIME-type stuff in our config.
       That extra subreq can be quite expensive. */
    if(cfg->no_limit->nelts > 0 || cfg->excl_limit->nelts > 0) {
        /* Look up the Content-type of this request. We need a subrequest
         * here since this module might be called before the URI has been
         * translated into a MIME type. */
        content_type = ap_sub_req_lookup_uri(r->uri, r, NULL)->content_type;

        /* If there's no Content-type, use the default. */
        if (!content_type) {
            content_type = ap_default_type(r);
        }

        ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
                "mod_limitipconn: uri: %s  Content-Type: %s", 
                r->uri, content_type);

        /* Cycle through the exempt list; if our content_type is exempt,
         * return OK */
        for (i = 0; i < cfg->no_limit->nelts; i++) {
            if ((ap_strcasecmp_match(content_type, nolim[i]) == 0)
                || (strncmp(nolim[i], content_type, strlen(nolim[i])) == 0)) 
            {
                ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
                             "mod_limitipconn: OK: %s exempt", content_type);
                return DECLINED;
            }
        }

        /* Cycle through the exclusive list, if it exists; if our MIME type
         * is not present, bail out */
        if (cfg->excl_limit->nelts) {
            int excused = 1;
            for (i = 0; i < cfg->excl_limit->nelts; i++) {
                if ((ap_strcasecmp_match(content_type, exlim[i]) == 0)
                    || 
                    (strncmp(exlim[i], content_type, strlen(exlim[i])) == 0)) 
                {
                    excused = 0;
                }
            }
            if (excused) {
                ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
                             "mod_limitipconn: OK: %s not excluded", 
                             content_type);
                return DECLINED;
            }
        }
    }

    /* Count up the number of connections we are handling right now from
     * this IP address */
    for (i = 0; i < server_limit; ++i) {
      for (j = 0; j < thread_limit; ++j) {
        ws_record = ap_get_scoreboard_worker(i, j);
        switch (ws_record->status) {
            case SERVER_BUSY_READ:
            case SERVER_BUSY_WRITE:
            case SERVER_BUSY_KEEPALIVE:
            case SERVER_BUSY_LOG:
            case SERVER_BUSY_DNS:
            case SERVER_CLOSING:
            case SERVER_GRACEFUL:
                if ((strcmp(address, ws_record->client) == 0)
#ifdef RECORD_FORWARD
                        || (strcmp(address, ws_record->fwdclient) == 0)
#endif
               ) {
                    ip_count++;
                }
                break;
            default:
                break;
        }
      }
    }

    ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
            "mod_limitipconn: vhost: %s  uri: %s  current: %d  limit: %d", 
            r->server->server_hostname, r->uri, ip_count, cfg->limit);

    if (ip_count > cfg->limit) {
      ap_log_rerror(APLOG_MARK, APLOG_INFO, 0, r, 
                    "Rejected, too many connections from this host.");
      /* set an environment variable */
      apr_table_setn(r->subprocess_env, "LIMITIP", "1");
      /* return 503 */
      return HTTP_SERVICE_UNAVAILABLE;
    } else {
        ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r,
                     "mod_limitipconn: OK: Passed all checks");
        return DECLINED;
    }
}

/* Parse the MaxConnPerIP directive */
static const char *limit_config_cmd(cmd_parms *parms, void *dummy,
                                    const char *arg)
{
    limitipconn_config *cfg = (limitipconn_config *)
                            ap_get_module_config(parms->server->module_config, 
                                                 &limitipconn_module);

    signed long int limit = strtol(arg, (char **) NULL, 10);

    /* No reasonable person would want more than 2^16. Better would be
       to use LONG_MAX but that causes portability problems on win32 */
    if ((limit > 65535) || (limit < 0)) {
        return "Integer overflow or invalid number";
    }

    cfg->limit = limit;
    return NULL;
}

/* Parse the NoIPLimit directive */
static const char *no_limit_config_cmd(cmd_parms *parms, void *dummy,
                                       const char *arg)
{
    limitipconn_config *cfg = (limitipconn_config *)
                            ap_get_module_config(parms->server->module_config, 
                                                 &limitipconn_module);

    *(char **) apr_array_push(cfg->no_limit) = apr_pstrdup(parms->pool, arg);
    cfg->no_limit_set = 1;
    return NULL;
}

/* Parse the OnlyIPLimit directive */
static const char *excl_limit_config_cmd(cmd_parms *parms, void *dummy,
                                         const char *arg)
{
    limitipconn_config *cfg = (limitipconn_config *)
                            ap_get_module_config(parms->server->module_config, 
                                                 &limitipconn_module);

    *(char **) apr_array_push(cfg->excl_limit) = apr_pstrdup(parms->pool, arg);
    cfg->excl_limit_set = 1;
    return NULL;
}

/* Array describing structure of configuration directives */
static command_rec limitipconn_cmds[] = {
    AP_INIT_TAKE1("MaxConnPerIP", limit_config_cmd, NULL, RSRC_CONF,
     "maximum simultaneous connections per IP address"),
    AP_INIT_ITERATE("NoIPLimit", no_limit_config_cmd, NULL, RSRC_CONF,
     "MIME types for which limit checking is disabled"),
    AP_INIT_ITERATE("OnlyIPLimit", excl_limit_config_cmd, NULL, RSRC_CONF,
     "restrict limit checking to these MIME types only"),
    {NULL},
};

/* Set up startup-time initialization */
static int limitipconn_init(apr_pool_t *p, apr_pool_t *plog, apr_pool_t *ptemp, 
server_rec *s)
{
    ap_log_error(APLOG_MARK, APLOG_INFO, 0, s,
                 MODULE_NAME " " MODULE_VERSION " started.");
    ap_mpm_query(AP_MPMQ_HARD_LIMIT_THREADS, &thread_limit);
    ap_mpm_query(AP_MPMQ_HARD_LIMIT_DAEMONS, &server_limit);
    return OK;
}

static void register_hooks(apr_pool_t *p)
{
    static const char * const after_me[] = { "mod_cache.c", NULL };

    /* We must run as a quick handle so we can deny connections before
       mod_cache gets to serve them */
    ap_hook_quick_handler(limitipconn_handler, NULL, after_me, APR_HOOK_FIRST);

    ap_hook_post_config(limitipconn_init, NULL, NULL, APR_HOOK_MIDDLE);
}

module AP_MODULE_DECLARE_DATA limitipconn_module = {
    STANDARD20_MODULE_STUFF,
    NULL,                       /* create per-dir config structures */
    NULL,                       /* merge  per-dir    config structures */
    limitipconn_create_config,  /* create per-server config structures */
    limitipconn_merge_config,   /* merge  per-server config structures */
    limitipconn_cmds,           /* table of config file commands       */
    register_hooks
};

