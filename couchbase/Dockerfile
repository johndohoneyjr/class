FROM couchbase:latest

COPY configure-node.sh /opt/couchbase
COPY custom-ports.sh /opt/couchbase
RUN chmod 755 /opt/couchbase/configure-node.sh \
&& chmod 755 /opt/couchbase/custom-ports.sh \
&& /opt/couchbase/custom-ports.sh
#HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:8091/pools || exit 1

CMD ["/opt/couchbase/configure-node.sh"]