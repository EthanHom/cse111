-- SQLite

create view PC_Maker(model, speed, ram, hd, price, maker) as
    select PC.model, speed, ram, hd, price, maker
    from PC, Product P
    where PC.model = P.model;

with PC_Maker(model, speed, ram, hd, price, maker) as
    (select PC.model, speed, ram, hd, price, maker
    from PC, Product P
    where PC.model = P.model)
select *
from PC_Maker;


create table Flights (
    orig char(3),
    dest char(3),
    depart integer,
    arrive integer
);

insert into Flights values ('SFO', 'DEN', 930, 1230);
insert into Flights values ('SFO', 'DAL', 900, 1430);
insert into Flights values ('DEN', 'CHI', 1500, 1800);
insert into Flights values ('DEN', 'DAL', 1400, 1700);
insert into Flights values ('DAL', 'CHI', 1530, 1730);
insert into Flights values ('DAL', 'NYC', 1500, 1930);
insert into Flights values ('CHI', 'NYC', 1900, 2200);
insert into Flights values ('CHI', 'NYC', 1830, 2130);

with recursive Reaches(orig, dest) as
    (select orig, dest
    from Flights
    union
    select r.orig, f.dest
    from Reaches r, Flights f
    where r.dest = f.orig)
select *
from Reaches;

with recursive Reaches(orig, dest) as
    (select orig, dest
    from Flights
    union
    select r1.orig, r2.dest
    from Reaches r1, Reaches r2
    where r1.dest = r2.orig)
select *
from Reaches;


with recursive Reaches(orig, dest, depart, arrive) as
    (select orig, dest, depart, arrive
    from Flights
    union
    select r.orig, f.dest, r.depart, f.arrive
    from Reaches r, Flights f
    where r.dest = f.orig
        and f.depart-r.arrive >= 100)
select *
from Reaches;


with recursive Reaches(orig, dest, depart, arrive, stops) as
    (select orig, dest, depart, arrive, 0
    from Flights
    union
    select r.orig, f.dest, r.depart, f.arrive, r.stops+1
    from Reaches r, Flights f
    where r.dest = f.orig
        and f.depart-r.arrive >= 100)
select *
from Reaches
where stops >= 1
    and arrive-depart < 1000;


with recursive
    G(model_1, model_2, diff) as
        (select p1.model, p2.model, p2.price-p1.price
        from PC p1, PC p2
        where p1.price <= p2.price),

    Hops(model_1, model_2, hop) as
    (select model_1, model_2, 0
    from G
    union
    select h.model_1, G.model_2, h.hop+1
    from Hops h, G
    where h.model_2 = G.model_1
        and G.diff > 0)

select *
from Hops;


with recursive
    G(model_1, model_2, diff) as
        (select p1.model, p2.model, p2.price-p1.price
        from PC p1, PC p2
        where p1.price <= p2.price),

    Hops(model_1, model_2, hop) as
    (select model_1, model_2, 0
    from G
    union
    select h.model_1, G.model_2, h.hop+1
    from Hops h, G
    where h.model_2 = G.model_1
        and G.diff > 0)

select model_2, max(hop)+1 as rank
from Hops h
group by model_2
order by rank;


with recursive
    G(model_1, model_2, diff) as
        (select p1.model, p2.model, p2.price-p1.price
        from PC p1, PC p2
        where p1.price <= p2.price),

    Hops(model_1, model_2, hop) as
        (select model_1, model_2, 0
        from G
        union
        select h.model_1, G.model_2, h.hop+1
        from Hops h, G
        where h.model_2 = G.model_1
            and G.diff > 0),
    
    Rank(model, rnk) as
        (select model_2, max(hop)+1 as rank
        from Hops h
        group by model_2)

select p.price
from Rank r, PC p
where rnk = (select count(*)/2
            from Rank)
    and r.model = p.model;


SELECT AVG(price)
FROM (SELECT price
      FROM PC
      ORDER BY price
      LIMIT 2 - (SELECT COUNT(*) FROM PC) % 2    -- odd 1, even 2
      OFFSET (SELECT (COUNT(*) - 1) / 2
              FROM PC));
