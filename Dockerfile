FROM httpd:2.4
MAINTAINER aeternus <aeternus@aliyun.com>

## svn repositories
ENV SVN_HOME=/svn
## httpd user's config files
ENV HTTPD_CONFIG=/httpd

RUN set -ex \
  \
  && apt-get update \
  \
  ## install packages
  && apt-get install -y subversion libapache2-mod-svn \
  \
  && mkdir -p "$SVN_HOME" \
  && chown daemon:daemon "$SVN_HOME" \
  && mkdir -p "$HTTPD_CONFIG" \
  \
  ## include extra config files
  && printf "\n\n%s\n%s\n%s" \
            "## Include extra config" \
            "IncludeOptional conf/extra/nohttp-*.conf" \
            "IncludeOptional $HTTPD_CONFIG/*.conf" \
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

VOLUME $SVN_HOME
VOLUME $HTTPD_CONFIG
