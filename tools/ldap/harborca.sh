openssl genrsa -out haha.com.key 4096
openssl req -sha512 -new \
    -subj "/C=TW/ST=Taipei/L=Taipei/O=example/OU=Personal/CN=haha.com" \
    -key haha.com.key \
    -out haha.com.csr 
cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth 
subjectAltName = @alt_names
[alt_names]
DNS.1=haha.com
EOF

openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in haha.com.csr \
    -out haha.com.crt

openssl x509 -inform PEM -in haha.com.crt -out haha.com.cert

