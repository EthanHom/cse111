--SQLite

select n_name, sum(o_totalprice) as tot_orders
from orders, customer, nation, region
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and o_orderdate >= '1996-01-01'
    and o_orderdate < '1997-01-01'
    and r_name = 'AMERICA'
group by n_name
order by tot_orders desc;

select c_mktsegment, sum(o_totalprice) as tot_orders
from orders, customer, nation
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and o_orderdate >= '1996-01-01'
    and o_orderdate < '1997-01-01'
    and n_name = 'UNITED STATES'
group by c_mktsegment;

select substr(o_orderdate, 6, 2) as month, sum(o_totalprice) as tot_orders
from orders, customer, nation
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and o_orderdate >= '1996-01-01'
    and o_orderdate < '1997-01-01'
    and n_name = 'UNITED STATES'
    and c_mktsegment = 'BUILDING'
group by month;

select substr(o_orderdate, 6, 2) as month, sum(o_totalprice) as tot_orders
from orders, customer, nation
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and o_orderdate >= '1996-01-01'
    and o_orderdate < '1997-01-01'
    and n_name = 'UNITED STATES'
group by month;


select
    n_name as country,
    c_mktsegment as segment,
    substr(o_orderdate, 6, 2) as month,
    sum(o_totalprice) as tot_orders
from orders, customer, nation, region
where o_custkey = c_custkey
    and c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and o_orderdate >= '1996-01-01'
    and o_orderdate < '1997-01-01'
    and r_name = 'AMERICA'
group by n_name, c_mktsegment, month;

select '*' as country, segment, month, tot_orders
from
    (select
        c_mktsegment as segment,
        substr(o_orderdate, 6, 2) as month,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by c_mktsegment, month);

select country, '*' as segment, month, tot_orders
from
    (select
        n_name as country,
        substr(o_orderdate, 6, 2) as month,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by n_name, month);

select country, segment, '*' as month, tot_orders
from
    (select
        n_name as country,
        c_mktsegment as segment,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by n_name, c_mktsegment);

select '*' as country, '*' as segment, month, tot_orders
from
    (select
        substr(o_orderdate, 6, 2) as month,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by month);

select '*' as country, segment, '*' as month, tot_orders
from
    (select
        c_mktsegment as segment,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by c_mktsegment);

select country, '*' as segment, '*' as month, tot_orders
from
    (select
        n_name as country,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by n_name);

select '*' as country, '*' as segment, '*' as month, tot_orders
from
    (select
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA');


drop table DataCube;

create table DataCube (
    country char(50),
    segment char(50),
    month char(10),
    tot_orders decimal(20,4),
    primary key (country, segment, month)
);


delete from DataCube;

insert into DataCube
    select
        n_name as country,
        c_mktsegment as segment,
        substr(o_orderdate, 6, 2) as month,
        sum(o_totalprice) as tot_orders
    from orders, customer, nation, region
    where o_custkey = c_custkey
        and c_nationkey = n_nationkey
        and n_regionkey = r_regionkey
        and o_orderdate >= '1996-01-01'
        and o_orderdate < '1997-01-01'
        and r_name = 'AMERICA'
    group by n_name, c_mktsegment, month

    union

    select '*' as country, segment, month, tot_orders
    from
        (select
            c_mktsegment as segment,
            substr(o_orderdate, 6, 2) as month,
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA'
        group by c_mktsegment, month)

    union

    select country, '*' as segment, month, tot_orders
    from
        (select
            n_name as country,
            substr(o_orderdate, 6, 2) as month,
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA'
        group by n_name, month)

    union

    select country, segment, '*' as month, tot_orders
    from
        (select
            n_name as country,
            c_mktsegment as segment,
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA'
        group by n_name, c_mktsegment)

    union

    select '*' as country, '*' as segment, month, tot_orders
    from
        (select
            substr(o_orderdate, 6, 2) as month,
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA'
        group by month)

    union

    select '*' as country, segment, '*' as month, tot_orders
    from
        (select
            c_mktsegment as segment,
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA'
        group by c_mktsegment)

    union

    select country, '*' as segment, '*' as month, tot_orders
    from
        (select
            n_name as country,
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA'
        group by n_name)

    union

    select '*' as country, '*' as segment, '*' as month, tot_orders
    from
        (select
            sum(o_totalprice) as tot_orders
        from orders, customer, nation, region
        where o_custkey = c_custkey
            and c_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and o_orderdate >= '1996-01-01'
            and o_orderdate < '1997-01-01'
            and r_name = 'AMERICA');


select country, tot_orders
from DataCube
where segment = '*'
    and month = '*'
order by tot_orders desc;

select segment, tot_orders
from DataCube
where country = 'UNITED STATES'
    and month = '*';

select month, tot_orders
from DataCube
where country = 'UNITED STATES'
    and segment = 'BUILDING';

select month, tot_orders
from DataCube
where country = 'UNITED STATES'
    and segment = '*';
