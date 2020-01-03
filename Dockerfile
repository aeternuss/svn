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
  ## Include required modules
  && sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
            -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
            -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
            -e 's/^#\(LoadModule .*mod_auth_digest.so\)/\1/' \
            -e 's/^#\(LoadModule .*mod_dav.so\)/\1/' \
            -e 's/^#\(LoadModule .*mod_dav_fs.so\)/\1/' \
            -e 's/^#\(LoadModule .*mod_authnz_ldap.so\)/\1/' \
            -e 's/^#\(LoadModule .*mod_ldap.so\)/\1/' \
      /usr/local/apache2/conf/httpd.conf \
  \
  ## Load Module: dav_svn_module
  && echo -ne "\n\n## Load dav_svn_module" \
              "\nLoadModule dav_svn_module modules/mod_dav_svn.so" \
              "\nLoadModule authz_svn_module modules/mod_authz_svn.so" \
              "\n\n## Include user config files" \
              "\nIncludeOptional $DATA_HOME/apache2/conf.d/*.conf" \
      >> /usr/local/apache2/conf/httpd.conf \
  \
  ## cleanup
  && apt-get clean -y \
  && apt-get autoremove -y
  && rm -rf /tmp/*

EXPOSE 80 443

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
