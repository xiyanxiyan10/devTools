docker run -v $(pwd)/ui.yml:/conf/config.yml:ro \
               -v /certs/registry.key:/certs/registry.key -v $(pwd)/db:/data \
                          -it -p 8887:8080 --link registry --name registry-web hyper/docker-registry-web
