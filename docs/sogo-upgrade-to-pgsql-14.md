A migration from PostgreSQL to version 14 require some manual steps. Otherwise SOGo will not work correctly or the database service could not start.

Please follow these steps to backup, restore and upgrade your SOGo database schema.

1. Create a backup folder in the delegate dataset and set correct permissions for the `sogo` user.

  mkdir /var/pgsql/backup
  chown sogo:sogo /var/pgsql/backup

2. Stop SOGo and switch to the `sogo` user and create a dump in the folder.

  svcadm disable sogo
  su - sogo
  pg_dump > /var/pgsql/backup/dump.sql

3. Stop PostgreSQL and delete the complete databases.

  svcadm disable postgresql
  rm -rf /var/pgsql/data

4. Reprovision with the latest image contains PostgreSQL version 14. If a dump.sql file exists in the backup folder no SOGo service will start!

  ...


