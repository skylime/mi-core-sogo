# This script will try to manage the ssl certificates for us, we support
# own ssl certificates, let's encrypt and selfsigned fallbacks for dev
# usage

# Default
SSL_HOME='/opt/local/etc/nginx/ssl/'

# Create folder if it doesn't exists
mkdir -p "${SSL_HOME}"

# Use user certificate if provided
if mdata-get sogo_ssl 1>/dev/null 2>&1; then
	(
	umask 0077
	mdata-get sogo_ssl > "${SSL_HOME}/nginx.pem"
	# Split files for nginx usage
	openssl pkey -in "${SSL_HOME}/nginx.pem" -out "${SSL_HOME}/nginx.key"
	openssl crl2pkcs7 -nocrl -certfile "${SSL_HOME}/nginx.pem" | \
		openssl pkcs7 -print_certs -out "${SSL_HOME}/nginx.crt"
	)
else
	# Try to generate let's encrypt ssl certificate for the hostname
	if /opt/core/bin/ssl-letsencrypt.sh 1>/dev/null; then
		LE_HOME='/opt/local/etc/letsencrypt/'
		LE_LIVE="${LE_HOME}live/$(hostname)/"
		# Workaround to link correct files for SSL_HOME
		ln -s ${LE_LIVE}/fullchain.pem ${SSL_HOME}/nginx.crt
		ln -s ${LE_LIVE}/privkey.pem ${SSL_HOME}/nginx.key
		# Update renew-hook.sh
		echo '#!/usr/bin/env bash' > ${LE_HOME}renew-hook.sh
		echo 'svcadm restart svc:/pkgsrc/nginx:default' >> ${LE_HOME}renew-hook.sh
	else
		# Fallback to selfsigned ssl certificates
		/opt/core/bin/ssl-selfsigned.sh -d ${SSL_HOME} -f nginx
	fi
fi
