CREATE TABLE IF NOT EXISTS ecommerce.gold.revenue_per_customer (
  Customer STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/revenue_per_customer';


CREATE TABLE IF NOT EXISTS ecommerce.gold.cancellations_per_customer (
  Customer_ID STRING,
  Total_Cancelled_Orders BIGINT,
  Total_Cancelled_Products BIGINT,
  Total_Cancelled_Value DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/cancellations_per_customer';

CREATE TABLE IF NOT EXISTS ecommerce.gold.revenue_per_gender (
  Gender STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/revenue_per_gender';


CREATE TABLE IF NOT EXISTS ecommerce.gold.revenue_per_country (
  Country STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/revenue_per_country';


CREATE TABLE IF NOT EXISTS ecommerce.gold.cancellations_per_country (
  Country STRING,
  Total_Cancelled_Orders BIGINT,
  Total_Cancelled_Products BIGINT,
  Total_Cancelled_Value DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/cancellations_per_country';

CREATE TABLE IF NOT EXISTS ecommerce.gold.revenue_per_product (
  Product STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/revenue_per_product';



