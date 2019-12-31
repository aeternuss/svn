FROM alpine:3.11
MAINTAINER aeternus <aeternus@aliyun.com>

RUN set -ex \
  \
  && apk add --no-cache \
    ## install httpd
    apache2 \
    apache2-utils \
    \
    ## install httpd modules
    apache2-webdav \
    apache2-ssl \
    apache2-ldap \
    mod_dav_svn \
    \
    ## install subversion
    subversion \
  \
  && rm -rf /tmp/*

# mod_dav_svn: LoadModule
ADD conf.d/dav_svn.conf /etc/apache2/conf.d/dav_svn.conf

EXPOSE 80 443

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
