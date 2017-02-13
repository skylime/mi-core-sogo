# mi-core-sogo

This repository is based on [Joyent mibe](https://github.com/joyent/mibe).
Please note this repository should be build with the
[mi-core-base](https://github.com/skylime/mi-core-base) mibe image.

## description

SOGo is a fully supported and trusted groupware server with a focus on
scalability and open standards. SOGo is released under the GNU GPL/LGPL
v2 and above.

SOGo provides a rich AJAX-based Web interface and supports multiple native
clients through the use of standard protocols such as CalDAV, CardDAV and
GroupDAV, as well as Microsoft ActiveSync.

## mdata variables

- `import_urls` `[*]`: list of urls that provide a json dump of mail accounts and
  aliases. The format is described in the
  [core-mailapi](https://github.com/skylime/mi-core-mailapi#legacy-json-import-format).
- `smtp_server` `[*]`: hostname of the smtp server, requires tls support by default
- `imap_server` `[*]`: hostname of the imap and sieve server, requires tls support
- `sieve_server`: hostname of the sieve server, requires tls support by default
- `sogo_ssl`: ssl certificate in pem format (certificate, key and certificate chain)
- `sogo_title`: title of the SOGo web interface
- `sogo_superuser`: email address of the SOGo admin user
- `sogo_groupware`: boolean value if groupware features are enabled, default is false

`[*]` is required to work properly.

## services

- `80/tcp`: http (redirects to https)
- `443/tcp`: https

