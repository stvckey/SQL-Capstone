use chocolate_shop;

-- Call the function using SELECT. Here, we create a new customer
SELECT order_transaction("yes", "Pares", "Stuckey", NULL, 4, 10);
-- Call the function using SELECT. Here, we simply update the order and inventory table
SELECT order_transaction("no", "Pares", "Stuckey", 2, 4, 10);

-- Customers and orders tables are populated based on the transaction function being called.

insert into inventory (item_name, item_price, item_quantity) values ("Secret Stuckey Sauce", 5.00, 100);
insert into inventory (item_name, item_price, item_quantity) values ("White Chocolate", 5.00, 100);
insert into inventory (item_name, item_price, item_quantity) values ("Dark Chocolate", 4.00, 100);
insert into inventory (item_name, item_price, item_quantity) values ("Milk Chocolate", 3.00, 100);
insert into inventory (item_name, item_price, item_quantity) values ("Forbidden Chocolate", 0.50, 1000);


select * from orders;
select * from inventory;
select * from customers;