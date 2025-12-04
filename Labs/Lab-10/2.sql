-- Create a trigger t2 that sets a warning Negative balance!!! 
-- in the comment attribute of the customer table every time c acctbal is updated to a negative value from a positive one. 
DROP TRIGGER IF EXISTS t2;

CREATE TRIGGER t2
AFTER UPDATE ON customer
FOR EACH ROW
WHEN NEW.c_acctbal < 0 AND OLD.c_acctbal >= 0
BEGIN
    UPDATE customer
    SET c_comment = 'Negative balance!!!'
    WHERE c_custkey = NEW.c_custkey;
END;

-- Write a SQL statement that sets the balance to -100 for all the customers in AFRICA. 
UPDATE customer
SET c_acctbal = -100
FROM nation, region
WHERE n_regionkey = r_regionkey
AND r_name = 'AFRICA'
AND c_nationkey = n_nationkey;

-- WHERE c_nationkey = (
--     SELECT n_nationkey
--     FROM nation , region
--     WHERE n_regionkey = r_regionkey
--     AND r_name = 'AFRICA'
-- );

-- Write a query that returns the number of customers with negative balance from EGYPT.
SELECT COUNT(*)
FROM customer c
JOIN nation n ON c.c_nationkey = n.n_nationkey
WHERE c.c_acctbal < 0 
    AND n.n_name = 'EGYPT';