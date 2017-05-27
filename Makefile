SCALE_FACTOR?=1

generator-binaries:
	cd tpch-dbgen && $(MAKE)

data-tables: generator-binaries
	cd tpch-dbgen && ./dbgen -f -s $(SCALE_FACTOR)
