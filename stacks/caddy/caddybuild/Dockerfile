FROM caddy:2.11.3-builder-alpine@sha256:52575959b1eeee9900869325a953d71e4c521ab9102dd5cce07d429ea8246b85 AS builder

RUN xcaddy build \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@c30397c7679203a8d49da723f4acb981fe68ca1b \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec@c30397c7679203a8d49da723f4acb981fe68ca1b

FROM caddy:2.11.3-alpine@sha256:86deaf5e3d3408a6ccec08fbb79989783dd26e206ae10bcf78a801dc8c9ab794 AS caddy

WORKDIR /

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
