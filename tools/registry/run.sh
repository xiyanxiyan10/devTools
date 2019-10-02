docker stop registry
docker rm registry
docker run -d -p 443:443 --restart=always --name registry -v /certs:/certs -e REGISTRY_HTTP_ADDR=0.0.0.0:443 -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key registry:2
























