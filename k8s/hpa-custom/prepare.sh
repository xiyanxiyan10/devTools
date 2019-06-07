cd /etc/kubernetes/ssl
openssl req -new -key serving.key -out serving.csr -subj "/CN=serving"
openssl  x509 -req -in serving.csr -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -out serving.crt -days 3650
kubectl create secret generic cm-adapter-serving-certs --from-file=serving.crt=./serving.crt --from-file=serving.key=./serving.key  -n  custom-metrics

