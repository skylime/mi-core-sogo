# Generate hostname for nginx config

HOST=$(hostname)
NGINX_HOME='/opt/local/etc/nginx/'

# Config hostname in nginx config
gsed -i "s:__HOSTNAME__:${HOST}:g" \
	${NGINX_HOME}nginx.conf

# SSL
if mdata-get sogo_ssl 1>/dev/null 2>&1; then
	mdata-get sogo_ssl > ${NGINX_HOME}ssl/nginx.pem
else
	openssl req -newkey rsa:2048 -keyout ${NGINX_HOME}ssl/nginx.key \
				-out ${NGINX_HOME}ssl/nginx.csr -nodes \
				-subj "/C=DE/L=Raindbow City/O=Aperture Science/OU=Please use valid ssl certificate/CN=${HOST}"
	openssl x509 -in ${NGINX_HOME}ssl/nginx.csr -out ${NGINX_HOME}ssl/nginx.crt -req -signkey ${NGINX_HOME}ssl/nginx.key -days 128
	cat ${NGINX_HOME}ssl/nginx.crt ${NGINX_HOME}ssl/nginx.key > ${NGINX_HOME}ssl/nginx.pem
fi
chmod 400 ${NGINX_HOME}ssl/nginx.pem

# Enable nginx
svcadm enable svc:/pkgsrc/nginx:default
