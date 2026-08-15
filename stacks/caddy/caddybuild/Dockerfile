FROM caddy:2.11.4-builder-alpine@sha256:2b9994510fadb5dfa5257a5357cbe26a2c4a3298f8cc675796a6570218280ce7 AS builder

RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@6b35f6be25e457aa0b94e32c6ae519123e50e7b7 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@6b35f6be25e457aa0b94e32c6ae519123e50e7b7

FROM caddy:2.11.4-alpine@sha256:5f5c8640aae01df9654968d946d8f1a56c497f1dd5c5cda4cf95ab7c14d58648 AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
