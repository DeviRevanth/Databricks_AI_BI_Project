INSERT OVERWRITE ecommerce.gold.cancellations_per_country
SELECT
  Country,
  SUM(No_of_Orders) AS Total_Cancelled_Orders,
  SUM(Total_products) AS Total_Cancelled_Products,
  SUM(Total_cancelled_value) AS Total_Cancelled_Value
FROM ecommerce.silver.cancelled_cust_country
GROUP BY Country;


INSERT OVERWRITE ecommerce.gold.revenue_per_country
SELECT
  Country,
  SUM(Revenue) AS Revenue
FROM ecommerce.silver.revenue_per_customer_agg
GROUP BY Country;
