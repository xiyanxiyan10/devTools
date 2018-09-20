#Used to create a ca for client and run a test
cp /etc/kubernetes/ssl/ca* ./
openssl genrsa -out client.key 2048
openssl req -new -key client.key -out client.csr -config csr.conf
openssl x509 -req -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out client.crt -days 10000  -extfile csr.conf
kubectl create -f user.yaml 
curl -v https://10.129.11.80:6443/  --cert ./client.crt --key ./client.key  --cacert ca.pem

# configure kubectl
cp ~/.kube/config ~/.kube/config.bak
cp ./config ~/.kube/config
kubectl switch k8s-context

