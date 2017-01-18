#!/usr/bin/env bash
# Search and replace in the default SOGo template to connect to database
# and setup title and all information provided by mdata

# Configure SOGo PGSQL user and database
SOGO_PGSQL_DB='sogo'
SOGO_PGSQL_USER='sogo'
SOGO_PGSQL_PW=${SOGO_PGSQL_PW:-$(mdata-get sogo_pgsql_pw 2>/dev/null)} || \
	SOGO_PGSQL_PW=$(od -An -N8 -x /dev/random | head -1 | tr -d ' ');

mdata-put sogo_pgsql_pw "${SOGO_PGSQL_PW}"

sm-create-db postgresql ${SOGO_PGSQL_DB}
sm-create-dbuser postgresql ${SOGO_PGSQL_USER} ${SOGO_PGSQL_PW} ${SOGO_PGSQL_DB}

