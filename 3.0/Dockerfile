FROM debian:jessie

MAINTAINER Romain THERRAT <romain42@gmail.com>
LABEL Description="Varnish 3.0 on debian:jessie"

ENV VARNISH_MAJOR=3.0

RUN PACKAGE_DEPENDENCY="\
      apt-transport-https \
      curl \
      ca-certificates \
    " \
    && apt-get update \
    && apt-get install -y $PACKAGE_DEPENDENCY \
    && curl -s https://packagecloud.io/install/repositories/varnishcache/varnish30/script.deb.sh | bash \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 6081 6082

ENTRYPOINT ["/usr/sbin/varnishd", "-F", "-a", "0.0.0.0:6081", "-f", "/etc/varnish/default.vcl"]
