FROM caddy:2.11.4-builder-alpine@sha256:2b9f32cbba6045e79212bb253f595588d20be8f7d1edf61582c519e124e0d2d8 AS builder

# https://github.com/hslatman/caddy-crowdsec-bouncer/releases/tag/v0.14.1
RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@6b35f6be25e457aa0b94e32c6ae519123e50e7b7 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@6b35f6be25e457aa0b94e32c6ae519123e50e7b7

FROM caddy:2.11.4-alpine@sha256:de23def33b17fb5d1290b0f6c2add1d70780e52341896c00a4c8a2a2fe9d355e AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
