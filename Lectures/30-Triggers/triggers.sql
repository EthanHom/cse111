-- SQLite

drop table PriceRange;

create table PriceRange (
    maker CHAR(32) NOT NULL,
    type VARCHAR(20) NOT NULL,
    minPrice DECIMAL(7,2) NOT NULL,
    maxPrice DECIMAL(7,2) NOT NULL,
    PRIMARY KEY(maker, type)
);

insert into PriceRange
    select maker, type, min(price), max(price)
    from Product p, PC
    where p.model = PC.model
    group by maker, type
    UNION
    select maker, type, min(price), max(price)
    from Product p, Laptop l
    where p.model = l.model
    group by maker, type
    UNION
    select maker, p.type, min(price), max(price)
    from Product p, Printer pr
    where p.model = pr.model
    group by maker, p.type;


CREATE TRIGGER insertPC_no_exists BEFORE INSERT ON PC
FOR EACH ROW
WHEN (NOT EXISTS (
        select *
        from Product p, PriceRange pr
        where p.model = NEW.model
            and p.maker = pr.maker
            and p.type = pr.type))
BEGIN
    insert into PriceRange
        select maker, type, NEW.price, NEW.price
        from Product
        where model = NEW.model;
END;

insert into Product(model, maker, type) values(1101, 'F', 'pc');
insert into PC values(1101, 3.2, 8192, 1024, 948);


CREATE TRIGGER insertPC_min BEFORE INSERT ON PC
FOR EACH ROW
WHEN (NEW.price < (select minPrice
                  from Product p, PriceRange pr
                  where p.model = NEW.model
                    and p.maker = pr.maker
                    and p.type = pr.type))
BEGIN
    update PriceRange
    set minPrice = NEW.price
    where maker = (select maker
                  from Product p
                  where p.model = NEW.model)
        and type = (select type
                   from Product p
                   where p.model = NEW.model);
END;

insert into Product(model, maker, type) values(1102, 'F', 'pc');
insert into PC values(1102, 3.2, 8192, 1024, 938);


CREATE TRIGGER insertPC_max BEFORE INSERT ON PC
FOR EACH ROW
WHEN (NEW.price > (select maxPrice
                  from Product p, PriceRange pr
                  where p.model = NEW.model
                    and p.maker = pr.maker
                    and p.type = pr.type))
BEGIN
    update PriceRange
    set maxPrice = NEW.price
    where maker = (select maker
                  from Product p
                  where p.model = NEW.model)
        and type = (select type
                   from Product p
                   where p.model = NEW.model);
END;

insert into Product(model, maker, type) values(1103, 'F', 'pc');
insert into PC values(1103, 3.2, 8192, 1024, 958);

insert into Product(model, maker, type) values(1104, 'F', 'pc');
insert into PC values(1104, 3.2, 8192, 1024, 950);


CREATE TRIGGER updatePrinter AFTER UPDATE ON Printer
FOR EACH ROW
BEGIN
    update PriceRange
    set minPrice = (select min(price)
                    from Product p, Printer pr
                    where p.model = pr.model
                        and p.maker = (select maker
                                      from Product
                                      where model = OLD.model))
    where maker = (select maker
                  from Product p
                  where p.model = NEW.model)
        and type = (select type
                   from Product p
                   where p.model = NEW.model);

    update PriceRange
    set maxPrice = (select max(price)
                    from Product p, Printer pr
                    where p.model = pr.model
                        and p.maker = (select maker
                                      from Product
                                      where model = OLD.model))
    where maker = (select maker
                  from Product p
                  where p.model = NEW.model)
        and type = (select type
                   from Product p
                   where p.model = NEW.model);
END;

update Printer
set price = 98
where model = 3006;

update Printer
set price = 122
where model = 3004;

update Printer
set price = 95
where model = 3001;

update Printer
set price = 950
where model = 3003;

update Printer
set price = 150
where model = 3003;


CREATE TRIGGER deleteLaptop_all AFTER DELETE ON Laptop
FOR EACH ROW
WHEN (OLD.price = (select maxPrice
                  from Product p, PriceRange pr
                  where p.model = OLD.model
                    and p.maker = pr.maker
                    and p.type = pr.type)
    AND OLD.price = (select minPrice
                    from Product p, PriceRange pr
                    where p.model = OLD.model
                        and p.maker = pr.maker
                        and p.type = pr.type))
BEGIN
    delete from PriceRange
    where maker = (select maker
                  from Product p
                  where p.model = OLD.model)
        and type = (select type
                   from Product p
                   where p.model = OLD.model);
END;

delete from Laptop
where model = 2007;


CREATE TRIGGER deleteLaptop_min AFTER DELETE ON Laptop
FOR EACH ROW
WHEN (OLD.price = (select minPrice
                  from Product p, PriceRange pr
                  where p.model = OLD.model
                    and p.maker = pr.maker
                    and p.type = pr.type)
    AND OLD.price < (select maxPrice
                    from Product p, PriceRange pr
                    where p.model = OLD.model
                        and p.maker = pr.maker
                        and p.type = pr.type))
BEGIN
    update PriceRange
    set minPrice = (select min(price)
                    from Product p, Laptop l
                    where p.model = l.model
                        and p.maker = (select maker
                                      from Product
                                      where model = OLD.model))
    where maker = (select maker
                  from Product p
                  where p.model = OLD.model)
        and type = (select type
                   from Product p
                   where p.model = OLD.model);
END;

delete from Laptop
where model = 2009;


CREATE TRIGGER deleteLaptop_max AFTER DELETE ON Laptop
FOR EACH ROW
WHEN (OLD.price = (select maxPrice
                  from Product p, PriceRange pr
                  where p.model = OLD.model
                    and p.maker = pr.maker
                    and p.type = pr.type)
    AND OLD.price > (select minPrice
                    from Product p, PriceRange pr
                    where p.model = OLD.model
                        and p.maker = pr.maker
                        and p.type = pr.type))
BEGIN
    update PriceRange
    set maxPrice = (select max(price)
                    from Product p, Laptop l
                    where p.model = l.model
                        and p.maker = (select maker
                                      from Product
                                      where model = OLD.model))
    where maker = (select maker
                  from Product p
                  where p.model = OLD.model)
        and type = (select type
                   from Product p
                   where p.model = OLD.model);
END;

delete from Laptop
where model = 2001;


drop view PC_Maker;
create view PC_Maker(model, speed, ram, hd, price, maker) as
    select PC.model, speed, ram, hd, price, maker
    from PC, Product P
    where PC.model = P.model;

insert into PC_Maker
values(1108, 3.2, 8192, 1024, 2500, 'A');

CREATE TRIGGER insertPC_Maker INSTEAD OF INSERT ON PC_Maker
FOR EACH ROW
BEGIN
    insert into Product(model, maker, type)
    values(NEW.model, NEW.maker, 'pc');

    insert into PC
    values(NEW.model, NEW.speed, NEW.ram, NEW.hd, NEW.price);
END;
