#!/usr/bin/env bash

TABLES=$@
db="TPC-H.db"

if [ -z "$TABLES" ]; then
	echo "Error! No table specified." >&2
	echo "Usage: $0 [TABLE_NAME] [TABLE_NAME]..." >&2
	exit 1
fi

rm -f "$db"

echo "Creating the database structure..." >&2
sqlite3 "$db" < sqlite-ddl.sql

errfile=$(mktemp)
RET_CODE=0
for table in $TABLES; do
	echo "Importing table '$table'..." >&2
	data_file="tpch-dbgen/$table.tbl"
	if [ ! -e "$data_file" ]; then
		echo "'$data_file' does’nt exist. Skipping..." >&2
		RET_CODE=1
		continue
	fi

	(
		echo ".mode csv";
		echo ".separator |";
		echo -n ".import $data_file ";
		echo $table | tr a-z A-Z;
	) | sqlite3 "$db" 2>$errfile

	if [ $? != 0 ]; then
		echo "Import failed." >&2
		cat $errfile >&2
		RET_CODE=1
	fi
done
rm $errfile

exit $RET_CODE
