#! /bin/bash

export KAFKA_HOME=@KAFKA_HOME@
# KAFKA_OPTS=
export LOG_DIR="/var/log/kafka/"
export SCALA_BINARY_VERSION=2.11

# JVM
# export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"
# export KAFKA_HEAP_OPTS="-Xmx256M"
# export KAFKA_JVM_PERFORMANCE_OPTS="-server -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSScavengeBeforeRemark -XX:+DisableExplicitGC -Djava.awt.headless=true"

# JMX settings
# export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false "

# JMX port to use
# export JMX_PORT=

# Log4J
export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:/etc/kafka/log4j.properties"

