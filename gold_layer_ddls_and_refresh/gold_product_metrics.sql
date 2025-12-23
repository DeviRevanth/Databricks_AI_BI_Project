INSERT OVERWRITE ecommerce.gold.revenue_per_product
SELECT
  product_name AS Product,
  SUM(Revenue) AS Revenue
FROM ecommerce.silver.revenue_per_product_agg
GROUP BY product_name;

INSERT OVERWRITE ecommerce.gold.product_wise_cancellations
SELECT
  Product_ID,
  COUNT(*) AS Cancellation_Frequency,
  SUM(Net_Banking) AS Net_Banking,
  SUM(Card) AS Card,
  SUM(Upi) AS Upi,
  SUM(Quantity) AS Quantity,
  SUM(Line_Amount) AS Total_Amount
FROM ecommerce.silver.cancelled_products_agg
GROUP BY Product_ID;
