#!/bin/bash

set -x
set -m


/entrypoint.sh couchbase-server &
echo "Custom Port Configured, to Change Edit custom-ports.sh"
cat opt/couchbase/etc/couchbase/static_config

WORKER_PORT=$PORT0
HOST_IP=$HOST
if [ "$TYPE" = "WORKER" ]; then
WORKER_SERVICE_PORT=$SERVICE_PORT
else
VIP_SERVICE_PORT=$VIP_SERVICE_PORT
fi;
#VIP=$COUCHBASE_MASTER:$MASTER_IP
VIP=$COUCHBASE_MASTER_VIP:$VIP_SERVICE_PORT

sleep 15

# Setup index and memory quota
curl -v -X POST http://$HOST_IP:$WORKER_PORT/pools/default -d memoryQuota=300 -d indexMemoryQuota=300

# Setup services
curl -v http://$HOST_IP:$WORKER_PORT/node/controller/setupServices -d services=kv%2Cn1ql%2Cindex

# Setup credentials
curl -v http://$HOST_IP:$WORKER_PORT/settings/web -d port=$WORKER_PORT -d username=Administrator -d password=password

# Setup Memory Optimized Indexes
curl -v -i -u Administrator:password -X POST http://$HOST_IP:$WORKER_PORT/settings/indexes -d 'storageMode=memory_optimized'

# Load travel-sample bucket
#curl -v -u Administrator:password -X POST http://127.0.0.1:8091/sampleBuckets/install -d '["travel-sample"]'

echo "Type: $TYPE"

if [ "$TYPE" = "WORKER" ]; then
  echo "Sleeping ..."
  sleep 15

  #IP=`hostname -s`
  IP=`hostname -I | cut -d ' ' -f1`
  echo "IP: " $IP
  echo "Host: " $HOST
  echo "Worker PORT: " $WORKER_PORT
  echo "Master VIP: " $COUCHBASE_MASTER_VIP
  echo "Master PORT: " $VIP_SERVICE_PORT
  echo "VIP: " $VIP

  echo "Auto Rebalance: $AUTO_REBALANCE"
  if [ "$AUTO_REBALANCE" = "true" ]; then
    couchbase-cli rebalance --cluster=$VIP --user=Administrator --password=password --server-add=$IP --server-add-username=Administrator --server-add-password=password
  else
    couchbase-cli server-add --cluster=$VIP --user=Administrator --password=password --server-add=$IP --server-add-username=Administrator --server-add-password=password
  fi;
fi;

fg 1
