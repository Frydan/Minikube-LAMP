USE webAppDB;

CREATE TABLE products(id int, price float(8,2), name varchar(30), description varchar(500));

INSERT INTO products values(1, 12.23, 'Product 1', 'A very good product');
INSERT INTO products values(2, 23.34, 'Product 2', 'Even better product!');
INSERT INTO products values(3, 34.45, 'Product 3', 'One of the best!');
INSERT INTO products values(4, 45.56, 'Product 4', 'The best we have!!');