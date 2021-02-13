#!/bin/sh
# Copyright 2008,2009 Vincent Batts, Birmingham, AL, USA
# Copyright 2010,2011 Vincent Batts, Vienna, VA, USA
#               vbatts@hashbangbash.com, http://hashbangbash.com/
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

JAVA=$(which java)
JENKINS="/usr/share/jenkins/jenkins.war"
JENKINS_USER="jenkins"
JENKINS_HTTP_PORT="8080"
JENKINS_LOG_FILE="/var/log/jenkins/jenkins.log"
JENKINS_CONSOLELOG_FILE="/var/log/jenkins/jenkins_console.log"
JENKINS_PID_DIR="/var/run/jenkins/"
JENKINS_PID_FILE="$JENKINS_PID_DIR/jenkins.pid"
#JENKINS_WEBAPPSDIR="/var/lib/jenkins/apps/"
JENKINS_WEBROOT="/var/lib/jenkins/webroot/"
JENKINS_HOME="/var/lib/jenkins"
OPT_ARGS=""

# Override some of the above settings, if defined in jenkins.conf
if [ -f /etc/jenkins/jenkins.conf ] ; then
  . /etc/jenkins/jenkins.conf
fi

export JENKINS_HOME

PREV_PID=$( pgrep -f "$JENKINS" )
if [ ! "$PREV_PID" = "" ] ; then
  echo $PREV_PID still running
  exit 1
fi

if [ "$JENKINS_PREFIX" != "" ] ; then
  JENKINS_PREFIX_ARG="--prefix=$JENKINS_PREFIX"
fi

if [ "$JENKINS_HTTP_PORT" != "" ] ; then
  JENKINS_HTTP_PORT_ARG="--httpPort=$JENKINS_HTTP_PORT"
fi

if [ "$JENKINS_HTTP_LISTENING_ADDRESS" != "" ] ; then
  JENKINS_HTTP_LISTENING_ADDRESS_ARG="--httpListenAddress=$JENKINS_HTTP_LISTENING_ADDRESS"
fi

if [ "$JENKINS_HTTPS_PORT" != "" ] ; then
  JENKINS_HTTPS_PORT_ARG="--httpsPort=$JENKINS_HTTPS_PORT"
fi

if [ "$JENKINS_HTTPS_LISTENING_ADDRESS" != "" ] ; then
  JENKINS_HTTPS_LISTENING_ADDRESS_ARG="--httpsListenAddress=$JENKINS_HTTPS_LISTENING_ADDRESS"
fi

if [ "$JENKINS_HTTPS_KEYSTORE" != "" ] ; then
  JENKINS_HTTPS_KEYSTORE_ARG="--httpsKeyStore=$JENKINS_HTTPS_KEYSTORE"
fi

if [ "$JENKINS_HTTPS_KEYSTORE_PASSWORD" != "" ] ; then
  JENKINS_HTTPS_KEYSTORE_PASSWORD_ARG="--httpsKeyStorePassword=$JENKINS_HTTPS_KEYSTORE_PASSWORD"
fi

if [ "$JENKINS_HTTPS_KEY_MANAGER" != "" ] ; then
  JENKINS_HTTPS_KEY_MANAGER_ARG="--httpsKeyManagerType=$JENKINS_HTTPS_KEY_MANAGER"
fi

if [ "$JENKINS_HTTPS_PRIVATE_KEY" != "" ] ; then
  JENKINS_HTTPS_PRIVATE_KEY="--httpsPrivateKey=$JENKINS_HTTPS_PRIVATE_KEY"
fi

if [ "$JENKINS_HTTPS_CERTIFICATE" != "" ] ; then
  JENKINS_HTTPS_CERTIFICATE="--httpsCertificate=$JENKINS_HTTPS_CERTIFICATE"
fi

if [ "$JENKINS_LOG_FILE" != "" ] ; then
  JENKINS_LOG_FILE_ARG="--logfile=$JENKINS_LOG_FILE"
fi

if [ "$JENKINS_WEBAPPSDIR" != "" ] ; then
  JENKINS_WEBAPPSDIR_ARG="--webappsDir=$JENKINS_WEBAPPSDIR"
fi

if [ "$JENKINS_WEBROOT" != "" ] ; then
  JENKINS_WEBROOT_ARG="--webroot=$JENKINS_WEBROOT"
fi

mkdir -p $JENKINS_PID_DIR
chown $JENKINS_USER $JENKINS_PID_DIR

su - $JENKINS_USER -c " \
	JENKINS_HOME=$JENKINS_HOME \
	exec setsid \
	$JAVA -jar $JENKINS \
      	$JENKINS_HTTP_PORT_ARG \
      	$JENKINS_HTTP_LISTENING_ADDRESS_ARG \
      	$JENKINS_HTTPS_PORT_ARG \
      	$JENKINS_PREFIX_ARG \
      	$JENKINS_HTTPS_LISTENING_ADDRESS_ARG \
      	$JENKINS_HTTPS_KEYSTORE_ARG \
      	$JENKINS_HTTPS_KEYSTORE_PASSWORD_ARG \
      	$JENKINS_HTTPS_KEY_MANAGER_ARG \
      	$JENKINS_HTTPS_PRIVATE_KEY \
      	$JENKINS_HTTPS_CERTIFICATE \
      	$JENKINS_LOG_FILE_ARG \
      	$JENKINS_WEBAPPSDIR_ARG \
      	$JENKINS_WEBROOT_ARG \
      	$OPT_ARGS \
	</dev/null >> $JENKINS_CONSOLELOG_FILE 2>&1 &

	echo \$! > $JENKINS_PID_FILE
	disown \$!

	"

