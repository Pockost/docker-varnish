FROM debian:buster

ENV VARNISH_VERSION=4.1.11

WORKDIR /varnish

RUN apt-get update && apt-get install --no-install-recommends -y \
      make \
      automake \
      autotools-dev \
      libedit-dev \
      libjemalloc-dev \
      libncurses-dev \
      libpcre3-dev \
      libtool \
      pkg-config \
      python3-docutils \
      python3-sphinx \
      cpio \
      curl \
    && curl -O https://varnish-cache.org/_downloads/varnish-$VARNISH_VERSION.tgz \
    && tar zxvf varnish-$VARNISH_VERSION.tgz \
    && cd varnish-$VARNISH_VERSION \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && mkdir /etc/varnish && cp etc/example.vcl /etc/varnish/default.vcl \
    && rm -rf /var/lib/apt/lists/* /varnish

WORKDIR /etc/varnish

EXPOSE 6081 6082

ENTRYPOINT ["/usr/local/sbin/varnishd", "-F", "-a", "0.0.0.0:6081", "-f", "/etc/varnish/default.vcl"]
