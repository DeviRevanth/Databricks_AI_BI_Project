CREATE OR REPLACE VIEW ecommerce.gold.total_revenue_view AS 
SELECT sum(line_amount) AS Total_Revenue FROM ecommerce.silver.fact_orders WHERE lower(order_status)='placed';

CREATE OR REPLACE VIEW ecommerce.gold.cancelled_total_revenue AS 
SELECT sum(line_amount) AS Lost_Revenue FROM ecommerce.silver.fact_orders WHERE lower(order_status)='cancelled';



