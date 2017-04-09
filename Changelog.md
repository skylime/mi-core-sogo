# Changelog

## 16.4.2

### Fix

* Add check for PGSQL Socket. [Thomas Merkel]
* Fix if sogo database already exists. [Thomas Merkel]

## 16.4.1

### New

* Switch to better Let&#x27;s Encrypt handling. [Thomas Merkel]

  This change require the newest version of core-base with the ssl-letsencrypt.sh script available with the TYPE parameter. For now we create a self-signed SSL certificate by default, after that we will try to find a cert by mdata and if that doesn&#x27;t work we run Let&#x27;s Encrypt.

  With this change we switch to webroot authentication from Let&#x27;s Encrypt, because a Standalone option is not working if a web server is already running.

### Fix

* Add well known urls for cal and carddav. [Thomas Merkel]
* Provide extra mdata information with the hostname of sieve servers. [Thomas Merkel]
* Fix issue with zip command in SOGo. [Thomas Merkel]

## 16.4.0

### New

* Hello sogo. [Sebastian Wiedenroth]

### Other

* Extract key, cert, chain with OpenSSL. [Thomas Merkel]
* Support Let&#x27;s Encrypt. [Thomas Merkel]
* Add logadm to rotate every day and save 10. [Thomas Merkel]
* Add cron and database for kumquat user import. [Thomas Merkel]
* Add SOGo nginx configuration and setup script. [Thomas Merkel]
* Enable memcached by default. [Thomas Merkel]
* Add template configuration for SoGO3. [Thomas Merkel]
* Add sogo-user-import. [Thomas Merkel]
* Add CustomModification.js for sogo. [Thomas Merkel]
* Add stunnel configuration and manifest. [Thomas Merkel]
* Add imapproxy with default configuration file. [Thomas Merkel]
