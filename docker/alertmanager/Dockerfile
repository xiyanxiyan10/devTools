ARG ARCH="amd64"
ARG OS="linux"
FROM ubuntu:16.04
LABEL maintainer="The devops Authors"

#using alertmanager 0.15, dowloaded it and add patch

ARG ARCH="amd64"
ARG OS="linux"

RUN mkdir -p /project
RUN mkdir -p /etc/alertmanager/
ADD ./src/github.com/prometheus/alertmanager/examples/ha/alertmanager.yml      /etc/alertmanager

RUN apt-get update -y
RUN apt-get install -y wget 

ADD ./ /project
WORKDIR /project
RUN wget https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz
RUN tar xvf go1.12.7.linux-amd64.tar.gz
ENV GOROOT /project/go
ENV GOPATH /project
RUN ln /project/go/bin/go /bin/go

RUN go build -o alertmanager src/github.com/prometheus/alertmanager/cmd/alertmanager/main.go
RUN go build -o amtool src/github.com/prometheus/alertmanager/cmd/amtool/main.go
RUN chmod 777 alertmanager 
RUN chmod 777 amtool

RUN mv ./amtool       /bin/amtool
RUN mv ./alertmanager /bin/alertmanager

RUN mkdir -p /alertmanager && \
    chown -R nobody:nogroup /etc/alertmanager /alertmanager

USER       nobody
EXPOSE     9093
VOLUME     [ "/alertmanager" ]
WORKDIR    /alertmanager
ENTRYPOINT [ "/bin/alertmanager" ]
CMD        [ "--config.file=/etc/alertmanager/alertmanager.yml", \
             "--storage.path=/alertmanager" ]
