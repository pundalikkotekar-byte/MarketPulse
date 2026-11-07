

CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT
    DATE_TRUNC(
        'month',
        o.order_purchase_timestamp::timestamp
    ) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value)::numeric, 2) AS total_revenue
FROM orders o
JOIN order_payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1;

CREATE OR REPLACE VIEW vw_category_performance AS
SELECT
    COALESCE(
        t.product_category_name_english,
        pr.product_category_name,
        'Unknown'
    ) AS category,
    COUNT(*) AS units_sold,
    ROUND(SUM(i.price)::numeric, 2) AS product_revenue,
    ROUND(AVG(i.price)::numeric, 2) AS average_price
FROM order_items i
JOIN orders o ON i.order_id = o.order_id
JOIN products pr ON i.product_id = pr.product_id
LEFT JOIN product_category_name_translation t
    ON pr.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 1;

CREATE OR REPLACE VIEW vw_seller_performance AS
SELECT
    s.seller_id,
    s.seller_state,
    COUNT(*) AS units_sold,
    ROUND(SUM(i.price)::numeric, 2) AS revenue
FROM sellers s
JOIN order_items i ON s.seller_id = i.seller_id
JOIN orders o ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id, s.seller_state;

CREATE OR REPLACE VIEW vw_customer_spending AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(p.payment_value)::numeric, 2) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id;

CREATE OR REPLACE VIEW vw_delivery_performance AS
SELECT
    order_id,
    order_purchase_timestamp::timestamp AS purchase_date,
    order_delivered_customer_date::timestamp AS delivery_date,
    order_estimated_delivery_date::timestamp AS estimated_date,

    ROUND(
        EXTRACT(EPOCH FROM (
            order_delivered_customer_date::timestamp
            - order_purchase_timestamp::timestamp
        )) / 86400.0
    , 2) AS actual_delivery_days,

    CASE
        WHEN order_delivered_customer_date::timestamp
             > order_estimated_delivery_date::timestamp
        THEN 'Late'
        ELSE 'On Time or Early'
    END AS delivery_status

FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
AND order_estimated_delivery_date IS NOT NULL;


SELECT * FROM vw_monthly_revenue LIMIT 5;

SELECT * FROM vw_category_performance
ORDER BY product_revenue DESC LIMIT 5;

SELECT * FROM vw_seller_performance
ORDER BY revenue DESC LIMIT 5;

SELECT * FROM vw_customer_spending
ORDER BY total_spending DESC LIMIT 5;

SELECT * FROM vw_delivery_performance LIMIT 5;