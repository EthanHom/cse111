-- Create trigger for negative balance warning

DROP TRIGGER IF EXISTS t2;

CREATE TRIGGER t2
AFTER UPDATE ON customer
FOR EACH ROW
WHEN OLD.c_acctbal >= 0 AND NEW.c_acctbal < 0
BEGIN
    UPDATE customer
    SET c_comment = 'Negative balance!!!'
    WHERE c_custkey = NEW.c_custkey;
END;

-- Set balance to -100 for all customers in AFRICA
UPDATE customer
SET c_acctbal = -100
WHERE c_nationkey IN (
    SELECT n_nationkey
    FROM nation
    WHERE n_regionkey = (SELECT r_regionkey FROM region WHERE r_name = 'AFRICA')
);

-- Query: Count customers with negative balance from EGYPT
SELECT COUNT(*) as negative_balance_count
FROM customer
WHERE c_acctbal < 0
AND c_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = 'EGYPT');
