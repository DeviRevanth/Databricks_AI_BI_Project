INSERT INTO ecommerce.bronze.orders
SELECT
  order_id,
  CAST(order_ts AS TIMESTAMP),
  customer_id,
  product_id,
  quantity,
  unit_price,
  line_amount,
  payment_method,
  order_status,
  current_timestamp() AS ingestion_ts
FROM ecommerce.raw.orders;