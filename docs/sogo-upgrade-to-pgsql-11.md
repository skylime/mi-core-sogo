A migration from PostgreSQL 9.6 to version 11 is required for this image. This adds additional downtime because a dump and restore need to be performed.

Please follow these steps to backup and restore the SOGo database files.

1. Create a backup folder in the delegate dataset and set correct permissions for the `sogo` user.

	mkdir /var/pgsql/backup
	chown sogo:sogo /var/pgsql/backup

2. Stop SOGo and switch to the `sogo` user and create a dump in the folder.

	svcadm disable sogo
	su - sogo
	pg_dump > /var/pgsql/backup/sogo.psql

3. Stop PostgreSQL and delete the complete databases.

	svcadm disable postgresql
	rm -rf /var/pgsql/data

4. Reprovision with the latest image contains PostgreSQL version 11.

	...

5. Stop SOGo again and delete all sogo relevant databases and users.

	svcadm disable sogo
	sm-remove-db postgresql sogo
	sm-remove-dbuser postgresql sogo

6. Create database and user again and restore backup.

	sm-create-db postgresql sogo
	sm-create-dbuser postgresql sogo $(mdata-get sogo_pgsql_pw) sogo
	su - sogo
	psql -f /var/pgsql/backup/sogo.psql sogo
	exit

7. Run these commands to upgrade database schema.

	tables=$(psql -t -U sogo -h 127.0.0.1 sogo -c "select split_part(c_quick_location, '/', 5) from sogo_folder_info where c_path3 = 'Contacts';")
	for table in $tables; do
		echo "ALTER TABLE $table ALTER COLUMN c_mail TYPE TEXT;"       | psql -q -e -U sogo -h 127.0.0.1 sogo
		echo "ALTER TABLE $table ADD c_hascertificate INT4 DEFAULT 0;" | psql -q -e -U sogo -h 127.0.0.1 sogo
	done

8. Start SOGo and verify everything working as expected.

	svcadm start sogo
