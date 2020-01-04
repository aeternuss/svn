# svn

Provider SVN based on HTTP(s) protocol.

## Supported tags and respective Dockerfile links

- [1.5](https://github.com/aeternuss/svn/blob/v1.5/Dockerfile)

## How to use this image

Start the container by running:

```bash
docker run -d \
    -p 8080:80 -p 8443:443 \
    -v httpdConfigDir:/httpd -v svnRepoDir:/svn
    aeternuss/svn:<tag>
```

### Ports

- 80, http protocol
- 443, https protocol

### Volumes

- /httpd

  Put your httpd config files under here with name suffix `.conf`.
  Apache httpd will load them when start.

- /svn

  Put your SVN repositories under here. One directory per repository please.

  Because Apache Httpd running as user daemon(uid=1), group daemon(gid=1) in this image, you must change the owner of repository files to it.

  ```bash
  chown 1:1 -R /svn
  ```

## Apache Httpd configuration Examples

There are some Apache Httpd configuration files in directory [examples](https://github.com/aeternuss/svn/tree/master/examples):

- httptohttps.conf

  Redirect http to https.

- svn.conf

  Serve SVN with passwd file authentication.

- svn-ldap.conf

  Serve SVN with ldap authentication.

## License

GPL 3.0
