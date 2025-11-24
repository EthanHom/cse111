-- Create trigger to auto-fill order date with 2025-12-01

DROP TRIGGER IF EXISTS t1;

CREATE TRIGGER t1
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderdate = '2025-12-01'
    WHERE o_orderkey = NEW.o_orderkey;
END;

-- Insert orders from December 1995
INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment)
SELECT 
    o_orderkey + (SELECT MAX(o_orderkey) FROM orders WHERE o_orderdate NOT LIKE '1995-12%'),
    o_custkey,
    o_orderstatus,
    o_totalprice,
    o_orderdate,
    o_orderpriority,
    o_clerk,
    o_shippriority,
    o_comment
FROM orders
WHERE o_orderdate LIKE '1995-12%';

-- Query: Count orders from 2025
SELECT COUNT(*) as order_count
FROM orders
WHERE o_orderdate LIKE '2025%';
