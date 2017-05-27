SCALE_FACTOR?=1
TABLES = customer lineitem nation orders partsupp part region supplier
TABLE_FILES = $(foreach table, $(TABLES), tpch-dbgen/$(table).tbl)

TPC-H.db: $(TABLE_FILES)
	rm -f TPC-H.db
	$(eval inst_file := $(shell mktemp -u))
	mkfifo $(inst_file)
	cat sqlite-ddl.sql > $(inst_file)
	echo '.mode csv\n.separator |' >> $(inst_file)
	for t in $(TABLES); do \
		echo -n ".import tpch-dbgen/$$t.tbl "; \
		echo $$t | tr a-z A-Z; \
	done >> $(inst_file)
	sqlite3 TPC-H.db 2>/dev/null < $(inst_file)
	rm $(inst_file)
	

$(TABLE_FILES): tpch-dbgen/dbgen
	cd tpch-dbgen && ./dbgen -f -s $(SCALE_FACTOR)

tpch-dbgen/dbgen: tpch-dbgen/makefile
	cd tpch-dbgen && $(MAKE)

clean:
	rm -rf TPC-H.db $(TABLE_FILES) tpch-dbgen/dbgen

all: TPC-H.db
