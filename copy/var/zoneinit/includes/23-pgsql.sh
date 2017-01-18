#!/usr/bin/env bash
# Force locale to UTF-8
LC_ALL=en_US.UTF-8

PGDATA='/var/pgsql/data'

# Create only if not exists
if [ ! -d ${PGDATA} ]; then
	# Create `data` folder for the pgsql cluster
	mkdir -p ${PGDATA}
	chown postgres:postgres ${PGDATA}

	# initdb -- create a new PostgreSQL database cluster
	su postgres -c 'initdb -D /var/pgsql/data/'
fi

# Enable pgsql service
svcadm enable svc:/pkgsrc/postgresql:default
