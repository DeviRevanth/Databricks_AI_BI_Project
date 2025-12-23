INSERT OVERWRITE ecommerce.bronze.customers
SELECT
  customer_id,
  customer_name,
  email,
  country,
  phone_number,
  gender,
  CAST(created_at AS TIMESTAMP) AS created_at
FROM ecommerce.raw.customers;