# Run innobackupex

BACKUP_PATH=/backups

innobackupex --host="$MYSQL_PORT_3306_TCP_ADDR" \
--port="$MYSQL_PORT_3306_TCP_PORT" \
--user=root \
--password="$MYSQL_ENV_MYSQL_ROOT_PASSWORD" \
$BACKUP_PATH
