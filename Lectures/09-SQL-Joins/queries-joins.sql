-- SQLite

select *
from Product, PC;

select Product.model, maker, price
from Product, PC;

select P.model, maker, PC.price
from Product P, PC;


select *
from Product P, PC
where P.model = PC.model;

select
    P1.maker,
    PC.model AS pc_model,
    PC.price AS pc_price,
    L.model AS laptop_model,
    L.price AS laptop_price
from
    Product P1,
    Product P2,
    PC,
    Laptop L
where
    P1.maker = P2.maker and
    P1.model = PC.model and
    P2.model = L.model and
    PC.price > L.price;

select
    P1.maker,
    PC.model AS pc_model,
    PC.price AS pc_price,
    L.model AS laptop_model,
    L.price AS laptop_price
from
    Product P1,
    Product P2,
    PC,
    Laptop L
where
    P1.maker = P2.maker and
    P1.model = PC.model and
    P2.model = L.model and
    PC.price > L.price AND
    P1.maker = 'A';


--6.2.2 a)
select P.maker, L.speed
from Product P, Laptop L
where P.model = L.model AND
    hd >= 30;


--6.2.2 b)
    select P.model, PC.price
    from Product P, PC
    where P.model = PC.model AND
        maker = 'B'
union
    select P.model, L.price
    from Product P, Laptop L
    where P.model = L.model AND
        maker = 'B'
union
    select P.model, Pr.price
    from Product P, Printer Pr
    where P.model = Pr.model AND
        maker = 'B';

    select P.model, PC.price
    from Product P, PC
    where P.model = PC.model AND
        maker = 'C'
union
    select P.model, L.price
    from Product P, Laptop L
    where P.model = L.model AND
        maker = 'C'
union
    select P.model, Pr.price
    from Product P, Printer Pr
    where P.model = Pr.model AND
        maker = 'C';

select P.model, PC.price, L.price, Pr.price
from Product P, PC, Laptop L, Printer Pr
where maker = 'C' and
    P.model = PC.model AND
    P.model = L.model AND
    P.model = Pr.model;

select P.model, PC.price, L.price, Pr.price
from Product P, PC, Laptop L, Printer Pr
where maker = 'C' and
    (P.model = PC.model or
    P.model = L.model or
    P.model = Pr.model);
    

--6.2.2 c)
    select maker
    from Product
    where type = 'laptop'
EXCEPT
    select maker
    from Product
    where type = 'pc';


--6.2.2 d)
select PC1.hd, PC1.model, PC2.model
from PC PC1, PC PC2
where PC1.hd = PC2.hd;

select PC1.hd, PC1.model, PC2.model
from PC PC1, PC PC2
where PC1.hd = PC2.hd AND
    PC1.model <> PC2.model;

select PC1.hd, PC1.model, PC2.model
from PC PC1, PC PC2
where PC1.hd = PC2.hd AND
    PC1.model > PC2.model;

select distinct PC1.hd
from PC PC1, PC PC2
where PC1.hd = PC2.hd AND
    PC1.model > PC2.model;


--6.2.2 e)
select PC1.model as model_1, PC2.model as model_2
from PC PC1, PC PC2
where PC1.speed = PC2.speed AND
    PC1.ram = PC2.ram and
    PC1.model < PC2.model;


--6.2.2 f)
select P1.maker
from Product P1, Product P2
where P1.maker = P2.maker AND
    P1.model > P2.model AND
    ((P1.type = 'pc' and P2.type = 'pc') OR
     (P1.type = 'pc' and P2.type = 'laptop') OR
     (P1.type = 'laptop' and P2.type = 'pc') OR
     (P1.type = 'laptop' and P2.type = 'laptop'));

select distinct P1.maker
from Product P1, Product P2
where P1.maker = P2.maker AND
    P1.model > P2.model AND
    ((P1.type = 'pc' and P2.type = 'pc') OR
    (P1.type = 'pc' and P2.type = 'laptop') OR
    (P1.type = 'laptop' and P2.type = 'pc') OR
    (P1.type = 'laptop' and P2.type = 'laptop'));

select maker, count(*) as products
from Product
where type = 'pc' or type = 'laptop'
group by maker;

select maker
from Product
where type = 'pc' or type = 'laptop'
group by maker
having products >=2;


select *
from Product P, PC
where P.model = PC.model;

select *
from Product P, Laptop L
where P.model = L.model;

select distinct P1.maker
from Product P1, Product P2, PC PC1, PC PC2
where P1.model = PC1.model and
    P2.model = PC2.model AND
    P1.model > P2.model AND
    P1.maker = P2.maker and
    PC1.speed >= 2 AND
    PC2.speed >= 2;

select distinct P1.maker
from Product P1, Product P2, Laptop PC1, Laptop PC2
where P1.model = PC1.model and
    P2.model = PC2.model AND
    P1.model > P2.model AND
    P1.maker = P2.maker and
    PC1.speed >= 2 AND
    PC2.speed >= 2;

select distinct P1.maker
from Product P1, Product P2, PC PC1, Laptop PC2
where P1.model = PC1.model and
    P2.model = PC2.model AND
    P1.maker = P2.maker and
    PC1.speed >= 2 AND
    PC2.speed >= 2;

    select distinct P1.maker
    from Product P1, Product P2, PC PC1, PC PC2
    where P1.model = PC1.model and
        P2.model = PC2.model AND
        P1.model > P2.model AND
        P1.maker = P2.maker and
        PC1.speed >= 2 AND
        PC2.speed >= 2
union
    select distinct P1.maker
    from Product P1, Product P2, Laptop PC1, Laptop PC2
    where P1.model = PC1.model and
        P2.model = PC2.model AND
        P1.model > P2.model AND
        P1.maker = P2.maker and
        PC1.speed >= 2 AND
        PC2.speed >= 2
union
    select distinct P1.maker
    from Product P1, Product P2, PC PC1, Laptop PC2
    where P1.model = PC1.model and
        P2.model = PC2.model AND
        P1.maker = P2.maker and
        PC1.speed >= 2 AND
        PC2.speed >= 2;
