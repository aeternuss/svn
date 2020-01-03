# svn

Docker image with Subversion based on httpd image.

## Bug in Alpine image

The segmentation faults happens when AuthzSVNAccessFile is in the
config.

It is an issue with 3.8 and above.