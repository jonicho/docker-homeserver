FROM caddy:2.11.9-builder-alpine@sha256:d26fbc8a56ed8c3c1534f5573162d148ad3ed41732665da8526eb181fac0b728 AS builder

# https://github.com/hslatman/caddy-crowdsec-bouncer/releases/tag/v0.14.1
RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@6b35f6be25e457aa0b94e32c6ae519123e50e7b7 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@6b35f6be25e457aa0b94e32c6ae519123e50e7b7

FROM caddy:2.11.9-alpine@sha256:0bbb055bda6793c999bde78b1b5ce3e89f829fb031af2cf50056ea1246559fee AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
