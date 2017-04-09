#!/usr/bin/env bash
# Search and replace in the default SOGo template to connect to database
# and setup title and all information provided by mdata

# Receive mdata information for sieve, title and superuser
SIEVE_SERVER=${SIEVE_SERVER:-$(mdata-get sieve_server 2>/dev/null)} || \
	SIEVE_SERVER=$(mdata-get imap_server 2>/dev/null);
SOGO_TITLE=$(mdata-get sogo_title 2>/dev/null || true)
SOGO_SUPERUSER=$(mdata-get sogo_superuser 2>/dev/null || true)

# Configure SOGo PGSQL user and database
SOGO_PGSQL_DB='sogo'
SOGO_PGSQL_USER='sogo'
SOGO_PGSQL_PW=${SOGO_PGSQL_PW:-$(mdata-get sogo_pgsql_pw 2>/dev/null)} || \
	SOGO_PGSQL_PW=$(od -An -N8 -x /dev/random | head -1 | tr -d ' ');

mdata-put sogo_pgsql_pw "${SOGO_PGSQL_PW}"

log "waiting for the socket to show up"
COUNT="0";
while ! ls /tmp/.s.PGSQL.* >/dev/null 2>&1; do
	sleep 1
	((COUNT=COUNT+1))
	if [[ $COUNT -eq 60 ]]; then
		log "ERROR Could not talk to PGSQL after 60 seconds"
		ERROR=yes
		break 1
	fi
done
[[ -n "${ERROR}" ]] && exit 31
log "(it took ${COUNT} seconds to start properly)"

if ! psql -lqt -U ${SOGO_PGSQL_USER} | cut -d \| -f 1 | grep -qw ${SOGO_PGSQL_DB} 2>/dev/null; then
	sm-create-db postgresql ${SOGO_PGSQL_DB}
	sm-create-dbuser postgresql ${SOGO_PGSQL_USER} ${SOGO_PGSQL_PW} ${SOGO_PGSQL_DB}
fi

# Search and replace configuration template
gsed -i \
	-e "s/__SOGO_PGSQL_USER__/${SOGO_PGSQL_USER}/" \
	-e "s/__SOGO_PGSQL_PW__/${SOGO_PGSQL_USER}/" \
	-e "s/__SOGO_PGSQL_DB__/${SOGO_PGSQL_DB}/" \
	-e "s/__SIEVE_SERVER__/${SIEVE_SERVER}/" \
	-e "s/__SOGO_TITLE__/${SOGO_TITLE}/" \
	-e "s/__SOGO_SUPERUSER__/${SOGO_SUPERUSER}/" \
	/opt/local/etc/sogo/sogo.conf

# Install sogo_users database and cronjob for user import
psql -U ${SOGO_PGSQL_USER} -X --set ON_ERROR_STOP=on ${SOGO_PGSQL_DB} <<__SQL__
CREATE TABLE IF NOT EXISTS sogo_users
(
  c_uid character varying(512) NOT NULL,
  c_name character varying(512),
  c_password character varying(256),
  c_cn character varying(512),
  mail character varying(512),
  CONSTRAINT sogo_users_pkey PRIMARY KEY (c_uid)
)
WITH (
  OIDS=FALSE
);
__SQL__

CRON="0,5,10,15,20,25,30,35,40,45,55 * * * * /opt/core/bin/import-cron"
(crontab -l 2>/dev/null || true; echo "$CRON" ) | sort | uniq | crontab

# Use logadm for rotate the logfiles
logadm -w /var/log/sogo/sogo.log -p 1d -C 10 -N -m 640 -c

# Enable sogo service
svcadm enable svc:/www/sogo:default
