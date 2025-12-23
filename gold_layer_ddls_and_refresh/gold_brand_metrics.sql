DROP TABLE IF EXISTS ecommerce.gold.revenue_per_category;
CREATE TABLE ecommerce.gold.revenue_per_category AS
SELECT category.Category AS Cateogory,
SUM(revenue) AS Revenue 
FROM ecommerce.silver.revenue_per_product_agg category
GROUP BY Category;


DROP TABLE IF EXISTS ecommerce.gold.revenue_per_brand;
CREATE TABLE ecommerce.gold.revenue_per_brand AS
SELECT brand.Brand AS Brand, 
SUM(revenue) AS Revenue 
FROM ecommerce.silver.revenue_per_product_agg brand
GROUP BY Brand;


CREATE TABLE ecommerce.gold.brand_wise_cancellations AS
SELECT Brand,
SUM(QUANTITY) as Cancelled_Items,
sum(line_amount) AS Total_Amount
FROM ecommerce.silver.cancelled_products_agg
GROUP BY Brand;


CREATE TABLE ecommerce.gold.category_wise_cancellations AS
SELECT Category,
SUM(QUANTITY) as Cancelled_Items,
sum(line_amount) AS Total_Amount
FROM ecommerce.silver.cancelled_products_agg
GROUP BY Category;