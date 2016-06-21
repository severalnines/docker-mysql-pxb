# MySQL with Percona Xtrabackup Docker images

Derived from MySQL image build and maintained by official Docker. The image contains Percona Xtrabackup installed and a simple bash script to run the backup command.

# How to use this image?

To run the backup, link it to the running MySQL container and ensure to map the following volumes correctly:

- MySQL datadir: /var/lib/mysql
- Backup destination: /backups

## Example

Suppose you have a MySQL container running named mysql-server, ran with following command:

```bash
$ docker run -d \
--name=mysql-server \
-v /storage/mysql-server/datadir:/var/lib/mysql \
-e MySQL_ROOT_PASSWORD=mypassword \
mysql
```

Then, to perform backup against the above container, the command would be:

```bash
$ docker run -it \
--link mysql-server:mysql \
-v /storage/mysql-server/datadir:/var/lib/mysql \
-v /storage/backups:/backups \
--rm=true \
severalnines/mysql-pxb \
sh -c 'exec /run_backup.sh'
```

You should see Xtrabackup output on the screen. Ensure you get the “completed OK” line indicating the backup is successfully created:

```bash
...
innobackupex: Backup created in directory '/backups/2016-06-17_17-07-54'
160617 17:07:57  innobackupex: Connection to database server closed
160617 17:07:57  innobackupex: completed OK!
```

The container will then exit (we ran the image interactively) and automatically removed by Docker since we specified “--rm=true” in the “run” command line. On the machine host, we can see the backups are there:

```bash
$ ls -1 /storage/backups/
2016-06-17_13-01-58
2016-06-17_13-07-28
2016-06-17_14-02-50
```

