# Start from fresh debian stretch & add some tools
FROM debian:stretch
RUN apt update && \
    apt install -y rsyslog vim nano procps curl python3 python3-yaml

# Download BI Connector to /mongosqld
WORKDIR /tmp
RUN curl -s https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian92-v2.14.0.tgz -o bi-connector.tgz && \
  sh -c 'echo "e23d467531f162c0df3f1f0d3c4878b674f15e8b4f6b3d000afc469312e852d9 bi-connector.tgz" | sha256sum --check --status' && \
  tar -xf bi-connector.tgz && rm bi-connector.tgz &&\
  mv /tmp/mongodb-bi-linux-x86_64-debian92-v2.14.0 /mongosqld

# Setup default environment variables
ENV MONGODB_HOST=mongodb MONGODB__PORT=27017 LISTEN_PORT=3307 DATABASE="" COLLECTION=""

COPY aggregate.py run_bi_connector.sh /tmp/

ENTRYPOINT [ "/tmp/run_bi_connector.sh" ]
