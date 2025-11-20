--SQLite

.print "FULL TABLE SCAN QUERY"
.expert
select l_orderkey
from lineitem;

.print "POINT QUERY"
.expert
select l_orderkey
from lineitem
where l_quantity = 10;

.print "OPEN RANGE QUERY"
.expert
select l_orderkey
from lineitem
where l_quantity < 10;

.print "CLOSED RANGE QUERY"
.expert
select l_orderkey
from lineitem
where l_quantity >= 10
    and l_quantity <= 20;
