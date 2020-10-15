# Start from fresh debian stretch & add some tools
# note: rsyslog & curl (openssl,etc) needed as dependencies too
FROM debian:stretch
RUN apt update
RUN apt install -y rsyslog nano curl python3 python3-yaml procps

# Download BI Connector to /mongosqld
WORKDIR /tmp
RUN curl https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian92-v2.12.0.tgz -o bi-connector.tgz && \
    tar -xvzf bi-connector.tgz && rm bi-connector.tgz && \
    mv /tmp/mongodb-bi-linux-x86_64-debian92-v2.12.0 /mongosqld

# Setup default environment variables
ENV MONGODB_HOST=mongodb MONGODB_PORT=27017 LISTEN_PORT=3307

COPY aggregate.py run_bi_connector.sh /tmp/

ENTRYPOINT [ "/tmp/run_bi_connector.sh" ]
