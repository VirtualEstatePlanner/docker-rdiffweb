FROM alpine

MAINTAINER George Georgulas IV <georgegeorgulas@gmail.com>

RUN \
	apk --no-cache add \
    build-base \
    libldap \
		linux-headers \
    openldap-dev \
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
    /backup-data
    
ADD rdw.conf /etc/rdiffweb/rdw.conf

VOLUME ["/etc/rdiffweb", "/source-data", "/backup-data"]

EXPOSE 80

CMD ["/usr/bin/rdiffweb"]
