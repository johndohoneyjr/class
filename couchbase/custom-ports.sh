#!/bin/bash

sed -i '1s;^;{rest_port, 9000}.\n{mccouch_port, 8999}.\n{memcached_port, 12000}.\n{memcached_dedicated_port, 11999}.\n{moxi_port, 12001}.\n{short_name, "ns_1"}.\n{ssl_rest_port, 11000}.\n{ssl_capi_port, 11001}.\n{ssl_proxy_downstream_port, 11002}.\n{ssl_proxy_upstream_port, 11003}.\n;' opt/couchbase/etc/couchbase/static_config
rm -f opt/couchbase/var/lib/couchbase/config/config.dat