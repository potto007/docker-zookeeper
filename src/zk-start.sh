#! /usr/bin/env bash

# Fail hard and fast
set -eo pipefail

ID=${ID:-1}
echo "ID=$ID"

echo $ID > /var/lib/zookeeper/myid

TICK_TIME=${TICK_TIME:-2000}
echo "tickTime=${TICK_TIME}" > /opt/zookeeper/conf/zoo.cfg
echo "tickTime=${TICK_TIME}"

INIT_LIMIT=${INIT_LIMIT:-10}
echo "initLimit=${INIT_LIMIT}" >> /opt/zookeeper/conf/zoo.cfg
echo "initLimit=${INIT_LIMIT}"

SYNC_LIMIT=${SYNC_LIMIT:-5}
echo "syncLimit=${SYNC_LIMIT}" >> /opt/zookeeper/conf/zoo.cfg
echo "syncLimit=${SYNC_LIMIT}"

echo "dataDir=/var/lib/zookeeper" >> /opt/zookeeper/conf/zoo.cfg
echo "clientPort=2181" >> /opt/zookeeper/conf/zoo.cfg

CLIENT_CNXNS=${CLIENT_CNXNS:-60}
echo "maxClientCnxns=${CLIENT_CNXNS}" >> /opt/zookeeper/conf/zoo.cfg
echo "maxClientCnxns=${CLIENT_CNXNS}"

AUTOPURGE_SNAP_RETAIN_COUNT=${AUTOPURGE_SNAP_RETAIN_COUNT:-3}
echo "autopurge.snapRetainCount=${AUTOPURGE_SNAP_RETAIN_COUNT}" >> /opt/zookeeper/conf/zoo.cfg
echo "autopurge.snapRetainCount=${AUTOPURGE_SNAP_RETAIN_COUNT}"

AUTOPURGE_PURGE_INTERVAL=${AUTOPURGE_PURGE_INTERVAL:-0}
echo "autopurge.purgeInterval=${AUTOPURGE_PURGE_INTERVAL}" >> /opt/zookeeper/conf/zoo.cfg
echo "autopurge.purgeInterval=${AUTOPURGE_PURGE_INTERVAL}"

for VAR in `env`
do
  if [[ $VAR =~ ^SERVER_[0-9]+= ]]; then
    SERVER_ID=`echo "$VAR" | sed -r "s/SERVER_(.*)=.*/\1/"`
    SERVER=`echo "$VAR" | sed 's/.*=//'`
    if [ "${SERVER_ID}" = "${ID}" ]; then
      echo "server.${SERVER_ID}=0.0.0.0:2888:3888" >> /opt/zookeeper/conf/zoo.cfg
      echo "server.${SERVER_ID}=0.0.0.0:2888:3888"
    else
      echo "server.${SERVER_ID}=${SERVER}" >> /opt/zookeeper/conf/zoo.cfg
      echo "server.${SERVER_ID}=${SERVER}"
    fi
  fi
done

su zookeeper -s /bin/bash -c "/opt/zookeeper/bin/zkServer.sh start-foreground"
