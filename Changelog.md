# Changelog

## 23.4.0

### New

* SOGo 5.11.1 and PostgreSQL 14 upgrade. [Thomas Merkel]

  * Upgrade to latest SOGo Version 5.11.1 to hopefully fix the memory leak
    issue in older versions.
  * Switch to different imapproxy software, which is only able to listen
    on IPv4. Which require a modification of sogo.conf.
  * New PostgreSQL version 14 which require a manual update step with a
    database dump. See docs/ folder.


## 20.1.0

### New

* Upgrade SOGo to version 4 and PostgreSQL 9.6 to 11. [Thomas Merkel]

  Migrate to new PostgreSQL version and to new SOGo version. It require a
  manual upgrade of the database structure and schema. Please look at the
  docs/sogo-upgrade-to-pgsql-11.md guide before running any re-provision.

* Enable Vacation support by default. [Thomas Merkel]

### Fix

* Fix sogo_pgsql_pw information and configuration. [Thomas Merkel]
* Fix IPv6 listening for SOGo. [Thomas Merkel]

## 17.2.1

### Fix

- Fix sogo-user-import timeout issue. [Thomas Merkel]

## 17.2.0

### New

- Version bump to 17.2.0 (core-base) [Thomas Merkel]
- Switch to SOGo version 3.2.9. [Thomas Merkel]

  Use own SOPE package which require pgsql96
  Force nodejs to 6.11.0

## 16.4.3

### Fix

* Fix startup of pgsql and setup. [Thomas Merkel]

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
