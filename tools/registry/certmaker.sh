#make auth 
mkdir -p /auth
docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > /auth/htpasswd
mkdir -p /certs && cd /certs && openssl req -newkey rsa:2048 -nodes -sha256 -keyout registry.key -x509 -days 365 -out registry.crt


