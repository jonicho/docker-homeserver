FROM caddy:2.11.7-builder-alpine@sha256:95a5e7e2692b5eb9545aadc5b90a39f6f509bee59c9508a493f83ee902eaef63 AS builder

# https://github.com/hslatman/caddy-crowdsec-bouncer/releases/tag/v0.14.1
RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@6b35f6be25e457aa0b94e32c6ae519123e50e7b7 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@6b35f6be25e457aa0b94e32c6ae519123e50e7b7

FROM caddy:2.11.7-alpine@sha256:e70b164da81ef698b3ad19af799ea6086ce6d9e48ed4079eb9fe26f6fbf14ee5 AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
