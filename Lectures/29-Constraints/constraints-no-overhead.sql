-- SQLite
PRAGMA foreign_keys = on;


DROP TABLE PC;
DROP TABLE Product;


CREATE TABLE Product (
    maker CHAR(32),
    model INTEGER,
    type VARCHAR(20)
);

CREATE TABLE PC (
    model INTEGER,
    speed FLOAT,
    ram INTEGER,
    hd INTEGER,
    price DECIMAL(7,2)
);


.timer on

INSERT INTO Product VALUES('A', 1001, 'pc');
INSERT INTO Product VALUES('A', 1002, 'pc');
INSERT INTO Product VALUES('A', 1003, 'pc');
INSERT INTO Product VALUES('A', 2004, 'laptop');
INSERT INTO Product VALUES('A', 2005, 'laptop');
INSERT INTO Product VALUES('A', 2006, 'laptop');

INSERT INTO Product VALUES('B', 1004, 'pc');
INSERT INTO Product VALUES('B', 1005, 'pc');
INSERT INTO Product VALUES('B', 1006, 'pc');
INSERT INTO Product VALUES('B', 2007, 'laptop');

INSERT INTO Product VALUES('C', 1007, 'pc');

INSERT INTO Product VALUES('D', 1008, 'pc');
INSERT INTO Product VALUES('D', 1009, 'pc');
INSERT INTO Product VALUES('D', 1010, 'pc');
INSERT INTO Product VALUES('D', 3004, 'printer');
INSERT INTO Product VALUES('D', 3005, 'printer');

INSERT INTO Product VALUES('E', 1011, 'pc');
INSERT INTO Product VALUES('E', 1012, 'pc');
INSERT INTO Product VALUES('E', 1013, 'pc');
INSERT INTO Product VALUES('E', 2001, 'laptop');
INSERT INTO Product VALUES('E', 2002, 'laptop');
INSERT INTO Product VALUES('E', 2003, 'laptop');
INSERT INTO Product VALUES('E', 3001, 'printer');
INSERT INTO Product VALUES('E', 3002, 'printer');
INSERT INTO Product VALUES('E', 3003, 'printer');

INSERT INTO Product VALUES('F', 2008, 'laptop');
INSERT INTO Product VALUES('F', 2009, 'laptop');

INSERT INTO Product VALUES('G', 2010, 'laptop');

INSERT INTO Product VALUES('H', 3006, 'printer');
INSERT INTO Product VALUES('H', 3007, 'printer');


INSERT INTO PC(model, speed, ram, hd, price) VALUES(1001, 2.66, 1024, 250, 2114);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1002, 2.10, 512, 250, 995);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1003, 1.42, 512, 80, 478);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1004, 2.80, 1024, 250, 649);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1005, 3.20, 512, 250, 630);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1006, 3.20, 1024, 320, 1049);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1007, 2.20, 1024, 200, 510);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1008, 2.20, 2048, 250, 770);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1009, 2.00, 1024, 250, 650);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1010, 2.80, 2048, 300, 770);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1011, 1.86, 2048, 160, 959);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1012, 2.80, 1024, 160, 649);
INSERT INTO PC(model, speed, ram, hd, price) VALUES(1013, 3.06, 512, 80, 529);
