ARG ARCH="amd64"
ARG OS="linux"
FROM ubuntu
LABEL maintainer="The devops Authors"

ARG ARCH="amd64"
ARG OS="linux"

RUN sudo apt install golang-go
ADD ./ /tmp
WORKDIR /tmp
ENV GOPATH /tmp
RUN go build -o alertmanager src/github.com/prometheus/alertmanager/cmd/alertmanager/main.go
RUN go build -o amtool src/github.com/prometheus/alertmanager/cmd/amtool/main.go
RUN chmod 777 alertmanager 
RUN chmod 777 amtool

RUN mv ./amtool       /bin/amtool
RUN mv ./alertmanager /bin/alertmanager
RUN mkdir -p /etc/alertmanager/
RUN cp src/github.com/prometheus/alertmanager/examples/ha/alertmanager.yml      /etc/alertmanager/alertmanager.yml

RUN mkdir -p /alertmanager && \
    chown -R nobody:nogroup etc/alertmanager /alertmanager

USER       nobody
EXPOSE     9093
VOLUME     [ "/alertmanager" ]
WORKDIR    /alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "--config.file=/etc/alertmanager/alertmanager.yml", \
             "--storage.path=/alertmanager" ]
