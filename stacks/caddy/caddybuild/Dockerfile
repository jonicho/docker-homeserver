FROM caddy:2.11.9-builder-alpine@sha256:646fee578e680989ca5c7fd1ce6f1de574d19fd71ef2221810cc0510a9f40c86 AS builder

# https://github.com/hslatman/caddy-crowdsec-bouncer/releases/tag/v0.15.0
RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@4a6ce1d3094dbfd270fecf2a91aaab81663d0cb4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@4a6ce1d3094dbfd270fecf2a91aaab81663d0cb4

FROM caddy:2.11.9-alpine@sha256:003a97808e781aa9f7e75cc2f43d34d461099031faf5e20faefb9f61126836f0 AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
