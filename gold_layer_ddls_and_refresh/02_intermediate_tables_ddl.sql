CREATE TABLE IF NOT EXISTS ecommerce.gold.revenue_per_category (
  Category STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/revenue_per_category';

CREATE TABLE IF NOT EXISTS ecommerce.gold.revenue_per_brand (
  Brand STRING,
  Revenue DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/revenue_per_brand';


CREATE TABLE IF NOT EXISTS ecommerce.gold.brand_wise_cancellations (
  Brand STRING,
  Cancelled_Items BIGINT,
  Total_Amount DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/brand_wise_cancellations';


CREATE TABLE IF NOT EXISTS ecommerce.gold.category_wise_cancellations (
  Category STRING,
  Cancelled_Items BIGINT,
  Total_Amount DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/category_wise_cancellations';


CREATE TABLE IF NOT EXISTS ecommerce.gold.product_wise_cancellations (
  Product_ID STRING,
  Cancellation_Frequency BIGINT,
  Net_Banking BIGINT,
  Card BIGINT,
  Upi BIGINT,
  Quantity BIGINT,
  Total_Amount DOUBLE
)
USING DELTA
LOCATION 's3://databricks-ai-bi-project/gold/product_wise_cancellations';

