-- products 

MERGE INTO ecommerce.silver.dim_products AS tgt
USING (
  SELECT
    p.product_id,
    p.product_name,
    p.brand_id,
    b.brand_name,
    p.category_id,
    c.category_name,
    p.price,
    CAST(p.created_at AS TIMESTAMP) AS created_at
  FROM ecommerce.bronze.products p
  JOIN ecommerce.bronze.brands b
    ON p.brand_id = b.brand_id
  JOIN ecommerce.bronze.categories c
    ON p.category_id = c.category_id
) AS src
ON tgt.product_id = src.product_id

WHEN MATCHED THEN UPDATE SET
  tgt.product_name = src.product_name,
  tgt.brand_id = src.brand_id,
  tgt.brand_name = src.brand_name,
  tgt.category_id = src.category_id,
  tgt.category_name = src.category_name,
  tgt.price = src.price,
  tgt.updated_at = current_timestamp()

WHEN NOT MATCHED THEN INSERT (
  product_id,
  product_name,
  brand_id,
  brand_name,
  category_id,
  category_name,
  price,
  created_at,
  updated_at
) VALUES (
  src.product_id,
  src.product_name,
  src.brand_id,
  src.brand_name,
  src.category_id,
  src.category_name,
  src.price,
  src.created_at,
  current_timestamp()
);
