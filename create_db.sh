#!/bin/bash

TABLES=$@
db="TPC-H.db"

rm -f "$db"

echo "Creating the database structure..." >&2
sqlite3 "$db" < sqlite-ddl.sql

echo $sqlite;

for t in $TABLES; do
	echo "Importing table '$t'..." >&2
	(
		echo ".mode csv";
		echo ".separator |";
		echo -n ".import tpch-dbgen/$t.tbl ";
		echo $t | tr a-z A-Z;
	) | sqlite3 "$db" 2>/dev/null
done
