FROM caddy:2.11.9-builder-alpine@sha256:d26fbc8a56ed8c3c1534f5573162d148ad3ed41732665da8526eb181fac0b728 AS builder

# https://github.com/hslatman/caddy-crowdsec-bouncer/releases/tag/v0.15.0
RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@4a6ce1d3094dbfd270fecf2a91aaab81663d0cb4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@4a6ce1d3094dbfd270fecf2a91aaab81663d0cb4

FROM caddy:2.11.9-alpine@sha256:0bbb055bda6793c999bde78b1b5ce3e89f829fb031af2cf50056ea1246559fee AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
