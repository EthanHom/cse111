-- 1
SELECT COUNT(*)
FROM lineitem
WHERE l_shipdate < l_commitdate;


-- 2
SELECT MIN(c_acctbal), MAX(c_acctbal), SUM(c_acctbal)
FROM customer 
WHERE c_mktsegment = "FURNITURE";


-- 3
SELECT c_address, c_phone, c_acctbal
FROM customer 
WHERE c_name = "Customer#000000227";


-- 4
SELECT s_name
FROM supplier 
WHERE s_acctbal > 8000;


-- 5
SELECT l_receiptdate, l_returnflag, l_extendedprice, l_tax
FROM lineitem 
WHERE l_returnflag != "Y" 
  AND l_receiptdate = "1995-09-22";


-- 6
SELECT n.n_name, SUM(s.s_acctbal)
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
GROUP BY n.n_name
ORDER BY n.n_name;


-- 7
SELECT SUM(o.o_totalprice)
FROM orders o, customer c, nation n, region r
WHERE o.o_custkey = c.c_custkey
  AND c.c_nationkey = n.n_nationkey
  AND n.n_regionkey = r.r_regionkey
  AND r.r_name = "AMERICA"
  AND o.o_orderdate >= "1995-01-01" 
  AND o.o_orderdate < "1996-01-01";


-- 8
SELECT n.n_name
FROM orders o, customer c, nation n
WHERE o.o_custkey = c.c_custkey
  AND c.c_nationkey = n.n_nationkey
  AND o.o_orderdate >= "1994-12-01"
  AND o.o_orderdate < "1995-01-01"
GROUP BY n.n_name;

-- 9
SELECT substr(l.l_receiptdate, 1, 7) AS year_month, COUNT(*)
FROM lineitem l, orders o, customer c
WHERE l.l_orderkey = o.o_orderkey
  AND o.o_custkey = c.c_custkey
  AND c.c_name = "Customer#000000227"
  GROUP BY year_month;


-- 10
SELECT s.s_name, s.s_acctbal
FROM supplier s, nation n, region r
WHERE s.s_nationkey = n.n_nationkey
  AND n.n_regionkey = r.r_regionkey  
  AND r.r_name = "ASIA"
  AND s.s_acctbal > 5000;


-- 11
SELECT COUNT(*)
FROM orders o, customer c, nation n
WHERE o.o_custkey = c.c_custkey
  AND c.c_nationkey = n.n_nationkey
  AND n.n_name = "ROMANIA"
  AND o.o_orderpriority = "1-URGENT"
  AND o.o_orderdate >= "1993-01-01"
  AND o.o_orderdate < "1998-01-01";


-- 12
SELECT substr(o.o_orderdate, 1, 4) AS year, COUNT(*)
FROM lineitem l, orders o, supplier s, nation n
WHERE l.l_orderkey = o.o_orderkey
  AND l.l_suppkey = s.s_suppkey
  AND s.s_nationkey = n.n_nationkey
  AND o.o_orderpriority = "3-MEDIUM"
  AND n.n_name IN ("ARGENTINA", "BRAZIL")
GROUP BY year;


-- 13
SELECT s.s_name, COUNT(*)
FROM lineitem l, supplier s
WHERE l.l_suppkey = s.s_suppkey
  AND l.l_discount = 0.10
GROUP BY s.s_name;


-- 14
SELECT r.r_name, COUNT(*)
FROM orders o, customer c, nation n, region r
WHERE o.o_custkey = c.c_custkey
  AND c.c_nationkey = n.n_nationkey
  AND n.n_regionkey = r.r_regionkey
  AND o.o_orderstatus = "F"
GROUP BY r.r_name;


-- 15
SELECT SUM(c.c_acctbal)
FROM customer c, nation n, region r
WHERE c.c_nationkey = n.n_nationkey
  AND n.n_regionkey = r.r_regionkey
  AND r.r_name = "AMERICA"
  AND c.c_mktsegment = "FURNITURE";