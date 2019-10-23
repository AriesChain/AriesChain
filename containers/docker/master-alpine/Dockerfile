FROM alpine:3.7

RUN \
  apk add --update go git make gcc musl-dev linux-headers ca-certificates && \
  git clone --depth 1 --branch release/1.0.0 https://github.com/quickchainproject/quickchain && \
  (cd quickchain && make quickchain) && \
  cp quickchain/build/bin/quickchain /quickchain && \
  apk del go git make gcc musl-dev linux-headers && \
  rm -rf /quickchain && rm -rf /var/cache/apk/*

EXPOSE 8545
EXPOSE 36663

ENTRYPOINT ["quickchain"]
