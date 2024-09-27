FROM alpine:latest

RUN apk add --update-cache \
    bind-tools \
    curl \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY probe.sh probe.sh
RUN chmod u+x probe.sh

ENTRYPOINT [ "./probe.sh" ]
