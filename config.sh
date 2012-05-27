#!/bin/sh
# config file for backups

# backup location
backupdir=/opt/backups

# which databases to back up
# each db should have the following lines:
# database_<i>=<name>
# database_<i>_host=<host>
# database_<i>_user=<user>
# database_<i>_pass=<pass>
# where i is unique for every database and starts with 1
# be sure to set database_count correct (to the highest i)
database_count=1
database_1=mydb
database_1_host=myhost
database_1_user=myuser
database_1_pass=mypass

# which files to back up
#
file_count=1
file_1=<yourfile>
