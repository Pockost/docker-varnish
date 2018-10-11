FROM alpine:3.8

RUN apk add --no-cache automake libtool autoconf pkgconfig g++ py-docutils \
    py-sphinx pcre-dev readline-dev libedit-dev ncurses-dev libexecinfo-dev linux-headers \
    && wget https://github.com/varnishcache/varnish-cache/archive/varnish-6.1.0.tar.gz \
    && tar -xzvf varnish-6.1.0.tar.gz \
    && cd varnish-cache-varnish-6.1.0 \
    && sh autogen.sh \
    && sh configure --prefix=/usr --localstatedir=/var/lib --enable-static \
    && make \
    && make install

FROM alpine:3.8

RUN apk add --no-cache pcre libexecinfo gcc libc-dev \
    && mkdir -p /var/lib/varnish /etc/varnish /etc/template

COPY --from=0 /usr/sbin/varnishd /usr/sbin/varnishd
COPY --from=0 /usr/bin/varnishadm /usr/bin/varnishadm
COPY --from=0 /usr/bin/varnishhist /usr/bin/varnishhist
COPY --from=0 /usr/bin/varnishlog /usr/bin/varnishlog
COPY --from=0 /usr/bin/varnishncsa /usr/bin/varnishncsa
COPY --from=0 /usr/bin/varnishstat /usr/bin/varnishstat
COPY --from=0 /usr/bin/varnishtest /usr/bin/varnishtest
COPY --from=0 /usr/bin/varnishtop /usr/bin/varnishtop
COPY --from=0 /usr/lib/varnish/ /usr/lib/varnish/
COPY --from=0 /usr/lib/libedit.so.0.0.56 /usr/lib/
COPY --from=0 /usr/lib/libvarnishapi.so.2.0.0 /usr/lib/
COPY --from=0 /usr/lib/libncursesw.so.6.1 /usr/lib/
COPY default.vcl /etc/template/default.vcl
COPY default.vcl /etc/varnish/default.vcl
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN ln -s /usr/lib/libvarnishapi.so.2.0.0 /usr/lib/libvarnishapi.so \
 && ln -s /usr/lib/libvarnishapi.so.2.0.0 /usr/lib/libvarnishapi.so.2 \
 && ln -s /usr/lib/libedit.so.0.0.56 /usr/lib/libedit.so.0 \
 && ln -s /usr/lib/libedit.so.0.0.56 /usr/lib/libedit.so \
 && ln -s /usr/lib/libncursesw.so.6.1 /usr/lib/libncursesw.so.6 \
 && ln -s /usr/lib/libncursesw.so.6.1 /usr/lib/libncursesw.so

EXPOSE 6081

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/sbin/varnishd", "-F", "-a", "0.0.0.0:6081", "-f", "/etc/varnish/default.vcl"]
