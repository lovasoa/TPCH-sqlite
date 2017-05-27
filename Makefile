SCALE_FACTOR?=1

data-tables: generator-binaries
	cd tpch-dbgen && ./dbgen -f -s $(SCALE_FACTOR)

generator-binaries:
	cd tpch-dbgen && $(MAKE)

