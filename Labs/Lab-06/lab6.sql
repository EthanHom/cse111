-- 1. Find the supplier-customer pair(s) with the most expensive (o totalprice) order(s) completed (F in
-- o orderstatus). Print the supplier name, the customer name, and the total price.
SELECT s_name, c_name, o_totalprice
FROM supplier, customer, orders, lineitem
WHERE c_custkey = o_custkey
    AND l_orderkey = o_orderkey
    AND l_suppkey = s_suppkey
    AND o_orderstatus = "F"
    AND o_totalprice = (
                        SELECT MAX(o2.o_totalprice) 
                        FROM orders o2
                        WHERE o2.o_orderstatus = "F")
GROUP BY s_name, c_name, o_totalprice;


-- 2. Find how many distinct customers have at least one order supplied exclusively by suppliers from
-- AFRICA.
SELECT COUNT(DISTINCT o_custkey)
FROM orders
WHERE o_orderkey IN (
    SELECT l_orderkey
    FROM lineitem, supplier, nation, region
    WHERE s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = "AFRICA"
    AND l_suppkey = s_suppkey )
AND o_orderkey NOT IN (
    SELECT l_orderkey
    FROM lineitem, supplier, nation, region
    WHERE s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name != "AFRICA"
    AND l_suppkey = s_suppkey );


-- 3. Find the distinct parts (p name) ordered by customers from ASIA that are supplied by exactly 3 suppliers
-- from AFRICA.
SELECT DISTINCT p_name
FROM part, customer, region cr, nation cn, orders, lineitem
WHERE c_nationkey = cn.n_nationkey
    AND cn.n_regionkey = cr.r_regionkey
    AND cr.r_name = "ASIA"
    AND c_custkey = o_custkey
    AND o_orderkey = l_orderkey
    AND p_partkey = l_partkey
    AND (
        SELECT COUNT(DISTINCT s_suppkey)
        FROM partsupp, supplier, nation sn, region sr
        WHERE ps_suppkey = s_suppkey
        AND ps_partkey = p_partkey
        AND s_nationkey = sn.n_nationkey
        AND sn.n_regionkey = sr.r_regionkey
        AND sr.r_name = "AFRICA") = 3;


-- 4. Find the nation(s) with the least developed industry, i.e., selling items totaling the smallest amount of
-- money (l extendedprice) in 1994 (l shipdate).


-- 5. Find the number of customers who had at most three orders in November 1995 (o orderdate).
SELECT c_custkey
FROM customer, orders
WHERE c_custkey = o_custkey
    AND o_orderdate >= "1995-11-01"
    AND o_orderdate < "1995-12-01"
GROUP BY c_custkey
HAVING COUNT(o_orderkey) <= 3;

SELECT COUNT(*)
FROM (
        SELECT c_custkey
        FROM customer, orders
        WHERE c_custkey = o_custkey
            AND o_orderdate >= "1995-11-01"
            AND o_orderdate < "1995-12-01" 
        GROUP BY c_custkey
        HAVING COUNT(o_orderkey) <= 3 );


-- 6. Find how many suppliers from PERU supply more than 40 different parts.
SELECT COUNT(*)
FROM (
    SELECT s_suppkey
    FROM supplier, nation, partsupp
    WHERE s_nationkey = n_nationkey
        AND s_suppkey = ps_suppkey
        AND n_name = "PERU"
    GROUP BY s_suppkey
    HAVING COUNT(DISTINCT ps_partkey) > 40 );


-- 7. Find the total quantity (l quantity) of line items shipped per month (l shipdate) in 1997. Hint:
-- check function strftime to extract the month/year from a date.


-- 8. Find how many suppliers have less than 50 distinct orders from customers in EGYPT and JORDAN
-- together.


-- 9. Find how many suppliers supply the least expensive part (p retailprice).


-- 10. Find the nation(s) having customers that spend the largest amount of money (o totalprice).


-- 11. Find the region where customers spend the largest amount of money (l extendedprice) buying items
-- from suppliers in the same region.


-- 12. Find how many parts are supplied by exactly one suppliers from UNITED STATES.


-- 13. Find the nation(s) with the largest number of customers.


-- 14. Compute, for every country, the value of economic exchange, i.e., the difference between the number
-- of items from suppliers in that country sold to customers in other countries and the number of items
-- bought by local customers from foreign suppliers in 1997 (l shipdate).
SELECT exports.n_nationkey, exports.n_name, num_items_exported - num_items_imported
FROM
    (SELECT cn.n_nationkey, cn.n_name, COUNT(*) as num_items_exported
    FROM nation sn, supplier, lineitem, orders, customer, nation cn
    WHERE sn.n_nationkey = s_nationkey
        AND s_suppkey = l_suppkey
        AND l_orderkey = o_orderkey
        AND o_custkey = c_custkey
        AND c_nationkey = cn.n_nationkey
        AND sn.n_nationkey != cn.n_nationkey
        AND l_shipdate LIKE "1997%"
    GROUP BY cn.n_nationkey) AS exports,
    (SELECT cn.n_nationkey, cn.n_name, COUNT(*) as num_items_imported
    FROM nation sn, supplier, lineitem, orders, customer, nation cn
    WHERE sn.n_nationkey = s_nationkey
        AND s_suppkey = l_suppkey
        AND l_orderkey = o_orderkey
        AND o_custkey = c_custkey
        AND c_nationkey = cn.n_nationkey
        AND sn.n_nationkey != cn.n_nationkey
        AND l_shipdate LIKE "1997%"
    GROUP BY cn.n_nationkey) AS imports
WHERE exports.n_nationkey = imports.n_nationkey;


-- 15. Compute the change in the economic exchange for every country between 1996 and 1998. There should
-- be two columns in the output for every country: 1997 and 1998. Hint: use CASE to select the values
-- in the result.