FROM alpine:edge

# For nghttp2-dev, we need this respository.
RUN echo https://dl-cdn.alpinelinux.org/alpine/edge/testing >>/etc/apk/repositories 

ENV CURL_VERSION 7.63.0

RUN apk add --update --no-cache openssl openssl-dev nghttp2-dev ca-certificates
RUN apk add --update --no-cache --virtual curldeps g++ make perl 

COPY ./curl-7.63.0.tar.gz    ./
#wget https://dl.uxnr.de/mirror/curl/curl-$CURL_VERSION.tar.gz && \
RUN tar xvf curl-$CURL_VERSION.tar.gz && \
rm curl-$CURL_VERSION.tar.gz 

RUN cd curl-$CURL_VERSION && \ 
    ./configure \
    --with-nghttp2=/usr \
    --prefix=/usr \
    --with-ssl \
    --enable-ipv6 \
    --enable-unix-sockets \
    --without-libidn \
    --disable-static \
    --disable-ldap \
    --with-pic && \
make && \
make install 
#cd / && \
#rm -r curl-$CURL_VERSION && \
#rm -r /var/cache/apk && \
#rm -r /usr/share/man && \
#apk del curldeps

#ENTRYPOINT ["curl"]
#CMD ["--help"]
