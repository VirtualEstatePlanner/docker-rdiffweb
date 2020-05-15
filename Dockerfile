FROM alpine

MAINTAINER George Georgulas IV <georgegeorgulas@gmail.com>

EXPOSE 80

RUN \
  apk --no-cache add \
    build-base \
    busybox-initscripts \
    libldap \
    linux-headers \
    openldap-dev  \
    openrc \
    py-babel \
    py-future \
    py-pip \
    py-psutil \
    py-setuptools \
    python \
    python2-dev \
    python3-dev \
    rdiff-backup \
    sqlite \
    sqlite-dev && \
  pip install rdiffweb && \
  apk --no-cache del \
    build-base \
    openldap-dev \
    python2-dev \
    python3-dev && \
  rm -rf \
    /usr/share/locale/* \
    /usr/share/man/* \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* && \
  mkdir \
    /source-data \
    /backup-data && \
  rc-update add crond

ADD rdw.conf /etc/rdiffweb/rdw.conf
VOLUME /etc/rdiffweb /source-data /backup-data

CMD ["/usr/bin/rdiffweb"]
