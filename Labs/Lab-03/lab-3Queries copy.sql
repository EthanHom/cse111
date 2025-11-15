-- sqlite3 tpch.sqlite
-- .schema
-- .read lab-3Queries.sql

-- sqlite3 tpch.sqlite
-- .schema
-- .read lab-3Queries.sql

-- 1
SELECT COUNT(*) AS count_early_shipments 
FROM lineitem
WHERE l_shipdate < l_commitdate;


-- 2
SELECT 
    MIN(c_acctbal) AS min_balance,
    MAX(c_acctbal) AS max_balance, 
    SUM(c_acctbal) AS total_balance
FROM customer 
WHERE c_mktsegment = 'FURNITURE';


-- 3
SELECT c_address, c_phone, c_acctbal
FROM customer 
WHERE c_name = 'Customer#000000227';


-- 4
SELECT s_name
FROM supplier 
WHERE s_acctbal > 8000;


-- 5
SELECT l_receiptdate, l_returnflag, l_extendedprice, l_tax
FROM lineitem 
WHERE l_receiptdate = '1995-09-22' 
  AND l_returnflag != 'Y';


-- 6
SELECT n.n_name AS nation_name, SUM(s.s_acctbal) AS total_balance
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
GROUP BY n.n_name
ORDER BY n.n_name;


-- 7
SELECT SUM(o.o_totalprice) AS total_price
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey  
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AMERICA' 
  AND o.o_orderdate >= '1995-01-01' 
  AND o.o_orderdate < '1996-01-01';


-- 8
SELECT DISTINCT n.n_name
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE o.o_orderdate >= '1994-12-01' 
  AND o.o_orderdate < '1995-01-01'
ORDER BY n.n_name;


-- 9
SELECT 
    substr(l.l_receiptdate, 1, 4) AS year,
    substr(l.l_receiptdate, 6, 2) AS month, 
    COUNT(*) AS line_item_count
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN customer c ON o.o_custkey = c.c_custkey
WHERE c.c_name = 'Customer#000000227'
GROUP BY substr(l.l_receiptdate, 1, 4), substr(l.l_receiptdate, 6, 2)
ORDER BY year, month;


-- 10
SELECT s.s_name, s.s_acctbal
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey  
WHERE r.r_name = 'ASIA' 
  AND s.s_acctbal > 5000;


-- 11
SELECT COUNT(*) AS urgent_order_count
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE n.n_name = 'ROMANIA' 
  AND o.o_orderpriority = '1-URGENT'
  AND o.o_orderdate >= '1993-01-01' 
  AND o.o_orderdate < '1998-01-01';


-- 12
SELECT 
    substr(o.o_orderdate, 1, 4) AS order_year,
    COUNT(*) AS line_item_count
FROM lineitem l
JOIN orders o ON l.l_orderkey = o.o_orderkey
JOIN supplier s ON l.l_suppkey = s.s_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
WHERE o.o_orderpriority = '3-MEDIUM' 
  AND n.n_name IN ('ARGENTINA', 'BRAZIL')
GROUP BY substr(o.o_orderdate, 1, 4)
ORDER BY order_year;


-- 13
SELECT s.s_name, COUNT(*) AS discount_item_count
FROM lineitem l
JOIN supplier s ON l.l_suppkey = s.s_suppkey
WHERE l.l_discount = 0.10
GROUP BY s.s_suppkey, s.s_name
ORDER BY s.s_name;


-- 14
SELECT r.r_name AS region_name, COUNT(*) AS f_order_count
FROM orders o
JOIN customer c ON o.o_custkey = c.c_custkey
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE o.o_orderstatus = 'F'
GROUP BY r.r_name
ORDER BY r.r_name;


-- 15
SELECT SUM(c.c_acctbal) AS total_balance
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey
JOIN region r ON n.n_regionkey = r.r_regionkey
WHERE r.r_name = 'AMERICA' 
  AND c.c_mktsegment = 'FURNITURE';
