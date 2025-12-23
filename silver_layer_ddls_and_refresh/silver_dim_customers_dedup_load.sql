-- customers 
MERGE INTO ecommerce.silver.dim_customers AS tgt
USING (
  SELECT
    customer_id,
    country,
    gender,
    CAST(created_at AS TIMESTAMP) AS created_at
  FROM ecommerce.bronze.customers
) AS src
ON tgt.customer_id = src.customer_id

WHEN MATCHED THEN UPDATE SET
  tgt.country = src.country,
  tgt.gender = src.gender,
  tgt.updated_at = current_timestamp()

WHEN NOT MATCHED THEN INSERT (
  customer_id,
  country,
  gender,
  created_at,
  updated_at
) VALUES (
  src.customer_id,
  src.country,
  src.gender,
  src.created_at,
  current_timestamp()
);

