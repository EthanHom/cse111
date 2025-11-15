-- 1 Orders posted by customers in every country in EUROPE?
SELECT n_name, COUNT(o_orderkey)
FROM orders, customer, nation, region
WHERE o_custkey = c_custkey
  AND c_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = "EUROPE"
GROUP BY n_name;


-- 2 Number of orders posted by every customer from EGYPT in 1992
SELECT c_name, COUNT(o_orderkey)
FROM orders, customer, nation
WHERE o_custkey = c_custkey
  AND c_nationkey = n_nationkey
  AND n_name = "EGYPT"
  AND o_orderdate >= "1992-01-01"
  AND o_orderdate < "1993-01-01"
GROUP BY c_name;


-- 3 Total price paid on orders every customer from ARGENTINA in 1996
SELECT c_name, SUM(o_totalprice)
FROM orders, customer, nation
WHERE o_custkey = c_custkey
  AND c_nationkey = n_nationkey
  AND n_name = "ARGENTINA"
  AND o_orderdate >= "1996-01-01"
  AND o_orderdate < "1997-01-01"
GROUP BY c_name;


-- 4 Num of parts in %BOX% container every supplier from KENYA offers
SELECT s_name, COUNT(ps_partkey)
FROM supplier, nation, partsupp, part
WHERE s_nationkey = n_nationkey
  AND s_suppkey = ps_suppkey
  AND ps_partkey = p_partkey
  AND n_name = "KENYA"
  AND p_container LIKE "%BOX%"
GROUP BY s_name;


-- 5 Number of suppliers from ARGENTINA and BRAZIL
SELECT n_name, COUNT(*) as num_suppliers
FROM supplier, nation
WHERE s_nationkey = n_nationkey
  AND (n_name = "ARGENTINA" OR n_name = "BRAZIL")
GROUP BY n_name;


-- 6 Num of unique parts produced by every supplier in INDORNESIA at every priority
SELECT s_name, o_orderpriority, COUNT(DISTINCT l_partkey)
FROM lineitem, orders, supplier, nation
WHERE l_orderkey = o_orderkey
  AND l_suppkey = s_suppkey
  AND s_nationkey = n_nationkey
  AND n_name = "INDONESIA"
GROUP BY s_name, o_orderpriority;


-- 7 Num of orders customers in every nation AFRICA has in every status
SELECT n_name, o_orderstatus, COUNT(o_orderkey)
FROM orders, customer, nation, region
WHERE o_custkey = c_custkey
  AND c_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = "AFRICA"
GROUP BY n_name, o_orderstatus;


-- 8 Num of different order clerks suppliers in PERU worked with
SELECT COUNT(DISTINCT o_clerk)
FROM lineitem, orders, supplier, nation
WHERE l_orderkey = o_orderkey
  AND l_suppkey = s_suppkey
  AND s_nationkey = n_nationkey
  AND n_name = "PERU";


-- 9 Num of distinct orders completed in 1993 by the suppliers in every nation in AFRICA. Must be orders over 200
SELECT n_name, COUNT(DISTINCT l_orderkey) as num_orders
FROM lineitem, orders, supplier, nation, region
WHERE l_orderkey = o_orderkey
  AND l_suppkey = s_suppkey
  AND s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND r_name = "AFRICA"
  AND o_orderstatus = "F"
  AND o_orderdate >= "1993-01-01"
  AND o_orderdate < "1994-01-01"
GROUP BY n_name
HAVING num_orders > 200;


-- 10 Min and max discount for every part having ECONOMY or COPPER in its type
SELECT p_name, MIN(l_discount), MAX(l_discount)
FROM part, lineitem
WHERE p_partkey = l_partkey
  AND (p_type LIKE "%ECONOMY%" OR p_type LIKE "%COPPER%")
GROUP BY p_name;


-- 11 Num of distinct orders between customers with negative account balance and suppliers with positive account balance
SELECT COUNT(DISTINCT o_orderkey)
FROM customer, orders, lineitem, supplier
WHERE c_custkey = o_custkey
  AND o_orderkey = l_orderkey
  AND l_suppkey = s_suppkey
  AND c_acctbal < 0
  AND s_acctbal > 0;


-- 12 Maximum account balance for the suppliers in every region. Regions the maximum balance is larger than 9000.
SELECT r_name, MAX(s_acctbal) as max_acctbal
FROM supplier, nation, region
WHERE s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
GROUP BY r_regionkey
HAVING max_acctbal > 9000;


-- 13 Min total price of an order between any two regions, the suppliers are from one region and the customers are from the other region
SELECT cr.r_name, sr.r_name, MIN(o_totalprice)
FROM lineitem, orders, customer, supplier, nation cn, nation sn, region cr, region sr
WHERE l_orderkey = o_orderkey
  AND o_custkey = c_custkey
  AND l_suppkey = s_suppkey
  AND c_nationkey = cn.n_nationkey
  AND cn.n_regionkey = cr.r_regionkey
  AND s_nationkey = sn.n_nationkey
  AND sn.n_regionkey = sr.r_regionkey
  AND cr.r_name != sr.r_name
GROUP BY cr.r_name, sr.r_name;


-- 14 Num of line items supplied by suppliers in ASIA for orders made by customers in KENYA
SELECT COUNT(l_orderkey)
FROM lineitem, orders, customer, supplier, nation cn, nation sn, region sr
WHERE l_orderkey = o_orderkey
    AND o_custkey = c_custkey
    AND l_suppkey = s_suppkey
    AND c_nationkey = cn.n_nationkey
    AND s_nationkey = sn.n_nationkey
    AND sn.n_regionkey = sr.r_regionkey
    AND sr.r_name = "ASIA" 
    AND cn.n_name = "KENYA";


-- 15 The supplier with the largest account balance in every region
SELECT r_name, s_name, s_acctbal
FROM supplier, nation, region
WHERE s_nationkey = n_nationkey
  AND n_regionkey = r_regionkey
  AND s_acctbal = (
      SELECT MAX(s2.s_acctbal)
      FROM supplier s2, nation n2
      WHERE s2.s_nationkey = n2.n_nationkey
        AND n2.n_regionkey = r_regionkey
  )
ORDER BY r_name;