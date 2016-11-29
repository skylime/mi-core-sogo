#!/bin/bash
UUID=$(mdata-get sdc:uuid)
DDS=zones/${UUID}/data

if zfs list ${DDS} 1>/dev/null 2>&1; then
	zfs create ${DDS}/pgsql || true
	zfs set mountpoint=/var/pgsql ${DDS}/pgsql
fi
