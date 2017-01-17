#!/usr/bin/env bash
# Force locale to UTF-8
LC_ALL=en_US.UTF-8

# Create `data` folder for the pgsql cluster
PGDATA='/var/pgsql/data'
mkdir -p ${PGDATA}
chown postgres:postgres ${PGDATA}

# initdb -- create a new PostgreSQL database cluster
su postgres -c 'initdb -D /var/pgsql/data/'

# Configure SOGo PGSQL user and database
SOGO_PGSQL_DB='sogo'
SOGO_PGSQL_PW=${SOGO_PGSQL_PW:-$(mdata-get sogo_pgsql_pw 2>/dev/null)} || \
	SOGO_PGSQL_PW=$(od -An -N8 -x /dev/random | head -1 | tr -d ' ');
mdata-put sogo_pgsql_pw "${SOGO_PGSQL_PW}"

sm-create-db postgresql ${SOGO_PGSQL_DB}
sm-create-dbuser postgresql ${SOGO_PGSQL_DB} ${SOGO_PGSQL_PW} ${SOGO_PGSQL_DB}

# Enable pgsql service
svcadm enable svc:/pkgsrc/postgresql:default
