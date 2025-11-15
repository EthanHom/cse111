-- root@1fa26237ac8d:/workspaces/ethan/Documents/UCM/Fall2025/cse111_docker/Labs/Lab-08/lab-8# sqlite3 tpch.sqlite.base < create-index.sql; for i in {1..15}; do echo $i; sqlite3 tpch.sqlite.base < test/$i.sql; done;

-- 2
-- CREATE INDEX customer_idx_83a22bf1 ON customer(c_mktsegment);
CREATE INDEX IF NOT EXISTS customer_idx_c_mktsegment ON customer(c_mktsegment);


-- 3
-- CREATE INDEX customer_idx_00641243 ON customer(c_name);
CREATE INDEX IF NOT EXISTS customer_idx_c_name ON customer(c_name);


-- 4
-- CREATE INDEX supplier_idx_459d2434 ON supplier(s_acctbal);
CREATE INDEX IF NOT EXISTS supplier_idx_s_acctbal ON supplier(s_acctbal);


-- 5
-- CREATE INDEX lineitem_idx_d3eefa16 ON lineitem(l_receiptdate, l_returnflag);
CREATE INDEX IF NOT EXISTS lineitem_idx_l_receiptdate_returnflag ON lineitem(l_receiptdate, l_returnflag);


-- 6
-- CREATE INDEX supplier_idx_2802d374 ON supplier(s_nationkey);
CREATE INDEX IF NOT EXISTS supplier_idx_s_nationkey ON supplier(s_nationkey);
-- CREATE INDEX nation_idx_006dfb86 ON nation(n_name);
CREATE INDEX IF NOT EXISTS nation_idx_n_name ON nation(n_name);


-- 7
-- CREATE INDEX orders_idx_df288002 ON orders(o_custkey, o_orderdate);
CREATE INDEX IF NOT EXISTS orders_idx_o_custkey_orderdate ON orders(o_custkey, o_orderdate);
-- CREATE INDEX customer_idx_63d516d2 ON customer(c_nationkey, c_custkey);
CREATE INDEX IF NOT EXISTS customer_idx_c_nationkey_custkey ON customer(c_nationkey, c_custkey);
-- CREATE INDEX nation_idx_70de5dc5 ON nation(n_regionkey, n_nationkey);
CREATE INDEX IF NOT EXISTS nation_idx_n_regionkey_nationkey ON nation(n_regionkey, n_nationkey);
-- CREATE INDEX region_idx_0071962a ON region(r_name);
CREATE INDEX IF NOT EXISTS region_idx_r_name ON region(r_name);


-- 8
-- CREATE INDEX nation_idx_b5b1ecd1 ON nation(n_nationkey, n_name);
CREATE INDEX IF NOT EXISTS nation_idx_n_nationkey_name ON nation(n_nationkey, n_name);
-- CREATE INDEX customer_idx_1cb1bd02 ON customer(c_custkey);
CREATE INDEX IF NOT EXISTS customer_idx_c_custkey ON customer(c_custkey);
-- CREATE INDEX orders_idx_ef96c378 ON orders(o_orderdate);
CREATE INDEX IF NOT EXISTS orders_idx_o_orderdate ON orders(o_orderdate);


-- 9
-- CREATE INDEX lineitem_idx_d55847c0 ON lineitem(l_orderkey);
CREATE INDEX IF NOT EXISTS lineitem_idx_l_orderkey ON lineitem(l_orderkey);
-- CREATE INDEX orders_idx_a7048255 ON orders(o_custkey, o_orderkey);
CREATE INDEX IF NOT EXISTS orders_idx_o_custkey_orderkey ON orders(o_custkey, o_orderkey);
-- CREATE INDEX customer_idx_63eb5399 ON customer(c_name, c_custkey);
CREATE INDEX IF NOT EXISTS customer_idx_c_name_custkey ON customer(c_name, c_custkey);


