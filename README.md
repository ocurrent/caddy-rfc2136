# Caddy with RFC2136 Support

This build of Caddy includes RFC2136 support.  This allows Caddy to
create the DNS record necessary to prove domain ownership for a DNS-01
challenges.

Create a `Caddyfile` as follows:

```
{
        acme_dns rfc2136 {
                key_name "<your hmac key name>"
                key_alg "hmac-sha256"
                key "<your hmac key>"
                server "<dns server ip>:53"
        }
}

your.fqdn.com {
        reverse_proxy www:8080
}
```

And a Docker compose file such as

```
version: "3.7"
services:
  caddy:
    image: caddy-rfc2136
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /etc/caddy:/etc/caddy:ro
      - caddy_data:/data
      - caddy_config:/config
  www:
    image: ocurrent/v3.ocaml.org-server:live
    sysctls:
      - 'net.ipv4.tcp_keepalive_time=60'
volumes:
  caddy_data:
  caddy_config:
```

