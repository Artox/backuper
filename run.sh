#!/bin/sh

# makes dumpfile of database
# params: <resultvar> <dbhost> <dbuser> <dbpass> <dbname>
create_database_dump(){
	# retrieve parameters
	result=$1
	host=$2
	user=$3
	pass=$4
	db=$5

	# create dump file
	mysqldump --host="$host" --user="$user" --password="$pass" "$db" > out.sql

	# get timestamp of dumpfile
	# it is stored on last line of dumpfile
	timestamp=`tail -c 18 out.sql`

	# give the dump file a new, better name
	dumpfile="$db $timestamp.sql"
	mv out.sql "$dumpfile"

	eval $result="'$dumpfile'"
}

# compresses a file with gzip
# params: <resultvar> <file>
compress_file(){
	# retrieve parameters
	result=$1
	file=$2

	# compress
	gzip "$file"

	eval $result="'$file.gz'"
}

# will loop through all given databses in config file and back them up
# params: <dbcount> <backuppath>
backup_databases(){
	# retrieve parameters
	count=$1
	backupdir=$2

	# act on each database
	for i in `seq 1 $count`
	do
		# get settings for database i
		eval db=\$database_$i
		eval host=\$database_${i}_host
		eval user=\$database_${i}_user
		eval pass=\$database_${i}_pass

		# perform the backup
		create_database_dump dumpfile "$host" "$user" "$pass" "$db"
		compress_file dumpfile "$dumpfile"
		mv "$dumpfile" "$backupdir/"

		# done
		echo "Created $dumpfile"
	done
}

# here the main work is done
# load configuration
source ./config.sh

# backup databases
backup_databases $database_count "$backupdir"
