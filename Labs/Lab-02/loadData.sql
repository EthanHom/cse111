.mode "csv"
.separator "|"

.import data/customer.tbl customer
.import data/lineitem.tbl lineitem
.import data/nation.tbl nation
.import data/orders.tbl orders
.import data/part.tbl part
.import data/partsupp.tbl partsupp
.import data/region.tbl region
.import data/supplier.tbl supplier


-- sqlite3 tpch.sqlite < create-schema-tpch.sql
-- sqlite3 tpch.sqlite < loadData.sql

-- sqlite3 tpch.sqlite
-- sqlite> select * from region;