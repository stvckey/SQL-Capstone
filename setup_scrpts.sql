CREATE SCHEMA chocolate_shop;

-- Creating roles and permissions
CREATE ROLE manager;
GRANT ALL PRIVILEGES ON chocolate_shop.* TO manager;

CREATE ROLE employee;
GRANT EXECUTE ON FUNCTION chocolate_shop.order_transaction TO employee;
GRANT EXECUTE ON FUNCTION chocolate_shop.inventory_refill TO employee;

-- Manager is automatically local host, but employees can create accounts and gain permissions
GRANT manager TO 'root'@'localhost';
GRANT employee TO 'employee_username'@'localhost';

-- Removing excess permissions from employess. They should only have access to placing orders for
-- customers and inventory refills.
REVOKE UPDATE, DELETE, ALTER ON chocolate_shop.* FROM employee;


USE chocolate_shop;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    full_name VARCHAR(50) AS (concat(first_name, " ", last_name)) UNIQUE
);

CREATE TABLE inventory (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(20) UNIQUE NOT NULL,
    item_price DECIMAL(3 , 2 ) NOT NULL,
    item_quantity INT NOT NULL,
    CONSTRAINT check_quantity_non_neg CHECK (item_quantity >= 0)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    item_quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),
    FOREIGN KEY (item_id)
        REFERENCES inventory (item_id)
);