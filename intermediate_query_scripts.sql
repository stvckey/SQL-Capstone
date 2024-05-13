use chocolate_shop;

-- Top selling chocolate
SELECT 
    inventory.item_name,
    orders.item_id,
    SUM(orders.item_quantity) AS total_sales
FROM
    orders
        JOIN
    inventory ON orders.item_id = inventory.item_id
GROUP BY orders.item_id , inventory.item_name
ORDER BY total_sales DESC
LIMIT 1;

-- Customers with the highest order amounts
SELECT 
    CONCAT(customers.first_name,
            ' ',
            customers.last_name) AS fullname,
    COUNT(orders.order_id) as total_orders
FROM
    customers
        JOIN
    orders ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id
ORDER BY COUNT(orders.order_id) DESC;

-- All orders made in the year 2024
SELECT 
    *
FROM
    orders
WHERE
    order_date >= '2024-01-01'
        AND order_date <= '2024-12-31';
        
-- Chocolate with low inventory levels
SELECT 
    *
FROM
    inventory
WHERE
    item_quantity <= 20;
    

-- 