-- 10
-- CREATE INDEX supplier_idx_aeb31094 ON supplier(s_nationkey, s_acctbal);
CREATE INDEX IF NOT EXISTS supplier_idx_s_nationkey_acctbal ON supplier(s_nationkey, s_acctbal);
-- CREATE INDEX nation_idx_70de5dc5 ON nation(n_regionkey, n_nationkey);
CREATE INDEX IF NOT EXISTS nation_idx_n_regionkey_nationkey ON nation(n_regionkey, n_nationkey);
-- CREATE INDEX region_idx_19efe394 ON region(r_name, r_regionkey);
CREATE INDEX IF NOT EXISTS region_idx_r_name_regionkey ON region(r_name, r_regionkey);


-- 11
-- CREATE INDEX customer_idx_c0dce902 ON customer(c_custkey, c_nationkey);
CREATE INDEX IF NOT EXISTS customer_idx_c_custkey_nationkey ON customer(c_custkey, c_nationkey);
-- CREATE INDEX nation_idx_a15a7a61 ON nation(n_name, n_nationkey);
CREATE INDEX IF NOT EXISTS nation_idx_n_name_nationkey ON nation(n_name, n_nationkey);
-- CREATE INDEX orders_idx_fd622bf8 ON orders(o_orderpriority, o_orderdate);
CREATE INDEX IF NOT EXISTS orders_idx_o_orderpriority_orderdate ON orders(o_orderpriority, o_orderdate);


-- 12
-- CREATE INDEX nation_idx_b5b1ecd1 ON nation(n_nationkey, n_name);
CREATE INDEX IF NOT EXISTS nation_idx_n_nationkey_name ON nation(n_nationkey, n_name);
-- CREATE INDEX supplier_idx_464097db ON supplier(s_suppkey);
CREATE INDEX IF NOT EXISTS supplier_idx_s_suppkey ON supplier(s_suppkey);
-- CREATE INDEX lineitem_idx_2dd29ce0 ON lineitem(l_orderkey, l_suppkey);
CREATE INDEX IF NOT EXISTS lineitem_idx_l_orderkey_suppkey ON lineitem(l_orderkey, l_suppkey);
-- CREATE INDEX orders_idx_aa60401b ON orders(o_orderpriority, o_orderkey);
CREATE INDEX IF NOT EXISTS orders_idx_o_orderpriority_orderkey ON orders(o_orderpriority, o_orderkey);
-- CREATE INDEX supplier_idx_af56843b ON supplier(s_nationkey, s_suppkey);
CREATE INDEX IF NOT EXISTS supplier_idx_s_nationkey_suppkey ON supplier(s_nationkey, s_suppkey);


-- 13
-- CREATE INDEX supplier_idx_4520af5a ON supplier(s_suppkey, s_name);
CREATE INDEX IF NOT EXISTS supplier_idx_s_suppkey_name ON supplier(s_suppkey, s_name);
-- CREATE INDEX lineitem_idx_d1f9c9a4 ON lineitem(l_discount);
CREATE INDEX IF NOT EXISTS lineitem_idx_l_discount ON lineitem(l_discount);


-- 14
-- CREATE INDEX region_idx_0b7b0a24 ON region(r_regionkey, r_name);
CREATE INDEX IF NOT EXISTS region_idx_r_regionkey_name ON region(r_regionkey, r_name);
-- CREATE INDEX nation_idx_18de499f ON nation(n_nationkey);
CREATE INDEX IF NOT EXISTS nation_idx_n_nationkey ON nation(n_nationkey);
-- CREATE INDEX customer_idx_1cb1bd02 ON customer(c_custkey);
CREATE INDEX IF NOT EXISTS customer_idx_c_custkey ON customer(c_custkey);
-- CREATE INDEX orders_idx_cec31706 ON orders(o_orderstatus);
CREATE INDEX IF NOT EXISTS orders_idx_o_orderstatus ON orders(o_orderstatus);


-- 15
-- CREATE INDEX nation_idx_70de5dc5 ON nation(n_regionkey, n_nationkey);
CREATE INDEX IF NOT EXISTS nation_idx_n_regionkey_nationkey ON nation(n_regionkey, n_nationkey);
-- CREATE INDEX region_idx_19efe394 ON region(r_name, r_regionkey);
CREATE INDEX IF NOT EXISTS region_idx_r_name_regionkey ON region(r_name, r_regionkey);