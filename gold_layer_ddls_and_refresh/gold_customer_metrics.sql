INSERT OVERWRITE ecommerce.gold.cancellations_per_customer
SELECT
  Customer_ID,
  SUM(No_of_Orders) AS Total_Cancelled_Orders,
  SUM(Total_products) AS Total_Cancelled_Products,
  SUM(Total_cancelled_value) AS Total_Cancelled_Value
FROM ecommerce.silver.cancelled_cust_country
GROUP BY Customer_ID;


INSERT OVERWRITE ecommerce.gold.revenue_per_customer
SELECT
  Customer,
  SUM(Revenue) AS Revenue
FROM ecommerce.silver.revenue_per_customer_agg
GROUP BY Customer;


INSERT OVERWRITE ecommerce.gold.revenue_per_gender
SELECT
  Gender,
  SUM(Revenue) AS Revenue
FROM ecommerce.silver.revenue_per_customer_agg
GROUP BY Gender;
