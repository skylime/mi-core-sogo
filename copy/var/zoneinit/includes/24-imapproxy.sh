#!/usr/bin/env bash
# Configure imapproxy and enable the service if possible

if mdata-get imap_server 1>/dev/null 2>&1; then
	imap_server=$(mdata-get imap_server)
	gsed -i "s:__SERVER_HOSTNAME__:${imap_server}:g" /opt/local/etc/imapproxy.conf
	svcadm enable svc:/pkgsrc/up-imapproxy:default
fi
