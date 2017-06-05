# TPCH-sqlite [![Build Status](https://travis-ci.org/lovasoa/TPCH-sqlite.svg?branch=master)](https://travis-ci.org/lovasoa/TPCH-sqlite)

This is a small shell script that generates an SQLite3 database following the [TPC-H standard](http://www.tpc.org/tpch/).
It uses the official [tpch-dbgen](https://github.com/electrum/tpch-dbgen) tool to generate the data, and then imports it into an sqlite database.

## Download the database

If you don’t want to generate the database yourself, you can download it from the **realeases** section of this github repo.

 * [TPC-H.db](https://github.com/lovasoa/TPCH-sqlite/releases/download/v1.0/TPC-H.db). This is a conforming TPC-H database with a scale factor of 1. The database file size is **1.17 GB**.
 * [TPC-H-small.db](https://github.com/lovasoa/TPCH-sqlite/releases/download/v1.0/TPC-H-small.db). This database does not conform to the standard, as it has a scale factor of 0.01, but it is much smaller: **11.6 MB**.


## How to use

Clone this repository and its submodule. Then just run `make` from the root directory of this repo. Be sure to have `sqlite3` and a C compiler installed.

```
git clone --recursive git@github.com:lovasoa/TPCH-sqlite.git
cd TPCH-sqlite
make
```

This generates an SQLite3 database under the name `TPC-H.db`.

### How to set a custom scale factor

By default, the database is generated with a scale factor of 1. You can set a different *scale factor* (**SF**) with

```
SCALE_FACTOR=10 make
```
