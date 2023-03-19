FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/rfc2136@master

FROM caddy:alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
