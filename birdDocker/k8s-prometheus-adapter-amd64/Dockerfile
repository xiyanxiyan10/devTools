#From quay.io/coreos/k8s-prometheus-adapter-amd64:v0.2.0
From quay.io/coreos/k8s-prometheus-adapter-amd64:latest


CMD mkdir /conf
COPY ./conf/ca.pem /conf/ca.pem
COPY ./conf/config /conf/config
COPY ./conf/rules.conf /conf/rules.conf
