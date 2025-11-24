-- Create trigger for positive balance reset

DROP TRIGGER IF EXISTS t3;

CREATE TRIGGER t3
AFTER UPDATE ON customer
FOR EACH ROW
WHEN OLD.c_acctbal < 0 AND NEW.c_acctbal >= 0
BEGIN
    UPDATE customer
    SET c_comment = 'Positive balance'
    WHERE c_custkey = NEW.c_custkey;
END;

-- Set balance to 100 for all customers in MOZAMBIQUE
UPDATE customer
SET c_acctbal = 100
WHERE c_nationkey = (SELECT n_nationkey FROM nation WHERE n_name = 'MOZAMBIQUE');

-- Query: Count customers with negative balance from AFRICA
SELECT COUNT(*) as negative_balance_count
FROM customer
WHERE c_acctbal < 0
AND c_nationkey IN (
    SELECT n_nationkey
    FROM nation
    WHERE n_regionkey = (SELECT r_regionkey FROM region WHERE r_name = 'AFRICA')
);
