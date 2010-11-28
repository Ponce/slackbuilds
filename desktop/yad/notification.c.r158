/*
 * This file is part of YAD.
 *
 * YAD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * YAD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with YAD; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Copyright (C) 2008-2010, Victor Ananjevsky <ananasik@gmail.com>
 *
 */

#include <sys/stat.h>
#include <fcntl.h>
#include <time.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

#include "yad.h"

typedef struct {
  gchar *name;
  gchar *action;
} MenuData;

static GtkStatusIcon *status_icon;

static gchar *icon = NULL;
static gchar *action = NULL;

static GSList *menu_data;

static gint exit_code;
static gint icon_size;

static void
timeout_cb (gpointer data)
{
  exit_code = YAD_RESPONSE_TIMEOUT;
  gtk_main_quit ();
}

static void
set_icon (void)
{
  GdkPixbuf *pixbuf;
  GError *err = NULL;

  if (icon == NULL)
    {
      gtk_status_icon_set_from_icon_name (status_icon, "yad");
      return;
    }

  if (g_file_test (icon, G_FILE_TEST_EXISTS))
    {
      pixbuf =
        gdk_pixbuf_new_from_file_at_scale (icon, icon_size, icon_size,
                                           TRUE, &err);
      if (err)
        {
          g_printerr (_("Could not load notification icon '%s': %s"),
                     icon, err->message);
          g_clear_error (&err);
        }
      if (pixbuf)
	{
	  gtk_status_icon_set_from_pixbuf (status_icon, pixbuf);
	  g_object_unref (pixbuf);
	}
      else
	gtk_status_icon_set_from_icon_name (status_icon, "yad");
    }
  else
    gtk_status_icon_set_from_icon_name (status_icon, icon);
}

static gboolean
icon_size_changed_cb (GtkStatusIcon * icon, gint size, gpointer data)
{
  icon_size = size;
  set_icon ();
  return TRUE;
}

static gboolean
activate_cb (GtkWidget * widget, YadData * data)
{
  if (action == NULL || g_ascii_strcasecmp (action, "quit") == 0)
    {
      exit_code = YAD_RESPONSE_OK;
      gtk_main_quit ();
    }
  else
    g_spawn_command_line_async (action, NULL);

  return TRUE;
}

static gboolean
middle_quit_cb (GtkStatusIcon * icon, GdkEventButton * ev, 
		gpointer data)
{
  if (ev->button == 2)
    {
      exit_code = YAD_RESPONSE_ESC;
      gtk_main_quit ();
    }

  return FALSE;
}

static void
popup_menu_item_activate_cb (GtkWidget * w, gpointer data)
{
  gchar *cmd = (gchar *) data;

  if (g_ascii_strcasecmp (cmd, "quit") == 0)
    {
      exit_code = YAD_RESPONSE_OK;
      gtk_main_quit ();
    }
  else
    g_spawn_command_line_async (cmd, NULL);
}

static void
popup_menu_cb (GtkStatusIcon * icon, guint button,
	       guint activate_time, gpointer data)
{
  GtkWidget *menu;
  GtkWidget *item;
  int i;

  g_return_if_fail (menu_data != NULL);

  menu = gtk_menu_new ();
  for (i = 0; i < g_slist_length (menu_data); i++)
    {
      MenuData *d = (MenuData *) g_slist_nth_data (menu_data, i);

      if (d->name)
        {
          item = gtk_menu_item_new_with_label (d->name);
          g_signal_connect (GTK_MENU_ITEM (item), "activate",
                            G_CALLBACK (popup_menu_item_activate_cb),
                            (gpointer) d->action);
        }
      else
	item = gtk_separator_menu_item_new ();

      gtk_widget_show (item);
      gtk_menu_shell_append (GTK_MENU_SHELL (menu), item);
    }
  gtk_menu_popup (GTK_MENU (menu), NULL, NULL,
                  gtk_status_icon_position_menu,
		  icon, button, activate_time);
}

