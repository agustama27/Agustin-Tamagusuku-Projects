-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).



WITH Monthly_Revenue AS (
    SELECT 
        olist_orders.order_id, order_delivered_customer_date, order_status,
        strftime('%m', order_delivered_customer_date) AS month_no,
        strftime('%Y', order_delivered_customer_date) AS Delivery_Year,
        payment_value AS Total_revenue
    FROM 
        olist_order_payments
    INNER JOIN 
        olist_orders ON olist_order_payments.order_id = olist_orders.order_id
    WHERE 
        olist_orders.order_status = 'delivered'
        AND olist_orders.order_delivered_customer_date IS NOT NULL
    GROUP BY 
        olist_orders.order_id
)

SELECT 
    month_no,
    CASE 
        WHEN month_no = '01' THEN 'Jan'
        WHEN month_no = '02' THEN 'Feb'
        WHEN month_no = '03' THEN 'Mar'
        WHEN month_no = '04' THEN 'Apr'
        WHEN month_no = '05' THEN 'May'
        WHEN month_no = '06' THEN 'Jun'
        WHEN month_no = '07' THEN 'Jul'
        WHEN month_no = '08' THEN 'Aug'
        WHEN month_no = '09' THEN 'Sep'
        WHEN month_no = '10' THEN 'Oct'
        WHEN month_no = '11' THEN 'Nov'
        WHEN month_no = '12' THEN 'Dec'
    END AS month,
    SUM(CASE WHEN Delivery_Year = '2016' THEN Total_revenue ELSE 0.00 END) AS Year2016,
    SUM(CASE WHEN Delivery_Year = '2017' THEN Total_revenue ELSE 0.00 END) AS Year2017,
    SUM(CASE WHEN Delivery_Year = '2018' THEN Total_revenue ELSE 0.00 END) AS Year2018
FROM 
    Monthly_Revenue
GROUP BY 
    month_no
ORDER BY 
    month_no;