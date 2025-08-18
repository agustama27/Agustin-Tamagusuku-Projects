-- TODO: This query will return a table with two columns; customer_state, and 
-- Revenue. The first one will have the letters that identify the top 10 states 
-- with most revenue and the second one the total revenue of each.
-- HINT: All orders should have a delivered status and the actual delivery date 
-- should be not null. 
SELECT 
    olist_customers.customer_state AS customer_state,
    SUM(olist_order_payments.payment_value) AS Revenue
FROM 
    olist_order_payments
JOIN 
    olist_orders ON olist_order_payments.order_id = olist_orders.order_id
JOIN 
    olist_customers ON olist_orders.customer_id = olist_customers.customer_id
WHERE 
    olist_orders.order_status = 'delivered'
    AND olist_orders.order_delivered_customer_date IS NOT NULL
GROUP BY 
    olist_customers.customer_state
ORDER BY 
    Revenue DESC
LIMIT 10;


