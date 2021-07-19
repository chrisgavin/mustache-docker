FROM alpine AS builder
ARG VERSION
RUN apk --no-cache add curl
RUN curl --location --fail --output ./mustache.tar.gz "https://github.com/cbroglie/mustache/releases/download/v${VERSION}/mustache_${VERSION}_linux_amd64.tar.gz"
RUN tar -xf ./mustache.tar.gz

FROM scratch
LABEL org.opencontainers.image.source=https://github.com/chrisgavin/mustache-docker/
COPY --from=builder ./mustache /mustache
VOLUME /data/
WORKDIR /data/
ENTRYPOINT ["/mustache"]
