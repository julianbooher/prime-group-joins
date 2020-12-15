-- Tasks


-- Get all customers and their addresses.
SELECT * FROM customers
JOIN addresses ON addresses.customer_id = customers.id;


-- Get all orders and their line items (orders, quantity and product).
SELECT order_date, orders.id, quantity, description FROM orders
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON line_items.product_id = products.id;


-- Which warehouses have cheetos?
SELECT warehouse FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON warehouse_product.product_id = products.id
WHERE description = 'cheetos';


-- Which warehouses have diet pepsi?
SELECT warehouse FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON warehouse_product.product_id = products.id
WHERE description = 'diet pepsi';


-- Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT count(customers.id), customers.first_name, customers.last_name FROM customers
JOIN addresses ON addresses.customer_id = customers.id
JOIN orders ON addresses.id = orders.address_id
GROUP BY customers.id;

-- How many customers do we have?
SELECT count(*) FROM customers;

-- How many products do we carry?
SELECT count(*) FROM products;

-- What is the total available on-hand quantity of diet pepsi?
SELECT SUM(warehouse_product.on_hand), products.description FROM warehouse_product
JOIN products ON warehouse_product.product_id = products.id
WHERE products.description = 'diet pepsi'
GROUP BY products.id;


Stretch

-- How much was the total cost for each order?
SELECT sum(products.unit_price * line_items.quantity), orders.id FROM orders
JOIN line_items ON orders.id = line_items.order_id
JOIN products ON line_items.product_id = products.id
GROUP BY orders.id;


-- How much has each customer spent in total?
SELECT customers.first_name, SUM(products.unit_price * line_items.quantity) AS total_spent FROM customers
JOIN addresses ON customers.id = addresses.customer_id
JOIN orders ON addresses.id = orders.address_id
JOIN line_items ON line_items.order_id = orders.id
JOIN products ON products.id = line_items.product_id
GROUP BY customers.id;

-- How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).