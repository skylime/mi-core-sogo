#!/usr/bin/env bash
# Configure stunnel and enable the service if possible

if mdata-get smtp_server 1>/dev/null 2>&1; then
	smtp_server=$(mdata-get smtp_server)
	gsed -i "s:__SMTP_SERVER__:${smtp_server}:g" /opt/local/etc/stunnel/smtp.conf
	svcadm enable svc:/network/stunnel:smtp
fi
