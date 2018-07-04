FROM gcr.io/google_containers/metrics-server-amd64:v0.2.1

CMD mkdir /conf
CMD ls /conf

COPY ./conf/ca.pem /conf
COPY ./conf/config /conf
CMD ls /conf
