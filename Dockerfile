FROM httpd:2.4
MAINTAINER aeternus <aeternus@aliyun.com>

ENV DATA_HOME=/data

RUN set -ex \
  \
  && apt-get update \
  \
  ## install packages
  && apt-get install -y \
      \
      ## subversion
      subversion \
      \
      ## apache modules, Aleady: dav, ldap, ssl
      libapache2-mod-svn \
  \
  ## data dir
  && mkdir -p "$DATA_HOME" \
  \
  ## include extra config files
  && printf "\n\n%s\n%s\n%s\n%s" \
            "## Include extra config" \
            "IncludeOptional conf/extra/nohttp-*.conf" \
            "IncludeOptional $DATA_HOME/apache2/conf.d/*.conf" \
      >> /usr/local/apache2/conf/httpd.conf \
  \
  ## cleanup
  && apt-get clean -y \
  && apt-get autoremove -y \
  && rm -rf /tmp/*

# ssl options
COPY conf/nohttp-ssl.conf /usr/local/apache2/conf/extra/nohttp-ssl.conf
# svn modules
COPY conf/nohttp-modules.conf /usr/local/apache2/conf/extra/nohttp-modules.conf

EXPOSE 80 443

VOLUME $DATA_HOME
