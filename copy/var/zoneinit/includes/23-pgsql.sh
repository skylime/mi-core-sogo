#!/usr/bin/env bash
# Force locale to UTF-8
LC_ALL=en_US.UTF-8

# Create `data` folder for the pgsql cluster
PGDATA='/var/pgsql/data'
mkdir -p ${PGDATA}
chown postgres:postgres ${PGDATA}

# initdb -- create a new PostgreSQL database cluster
su postgres -c 'initdb -D /var/pgsql/data/'

# Enable pgsql service
svcadm enable svc:/pkgsrc/postgresql:default
