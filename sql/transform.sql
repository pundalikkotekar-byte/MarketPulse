
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers;

SELECT current_database(), current_schema();

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

SELECT COUNT(*) FROM public.orders;


SELECT
    DATETRUNCATE('month', o.order_purchase_timestamp) AS month,
    ROUND(SUM(p.payment_value)::numeric, 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 1;

SELECT
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp::timestamp
    ) AS month,
    ROUND(SUM(p.payment_value)::numeric, 2) AS revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

SELECT
    COALESCE(
        t.product_category_name_english,
        pr.product_category_name,
        'Unknown'
    ) AS category,
    COUNT(*) AS units_sold,
    ROUND(SUM(i.price)::numeric, 2) AS revenue
FROM order_items i
JOIN orders o
    ON i.order_id = o.order_id
JOIN products pr
    ON i.product_id = pr.product_id
LEFT JOIN product_category_name_translation t
    ON pr.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY revenue DESC
LIMIT 10;

SELECT
    s.seller_id,
    s.seller_state,
    COUNT(*) AS units_sold,
    ROUND(SUM(i.price)::numeric, 2) AS revenue
FROM sellers s
JOIN order_items i
    ON s.seller_id = i.seller_id
JOIN orders o
    ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id, s.seller_state
ORDER BY revenue DESC
LIMIT 10;

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE total_orders > 1
    ) AS repeat_customers,
    ROUND(
        COUNT(*) FILTER (WHERE total_orders > 1) * 100.0
        / COUNT(*),
        2
    ) AS repeat_customer_percentage
FROM customer_orders;

WITH category_revenue AS (
    SELECT
        COALESCE(
            t.product_category_name_english,
            pr.product_category_name,
            'Unknown'
        ) AS category,
        SUM(i.price) AS revenue
    FROM order_items i
    JOIN orders o
        ON i.order_id = o.order_id
    JOIN products pr
        ON i.product_id = pr.product_id
    LEFT JOIN product_category_name_translation t
        ON pr.product_category_name = t.product_category_name
    WHERE o.order_status = 'delivered'
    GROUP BY 1
)
SELECT
    category,
    ROUND(revenue::numeric, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS category_rank
FROM category_revenue
ORDER BY category_rank;