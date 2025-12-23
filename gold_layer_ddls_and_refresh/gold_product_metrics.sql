DROP TABLE IF EXISTS ecommerce.gold.revenue_per_product;
CREATE TABLE ecommerce.gold.revenue_per_product AS
SELECT product.product_name AS Product,
SUM(revenue) AS Revenue 
FROM ecommerce.silver.revenue_per_product_agg product
GROUP BY Product;


CREATE TABLE ecommerce.gold.product_wise_cancellations AS
SELECT Product_ID,
COUNT(DISTINCT order_id) AS Cancellation_Frequency
SUM(Net_Banking) AS Net_Banking,
SUM(Card) AS Card,
SUM(Upi) AS Upi,
SUM(Quantity) as quantity, 
SUM(Line_Amount) AS Total_Amount
FROM ecommerce.silver.cancelled_products_agg
GROUP BY Product_ID;


