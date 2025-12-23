INSERT OVERWRITE ecommerce.silver.revenue_per_product_agg
WITH placed_orders AS (
  SELECT product_id, line_amount
  FROM ecommerce.silver.fact_orders
  WHERE lower(order_status) = 'placed'
)
SELECT
  prod.product_name AS Product_Name,
  prod.category_name AS Category,
  prod.brand_name AS Brand,
  SUM(line_amount) AS Revenue
FROM placed_orders orders
JOIN ecommerce.silver.dim_products prod
  ON orders.product_id = prod.product_id
GROUP BY prod.product_name, prod.category_name, prod.brand_name;

INSERT OVERWRITE ecommerce.silver.cancelled_products_agg
WITH cancelled_orders AS (
  SELECT product_id, quantity, line_amount, payment_method
  FROM ecommerce.silver.fact_orders
  WHERE lower(order_status) = 'cancelled'
)
SELECT
  orders.product_id AS Product_ID,
  prod.brand_name AS Brand,
  prod.category_name AS Category,
  prod.price AS Product_Price,
  orders.quantity AS Quantity,
  orders.line_amount AS Line_Amount,
  CASE WHEN lower(payment_method) = 'net_banking' THEN 1 ELSE 0 END AS Net_Banking,
  CASE WHEN lower(payment_method) = 'card' THEN 1 ELSE 0 END AS Card,
  CASE WHEN lower(payment_method) = 'upi' THEN 1 ELSE 0 END AS Upi
FROM cancelled_orders orders
JOIN ecommerce.silver.dim_products prod
  ON orders.product_id = prod.product_id;

INSERT OVERWRITE ecommerce.silver.revenue_per_customer_agg
WITH placed_orders AS (
  SELECT customer_id, line_amount
  FROM ecommerce.silver.fact_orders
  WHERE lower(order_status) = 'placed'
)
SELECT
  cust.customer_id AS Customer,
  cust.country AS Country,
  cust.gender AS Gender,
  SUM(line_amount) AS Revenue
FROM placed_orders orders
JOIN ecommerce.silver.dim_customers cust
  ON orders.customer_id = cust.customer_id
GROUP BY cust.customer_id, cust.country, cust.gender;


INSERT OVERWRITE ecommerce.silver.cancelled_cust_country
WITH cancelled_orders AS (
  SELECT order_id, customer_id, product_id, line_amount
  FROM ecommerce.silver.fact_orders
  WHERE lower(order_status) = 'cancelled'
)
SELECT
  cust.customer_id AS Customer_ID,
  cust.country AS Country,
  COUNT(DISTINCT orders.order_id) AS No_of_Orders,
  COUNT(orders.product_id) AS Total_products,
  ROUND(SUM(orders.line_amount), 2) AS Total_cancelled_value
FROM ecommerce.silver.dim_customers cust
JOIN cancelled_orders orders
  ON cust.customer_id = orders.customer_id
GROUP BY cust.customer_id, cust.country;
