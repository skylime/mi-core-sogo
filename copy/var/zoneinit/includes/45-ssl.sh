# This script will try to manage the ssl certificates for us, we support
# own ssl certificates, let's encrypt and selfsigned fallbacks for dev
# usage

# Default
SSL_HOME='/opt/local/etc/nginx/ssl/'

# Create folder if it doesn't exists
mkdir -p "${SSL_HOME}"

# Use user certificate if provided
if mdata-get sogo_ssl 1>/dev/null 2>&1; then
	mdata-get sogo_ssl > "${SSL_HOME}/nginx.pem"
else
	# Try to generate let's encrypt ssl certificate for the hostname
	/opt/core/bin/ssl-letsencrypt.sh
	# If folder doesn't exists we don't have any ssl certificate
	LE_LIVE="/opt/local/etc/letsencrypt/live/$(hostname)/"
	if [[ -d "${LE_LIVE}" ]] 1>/dev/null 2>&1; then
		# Workaround to link correct files for SSL_HOME
		ln -s ${LE_LIVE}/fullchain.pem ${SSL_HOME}/nginx.crt
		ln -s ${LE_LIVE}/privkey.pem ${SSL_HOME}/nginx.key
	else
		# Fallback to selfsigned ssl certificates
		/opt/core/bin/ssl-selfsigned.sh -d ${SSL_HOME} -f nginx
	fi
fi
