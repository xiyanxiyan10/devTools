docker run -d -p 443:443 \
    --restart=always \
    --name registry \
    -v /certs:/certs \
    -v /auth:/auth \
    -v /registry:/var/lib/registry \
    -e REGISTRY_HTTP_ADDR=0.0.0.0:443\
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
    -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \
    -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm"\
    -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd\
    -e "REGISTRY_AUTH=htpasswd"\
    registry:2
























