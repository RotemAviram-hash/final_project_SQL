-- Task 1: 
SELECT
    product_name,
    ROUND((unit_price * 1.17)::numeric, 2) AS vat_with_price
FROM products
ORDER BY vat_with_price DESC
LIMIT 5;

-- Task 2: 
SELECT
    company_name,
    country,
    city
FROM customers
WHERE country IN ('Spain', 'Germany', 'Italy')
ORDER BY country, company_name;


-- Task 3;
SELECT
    product_name,
    unit_price
FROM products
WHERE
    (LEFT(product_name, 1) = 'C'
    OR LEFT(product_name, 1) = 'G')
    AND unit_price > 20
ORDER BY unit_price DESC;

--Task 4:
SELECT
    ship_city,
    COUNT(*) AS orders
FROM orders
GROUP BY ship_city
HAVING COUNT(*) >= 25
ORDER BY orders DESC, ship_city;

--Task 5:
SELECT
    categories.category_name,
    COUNT(products.product_id) AS product_count,
    ROUND(AVG(products.unit_price), 2) AS avg_price
FROM categories
JOIN products
    ON categories.category_id = products.category_id
GROUP BY categories.category_name
ORDER BY avg_price DESC;

--Task 6:
SELECT
    customers.company_name
FROM customers
LEFT JOIN orders
    ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL
ORDER BY customers.company_name;

--Task 7:
SELECT
    suppliers.company_name,
    COUNT(products.product_id) AS product_count
FROM suppliers
INNER JOIN products
    ON suppliers.supplier_id = products.supplier_id
GROUP BY
    suppliers.supplier_id,
    suppliers.company_name
ORDER BY
    product_count DESC,
    suppliers.company_name ASC
LIMIT 3;

--Task 8:
SELECT
    customers.company_name,
    COUNT(orders.order_id) AS order_count
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id
GROUP BY
    customers.customer_id,
    customers.company_name
ORDER BY
    order_count DESC,
    customers.company_name ASC
LIMIT 3;