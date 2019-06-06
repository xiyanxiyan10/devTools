#make auth 
mkdir -p /auth
docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > /auth/htpasswd

#创建自签名根证书
#openssl req -newkey rsa:4096 -nodes -sha256 -keyout ca.key -x509 -days 365 -out ca.crt
#产生证书签名请求
#openssl req -newkey rsa:4096 -nodes -sha256 -keyout jojoquant.com.key -out jojoquant.com.csr
#为registry主机产生证书
#openssl x509 -req -days 365 -in jojoquant.com.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out jojoquant.com.crt
#openssl x509 -req -days 365 -in jojoquant.com.csr -CA ca.crt -CAkey ca.key -CAcreateserial -extfile ssl.conf -out jojoquant.com.crt
mkdir -p /certs && cd /certs && openssl req -newkey rsa:2048 -nodes -sha256 -keyout registry.key -x509 -days 365 -out registry.crt


