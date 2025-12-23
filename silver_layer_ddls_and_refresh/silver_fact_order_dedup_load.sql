MERGE INTO ecommerce.silver.fact_orders tgt
USING (
  SELECT
    order_id,
    order_ts,
    customer_id,
    product_id,
    quantity,
    unit_price,
    line_amount,
    payment_method,
    order_status
  FROM ecommerce.bronze.orders
) AS src
ON tgt.order_id = src.order_id
AND tgt.product_id = src.product_id

WHEN MATCHED THEN UPDATE SET
  tgt.order_ts = src.order_ts,
  tgt.customer_id = src.customer_id,
  tgt.quantity = src.quantity,
  tgt.unit_price = src.unit_price,
  tgt.line_amount = src.line_amount,
  tgt.payment_method = src.payment_method,
  tgt.order_status = src.order_status,
  tgt.updated_at = current_timestamp()

WHEN NOT MATCHED THEN INSERT (
  order_id,
  order_ts,
  customer_id,
  product_id,
  quantity,
  unit_price,
  line_amount,
  payment_method,
  order_status,
  created_at,
  updated_at
) VALUES (
  src.order_id,
  src.order_ts,
  src.customer_id,
  src.product_id,
  src.quantity,
  src.unit_price,
  src.line_amount,
  src.payment_method,
  src.order_status,
  current_timestamp(),
  current_timestamp()
);