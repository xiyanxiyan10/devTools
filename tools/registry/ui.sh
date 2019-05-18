docker run -d --restart=always -p 8080:8080 --name registry-web --link registry -e REGISTRY_URL=http://144.34.243.188:5000/v2 -e REGISTRY_NAME=localhost:5000 hyper/docker-registry-web
