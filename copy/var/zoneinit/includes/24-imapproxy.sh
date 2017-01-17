#!/usr/bin/env bash
# Configure imapproxy and enable the service if possible

if mdata-get imap_host 1>/dev/null 2>&1; then
	imap_host=$(mdata-get imap_host)
	gsed -i 's:__SERVER_HOSTNAME__:${imap_host}:g' /opt/local/etc/imapproxy.conf
	svcadm enable svc:/network/imapproxy:default
fi
