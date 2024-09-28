FROM alpine:latest

RUN apk add --update-cache \
    bind-tools \
    curl \
    && rm -rf /var/cache/apk/*

COPY probe.sh /usr/local/bin/probe
RUN chmod u+x /usr/local/bin/probe

ENTRYPOINT [ "probe" ]
