FROM httpd:2.4
MAINTAINER aeternus <aeternus@aliyun.com>

ENV DATA_HOME=/data

RUN set -ex \
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
  ## include user config files
  && printf "\n\n## Load Required Modules\nInclude conf/extra/required-modules.conf\n" \
      >> /usr/local/apache2/conf/httpd.conf \
  && printf "\n\n## Include user config files\nIncludeOptional $DATA_HOME/apache2/conf.d/*.conf\n" \
      >> /usr/local/apache2/conf/httpd.conf \
  \
  ## cleanup
  && apt-get clean \
  && apt-get autoremove

# mod_dav_svn: LoadModule
ADD conf.d/required-modules.conf /usr/local/apache2/conf/extra/required-modules.conf

EXPOSE 80 443

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
