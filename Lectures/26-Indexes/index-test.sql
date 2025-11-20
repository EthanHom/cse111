--SQLite

.eqp on
.timer on
--.output out.res.noindex
.output out.res.index


.print "CREATE/DROP INDEX ind_l_quantity"
DROP INDEX lineitem_idx_l_quantity;
--CREATE INDEX lineitem_idx_l_quantity ON lineitem(l_quantity);


.print "FULL TABLE SCAN QUERY"
select l_orderkey
from lineitem;

.print "POINT QUERY"
select l_orderkey
from lineitem
where l_quantity = 10;

.print "OPEN RANGE QUERY"
select l_orderkey
from lineitem
where l_quantity < 10;

.print "CLOSED RANGE QUERY"
select l_orderkey
from lineitem
where l_quantity >= 10
    and l_quantity <= 20;
