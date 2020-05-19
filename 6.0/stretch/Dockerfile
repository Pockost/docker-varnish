FROM debian:stretch

WORKDIR /root

RUN apt-get update && apt-get install --no-install-recommends -y \
      automake \
      autotools-dev \
      ca-certificates \
      graphviz \
      libedit-dev \
      libjemalloc-dev \
      libncurses-dev \
      libpcre3-dev \
      libtool \
      make \
      pkg-config \
      python-docutils \
      python-sphinx \
      wget \
    && wget https://varnish-cache.org/_downloads/varnish-6.0.0.tgz \
    && tar zxvf varnish-6.0.0.tgz \
    && cd varnish-6.0.0 \
    && sh autogen.sh \
    && sh configure \
    && make && make install \
    && cd /root

ENTRYPOINT ["/usr/local/sbin/varnishd", "-F", "-a", "0.0.0.0:6081", "-f", "/etc/varnish/default.vcl"]