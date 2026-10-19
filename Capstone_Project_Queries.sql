USE harryshop;
SELECT * FROM customers;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM payments

-- Total Revenue 
SELECT SUM(amount) AS total_revenue FROM payments;

-- Revenue by Product 
SELECT p.product_name,SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_name
ORDER BY revenue DESC;


-- Top Customer by Spend
SELECT c.name,SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Best Selling Product
SELECT p.product_name,SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Cancelled Orders Count
SELECT COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';


-- Show all Cutomer from Delhi
SELECT * FROM customers WHERE city = 'Delhi';

-- Show Product Priced above 1000,highest first
SELECT product_name, price FROM products
WHERE price > 1000 ORDER BY price DESC;

-- Show Product With Stock Below 50
SELECT product_name, stock FROM products  WHERE stock < 50;

-- Show the top 3 most expensive products.
SELECT product_name, price FROM products
ORDER BY price DESC LIMIT 3;

-- Count orders by status.
SELECT order_status, COUNT(*) AS total
FROM orders GROUP BY order_status;

-- Show customer name, order id and status.
SELECT c.name, o.order_id, o.order_status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- Find the total value of each order, from price × quantity.
SELECT oi.order_id, SUM(oi.quantity * p.price) AS order_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.order_id;

-- Find orders that have no payment.
SELECT o.order_id, o.order_status
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

-- Find the customer who spent the most.
SELECT c.name, SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC LIMIT 1;
