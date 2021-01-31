FROM alpine:3.12
RUN addgroup -S keepalived_script && adduser -D -S -G keepalived_script keepalived_script
RUN apk --no-cache add \
	gcc \
	ipset \
	ipset-dev \
	iptables \
	iptables-dev \
	libnfnetlink \
	libnfnetlink-dev \
	libgcc \
	libnl3 \
	libnl3-dev \
	libnftnl-dev \
	make \
	musl-dev \
	openssl \
	openssl-dev \
	autoconf \
	automake 

RUN wget https://www.keepalived.org/software/keepalived-2.2.1.tar.gz &&\
    tar zxvf keepalived-2.2.1.tar.gz &&\
    cd keepalived-2.2.1 && ./configure  --disable-dynamic-linking&&\
    make && make install && \
    cd .. && \
    rm -rf /keepalived* &&\ 
    apk --no-cache del \
	gcc \
	ipset-dev \
	iptables-dev \
	libnfnetlink-dev \
	libnl3-dev \
	libnftnl-dev \
	make \
	musl-dev \
	openssl-dev \
	autoconf \
	automake

CMD /usr/local/sbin/keepalived -nlf /etc/keepalived.conf
