DATE=`date +%Y%b%d`
source ~/.bashrc  # MYSQL_USER and MYSQL_PASSWORD
mysqldump --lock-tables --add-drop-database --all-databases --add-locks --create-options --flush-logs --password=$MYSQL_PASSWORD --user=$MYSQL_USER > ~/backups/mysql_$DATE
gzip -9 ~/backups/mysql_$DATE