static gboolean
handle_stdin (GIOChannel * channel,
	      GIOCondition condition, gpointer data)
{
  if ((condition & G_IO_IN) != 0)
    {
      GString *string;
      GError *err = NULL;

      string = g_string_new (NULL);
      while (channel->is_readable == FALSE) ;

      do
        {
          gint status;
          gchar *command, *value, **args;

          do
            {
              status =
                g_io_channel_read_line_string (channel, string, NULL, &err);

              while (gdk_events_pending ())
                gtk_main_iteration ();
            }
          while (status == G_IO_STATUS_AGAIN);
	  strip_new_line (string->str);

          if (status != G_IO_STATUS_NORMAL)
            {
              if (err)
                {
                  g_printerr ("yad_notification_handle_stdin(): %s\n",
			      err->message);
                  g_error_free (err);
                  err = NULL;
                }
              continue;
            }

	  args = g_strsplit (string->str, ":", 2);
          command = g_strdup (args[0]);
          value = g_strdup (args[1]);
	  g_strfreev (args);

          if (!g_ascii_strcasecmp (command, "icon"))
            {
              while (*value && g_ascii_isspace (*value))
                value++;

              g_free (icon);
              icon = g_strdup (value);

              if (gtk_status_icon_get_visible (status_icon) &&
		  gtk_status_icon_is_embedded (status_icon))
		set_icon ();
            }
          else if (!g_ascii_strcasecmp (command, "tooltip"))
            {
              if (g_utf8_validate (value, -1, NULL))
                {
                  gchar *message = g_strcompress (value);
#if GTK_CHECK_VERSION(2,16,0)
		  if (options.data.no_markup)
		    gtk_status_icon_set_tooltip_markup (status_icon, message);
		  else
		    gtk_status_icon_set_tooltip_text (status_icon, message);
#else
                  gtk_status_icon_set_tooltip (status_icon, message);
#endif

                  g_free (message);
                }
              else
		g_printerr (_("Invalid UTF-8 in tooltip!\n"));
            }
          else if (!g_ascii_strcasecmp (command, "visible"))
            {
#if !GTK_CHECK_VERSION(2,91,0)
              if (!g_ascii_strcasecmp (value, "blink"))
                {
                  gboolean state = gtk_status_icon_get_blinking (status_icon);
                  gtk_status_icon_set_blinking (status_icon, !state);
                }
              else 
#endif
		if (!g_ascii_strcasecmp (value, "false"))
		  gtk_status_icon_set_visible (status_icon, FALSE);
		else
		  gtk_status_icon_set_visible (status_icon, TRUE);
            }
          else if (!g_ascii_strcasecmp (command, "action"))
            {
              g_free (action);
              action = g_strdup (value);
            }
	  else if (!g_ascii_strcasecmp (command, "quit"))
	    {
	      exit_code = YAD_RESPONSE_OK;
	      gtk_main_quit ();
	    }
          else if (!g_ascii_strcasecmp (command, "menu"))
            {
              MenuData *mdata;
              int i = 0;
              gchar *s, **menu_vals = g_strsplit (value, options.common_data.separator, -1);

              g_slist_free (menu_data);
              menu_data = NULL;

              while (menu_vals[i] != NULL)
                {
                  mdata = g_new0 (MenuData, 1);
                  s = strchr (menu_vals[i], settings.menu_sep[0]);
                  if (s != NULL)
                    {
                      mdata->name =
                        g_strndup (menu_vals[i], s - menu_vals[i]);
                      mdata->action = g_strdup (s + 1);
                    }
                  menu_data = g_slist_append (menu_data, mdata);
                  i++;
                }

              g_strfreev (menu_vals);
            }
          else
	    g_printerr (_("Unknown command '%s'\n"), command);

          g_free (command);
	  g_free (value);
        }
      while (g_io_channel_get_buffer_condition (channel) == G_IO_IN);
      g_string_free (string, TRUE);
    }

  if ((condition & G_IO_HUP) != 0)
    {
      g_io_channel_shutdown (channel, TRUE, NULL);
      gtk_main_quit ();
      return FALSE;
    }

  return TRUE;
}

gint
yad_notification_run ()
{
  GIOChannel *channel = NULL;

  status_icon = gtk_status_icon_new ();
  g_signal_connect (status_icon, "size-changed",
                    G_CALLBACK (icon_size_changed_cb), NULL);

  if (options.data.dialog_text)
    {
#if GTK_CHECK_VERSION(2,16,0)
      if (options.data.no_markup)
	gtk_status_icon_set_tooltip_markup (status_icon, options.data.dialog_text);
      else
	gtk_status_icon_set_tooltip_text (status_icon, options.data.dialog_text);
#else
      gtk_status_icon_set_tooltip (status_icon, options.data.dialog_text);
#endif
    }
  else
#if GTK_CHECK_VERSION(2,16,0)
    gtk_status_icon_set_tooltip_text (status_icon, _("Yad notification"));
#else
    gtk_status_icon_set_tooltip (status_icon, _("Yad notification"));
#endif

  if (options.data.dialog_image)
    icon = g_strdup (options.data.dialog_image);
  if (options.common_data.command)
    action = g_strdup (options.common_data.command);
  menu_data = NULL;

  g_signal_connect (status_icon, "activate",
		    G_CALLBACK (activate_cb), NULL);

  /* quit on middle click (like press Esc) */
  g_signal_connect (status_icon, "button-press-event",
		    G_CALLBACK (middle_quit_cb), NULL); 

  if (options.notification_data.listen)
    {
      channel = g_io_channel_unix_new (0);
      if (channel)
	{
	  g_io_channel_set_encoding (channel, NULL, NULL);
	  g_io_channel_set_flags (channel, G_IO_FLAG_NONBLOCK, NULL);
	  g_io_add_watch (channel, G_IO_IN | G_IO_HUP, handle_stdin, NULL);

	  g_signal_connect (status_icon, "popup_menu",
			    G_CALLBACK (popup_menu_cb), NULL);
	}
    }

  /* Show icon and wait */
  gtk_status_icon_set_visible (status_icon, TRUE);

  if (options.data.timeout > 0)
    g_timeout_add_seconds (options.data.timeout,
			   (GSourceFunc) timeout_cb, NULL);

  gtk_main ();

  return exit_code;
}
