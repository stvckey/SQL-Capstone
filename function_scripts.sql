use chocolate_shop;

-- Function to create order transactions. 
DELIMITER //
CREATE FUNCTION order_transaction(newcustomer TEXT, firstname TEXT, lastname TEXT, customer_id INT, purchased_item INT, quantity INT)
RETURNS INT
DETERMINISTIC
BEGIN 
    DECLARE order_id INT;

    IF newcustomer = 'yes' AND customer_id IS NULL THEN
        -- Insert the new customer
        INSERT INTO customers (first_name, last_name) VALUES (firstname, lastname);
        -- Get the auto-generated customer_id
        SET customer_id = LAST_INSERT_ID();
    END IF;

    -- Insert the order into the orders table
    INSERT INTO orders (customer_id, item_id, item_quantity, order_date)
    VALUES (customer_id, purchased_item, quantity, NOW());

    -- Get the order_id of the inserted order
    SET order_id = LAST_INSERT_ID();
    
    -- Subtract the ordered quantity from the inventory
    UPDATE inventory
    SET item_quantity = item_quantity - quantity
    WHERE item_id = purchased_item;-- Adjust this condition based on your schema

    -- Return the order_id as the result
    RETURN order_id;
END//
DELIMITER ;

-- Call the function using SELECT. Here, we create a new customer
SELECT order_transaction("yes", "Pares", "Stuckey", NULL, 1, 3);
-- Call the function using SELECT. Here, we simply update the order and inventory table
SELECT order_transaction("no", "Pares", "Stuckey", 1, 1, 3);


-- Function to refill existing flavors
DELIMITER //
CREATE FUNCTION inventory_refill(flavor_id INT, quantity INT)
RETURNS INT
DETERMINISTIC
BEGIN 
    -- Add the new quantity to the inventory
    UPDATE inventory
    SET item_quantity = item_quantity + quantity
    WHERE item_id = flavor_id; -- Adjust this condition based on your schema

    -- Return the item_id as the result
    RETURN flavor_id;
END//
DELIMITER ;

-- Add 5 units to item_id 1
SELECT inventory_refill(2, 120);
