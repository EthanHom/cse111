-- Create cascade delete trigger for parts

DROP TRIGGER IF EXISTS t5;

CREATE TRIGGER t5
BEFORE DELETE ON part
FOR EACH ROW
BEGIN
    DELETE FROM partsupp
    WHERE ps_partkey = OLD.p_partkey;

    DELETE FROM lineitem
    WHERE l_partkey = OLD.p_partkey;
END;

-- Delete all parts supplied by suppliers from KENYA or MOROCCO
DELETE FROM part
WHERE p_partkey IN (
    SELECT DISTINCT ps_partkey
    FROM partsupp
    JOIN supplier ON ps_suppkey = s_suppkey
    JOIN nation ON s_nationkey = n_nationkey
    WHERE n_name IN ('KENYA', 'MOROCCO')
);

-- Query: Count parts per supplier in AFRICA grouped by country
SELECT n_name as country, COUNT(*) as part_count
FROM partsupp
JOIN supplier ON ps_suppkey = s_suppkey
JOIN nation ON s_nationkey = n_nationkey
WHERE n_regionkey = (SELECT r_regionkey FROM region WHERE r_name = 'AFRICA')
GROUP BY n_name
ORDER BY n_name ASC;
