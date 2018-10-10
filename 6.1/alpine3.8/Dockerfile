FROM alpine:3.8

RUN apk add --no-cache automake libtool autoconf pkgconfig g++ py-docutils \
    py-sphinx pcre-dev readline-dev libedit-dev ncurses-dev libexecinfo-dev linux-headers \
    && wget https://github.com/varnishcache/varnish-cache/archive/varnish-6.1.0.tar.gz \
    && tar -xzvf varnish-6.1.0.tar.gz \
    && cd varnish-cache-varnish-6.1.0 \
    && sh autogen.sh \
    && sh configure --enable-static --disable-shared \
    && make

FROM alpine:3.8

RUN apk add --no-cache pcre libexecinfo gcc libc-dev \
    && mkdir -p /usr/local/var/varnish \
    && mkdir -p /etc/varnish

COPY --from=0 /varnish-cache-varnish-6.1.0/bin/varnishd/varnishd /usr/local/sbin/varnishd

COPY --from=0 /varnish-cache-varnish-6.1.0/etc/example.vcl /etc/varnish/default.vcl

ENTRYPOINT ["/usr/local/sbin/varnishd", "-F", "-a", "0.0.0.0:6081", "-f", "/etc/varnish/default.vcl"]
