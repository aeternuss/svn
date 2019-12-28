FROM alpine:3.11
MAINTAINER aeternus <aeternus@aliyun.com>

RUN set -ex \
  \
  ## install httpd & subversion
  && apk add --no-cache \
    apache2 \
    apache2-utils \
    apache2-webdav \
    apache2-ssl \
    apache2-ldap \
    mod_dav_svn \
    subversion \
  \
  && rm -rf /tmp/*

EXPOSE 80 443

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
