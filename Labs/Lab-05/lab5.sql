-- 1) How many customers and suppliers are in every nation from AMERICA?
SELECT n_name, COUNT(DISTINCT c_custkey), COUNT(DISTINCT s_suppkey)
FROM customer, supplier, nation, region
WHERE c_nationkey = n_nationkey
    AND s_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND r_name = "AMERICA"
GROUP by n_name;



-- 2) For every order priority, count the number of line items 
--      ordered in 1995 and received (l receiptdate) earlier than the 
--      commit date (l commitdate)
SELECT o_orderpriority, COUNT(*)
FROM orders, lineitem
WHERE o_orderkey = l_orderkey
    AND o_orderdate >= "1995-01-01"
    AND o_orderdate < "1996-01-01"
    AND l_receiptdate < l_commitdate
GROUP BY o_orderpriority;



-- 3) How many customers from every region have placed at least one order 
--      and have more than the average account balance?
SELECT r_name, COUNT(DISTINCT c_custkey)
FROM customer, region, orders, nation
WHERE c_custkey = o_custkey
    AND c_nationkey = n_nationkey
    AND n_regionkey = r_regionkey
    AND c_acctbal > (SELECT AVG(c2.c_acctbal) FROM customer c2)
GROUP BY r_name;



-- 4) Count the number of distinct suppliers that supply parts whose type 
--      contains POLISHED and have size equal to any of 10, 20, 30, or 40
SELECT COUNT(DISTINCT s_suppkey)
FROM part, supplier, partsupp
WHERE p_partkey = ps_partkey
    AND ps_suppkey = s_suppkey
    AND p_type LIKE "%POLISHED%"
    AND (p_size = 10 OR p_size = 20 OR p_size = 30 OR p_size = 40);



-- 5) Find the highest value line item(s) (l extendedprice*(1-l discount)) 
--      shipped after October 2, 1993. Print the name of the part 
--      corresponding to these line item(s)
SELECT p_name
FROM lineitem, part
WHERE l_shipdate > "1993-10-02"
    AND l_partkey = p_partkey
    AND l_extendedprice * (1 - l_discount) = 
        (SELECT MAX(l2.l_extendedprice * (1 - l2.l_discount)) FROM lineitem l2)
GROUP BY p_name;


-- 6) For parts whose type contains STEEL, return the name of the supplier 
--      from AMERICA that can supply them at maximum cost (ps supplycost), 
--      for every part size. Print the supplier name together with the part 
--      size and the maximum cost.
SELECT s_name, p_size, MAX(ps_supplycost)
FROM part, supplier, region, nation, partsupp
WHERE p_type LIKE "%STEEL%"
    AND r_name = "AMERICA"
    AND n_regionkey = r_regionkey
    AND s_nationkey = n_nationkey
    AND p_partkey = ps_partkey
    AND ps_suppkey = s_suppkey
    AND ps_supplycost =
        (SELECT MAX(ps2.ps_supplycost)
        FROM partsupp ps2, part p2, supplier s2, region r2, nation n2
        WHERE r2.r_name = "AMERICA"
            AND n2.n_regionkey = r2.r_regionkey
            AND s2.s_nationkey = n2.n_nationkey
            AND p2.p_partkey = ps2.ps_partkey
            AND ps2.ps_suppkey = s2.s_suppkey)
GROUP BY s_name;



-- 7. Print the name of the parts supplied by suppliers from FRANCE that have 
--      total value in the top 5% total values across all the supplied parts. 
--      The total value is ps supplycost*ps availqty. Hint: Use the LIMIT 
--      keyword with a SELECT subquery.



-- 8) Based on the available quantity of items, who is the manufacturer p mfgr 
--      of the most popular item (the more popular an item is, the less 
--      available it is in ps availqty) from Supplier#000000040?



-- 9) How many suppliers in every region have more balance in their account 
--      than the average account balance of their own region?



-- 10) How many customers are not from EUROPE or ASIA?



-- 11) What is the total supply cost (ps supplycost) for parts less expensive 
--      than $2000 (p retailprice) shipped in 1994 (l shipdate) by suppliers 
--      who did not supply any line item with an extended price less than 1000 
--      in 1997?

-- WITH cheap_parts_shipped_in_1994 AS (
--     SELECT p_partkey
--     FROM part, lineitem
--     WHERE p_partkey = l_partkey
--         AND p_retailprice < 2000
--         AND strftime("%Y", l_shipdate) = "1994")
--     suppliers_that_didnt_supply_cheap_parts_in_1997 AS (
--         SELECT s_suppkey
--         FROM supplier
--         EXCEPT
--         SELECT s_suppkey
--         FROM supplier, lineitem
--         WHERE s_suppkey = l_suppkey
--             AND l_extentedprice < 1000
--             AND strftime("%Y", l_shipdate) = "1997"
--         )
--     SELECT TOTAL(ps_supplycost)
--     FROM partsupp,
--         suppliers_that_didnt_supply_cheap_parts_in_1997,
--         cheap_parts_shipped_in_1994
--     WHERE ps_suppkey - s_suppkey
--         AND ps_partkey = p_partkey;



-- 12) Count the number of orders made in 1995 in which at least one line item 
--      was received (l receiptdate) by a customer later than its commit date 
--      (l commitdate). List the count of such orders for every order priority.



-- 13) For any two regions, find the gross discounted revenue 
--      (l extendedprice*(1-l discount)) derived from line items in which 
--      parts are shipped from a supplier in the first region to a customer 
--      in the second region in 1994 and 1995. List the supplier region, the 
--      customer region, the year (l shipdate), and the revenue from shipments 
--      that took place in that year.



-- 14) The market share for a given nation within a given region is defined as 
--      the fraction of the revenue from the line items ordered by customers 
--      in the given region that are supplied by suppliers from the given 
--      nation. The revenue of a line item is defined as 
--      l extendedprice*(1-l discount). Determine the market share of FRANCE 
--      in AMERICA in 1994 (l shipdate).



-- 15) For the line items ordered in October 1994 (o orderdate), find the 
--      largest discount that is smaller than the average discount among all 
--      the orders.