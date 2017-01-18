#!/usr/bin/env bash
# Search and replace in the default SOGo template to connect to database
# and setup title and all information provided by mdata

# Receive mdata information for sieve, title and superuser
SIEVE_SERVER=$(mdata-get imap_server 2>/dev/null)
SOGO_TITLE=$(mdata-get sogo_title 2>/dev/null)
SOGO_SUPERUSER=$(mdata-get sogo_superuser 2>/dev/null)

# Configure SOGo PGSQL user and database
SOGO_PGSQL_DB='sogo'
SOGO_PGSQL_USER='sogo'
SOGO_PGSQL_PW=${SOGO_PGSQL_PW:-$(mdata-get sogo_pgsql_pw 2>/dev/null)} || \
	SOGO_PGSQL_PW=$(od -An -N8 -x /dev/random | head -1 | tr -d ' ');

mdata-put sogo_pgsql_pw "${SOGO_PGSQL_PW}"

sm-create-db postgresql ${SOGO_PGSQL_DB}
sm-create-dbuser postgresql ${SOGO_PGSQL_USER} ${SOGO_PGSQL_PW} ${SOGO_PGSQL_DB}

# Search and replace configuration template
gsed -i \
	-e "s/__SOGO_PGSQL_USER__/${SOGO_PGSQL_USER}/" \
	-e "s/__SOGO_PGSQL_PW__/${SOGO_PGSQL_USER}/" \
	-e "s/__SOGO_PGSQL_DB__/${SOGO_PGSQL_DB}/" \
	-e "s/__SIEVE_SERVER__/${SIEVE_SERVER}/" \
	-e "s/__SOGO_TITLE__/${SOGO_TITLE}/" \
	-e "s/__SOGO_SUPERUSER__/${SOGO_SUPERUSER}/"
	/opt/local/etc/sogo/sogo.conf
