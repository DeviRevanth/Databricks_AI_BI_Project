CREATE TABLE IF NOT EXISTS ecommerce.silver.revenue_per_product_agg (
  Product_Name STRING,
  Category STRING,
  Brand STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/silver/revenue_per_product_agg';


CREATE TABLE IF NOT EXISTS ecommerce.silver.cancelled_products_agg (
  Product_ID STRING,
  Brand STRING,
  Category STRING,
  Product_Price DOUBLE,
  Quantity INT,
  Line_Amount DOUBLE,
  Net_Banking INT,
  Card INT,
  Upi INT
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/silver/cancelled_products_agg';


CREATE TABLE IF NOT EXISTS ecommerce.silver.revenue_per_customer_agg (
  Customer STRING,
  Country STRING,
  Gender STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/silver/revenue_per_customer_agg';


CREATE TABLE IF NOT EXISTS ecommerce.silver.cancelled_cust_country (
  Customer_ID STRING,
  Country STRING,
  No_of_Orders BIGINT,
  Total_products BIGINT,
  Total_cancelled_value DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/silver/cancelled_cust_country';