#!/usr/bin/env bash
# Generate nginx configuration and ssl setup

# Defaults
HOST=$(hostname)
NGINX_HOME='/opt/local/etc/nginx/'
SSL_HOME=${NGINX_HOME}'ssl/'
SVC_NAME='svc:/pkgsrc/nginx:default'

# Create folder if it doesn't exists
mkdir -p "${SSL_HOME}"

# Self-signed certificate generator
/opt/core/bin/ssl-selfsigned.sh -d ${SSL_HOME} -f nginx

# Config hostname in nginx config
gsed -i "s:__HOSTNAME__:${HOST}:g" \
    ${NGINX_HOME}nginx.conf

# Enable NGINX webserver service
svcadm enable ${SVC_NAME}

# Try to provide Let's Encrypt SSL certificate
/opt/core/bin/ssl-generator.sh ${SSL_HOME} nginx_ssl nginx ${SVC_NAME}

# Restart NGINX webserver service
svcadm restart ${SVC_NAME}
