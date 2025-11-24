-- Create triggers for HIGH priority on lineitem changes

DROP TRIGGER IF EXISTS t4_insert;
DROP TRIGGER IF EXISTS t4_delete;

CREATE TRIGGER t4_insert
AFTER INSERT ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE o_orderkey = NEW.l_orderkey;
END;

CREATE TRIGGER t4_delete
AFTER DELETE ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = 'HIGH'
    WHERE o_orderkey = OLD.l_orderkey;
END;

-- Delete all line items corresponding to orders from December 1995
DELETE FROM lineitem
WHERE l_orderkey IN (
    SELECT o_orderkey
    FROM orders
    WHERE o_orderdate LIKE '1995-12%'
);

-- Query: Count HIGH priority orders from September-December 1995
SELECT COUNT(*) as high_priority_count
FROM orders
WHERE o_orderpriority = 'HIGH'
AND o_orderdate >= '1995-09-01'
AND o_orderdate < '1996-01-01';
