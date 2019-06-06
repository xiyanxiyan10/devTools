docker stop registry
docker rm registry
docker run -d \
        -p 5000:5000 \
            --name registry \
                --restart=always \
                    -v /var/lib/registry:/var/lib/registry \
                        -v /auth:/auth \
                            -v /certs:/certs \
                                -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
                                    -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \
                                        -e REGISTRY_AUTH=htpasswd \
                                            -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
                                                -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
                                                    registry:2
























