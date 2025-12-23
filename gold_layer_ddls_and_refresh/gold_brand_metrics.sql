INSERT OVERWRITE ecommerce.gold.brand_wise_cancellations
SELECT
  Brand,
  SUM(Quantity) AS Cancelled_Items,
  SUM(Line_Amount) AS Total_Amount
FROM ecommerce.silver.cancelled_products_agg
GROUP BY Brand;

INSERT OVERWRITE ecommerce.gold.category_wise_cancellations
SELECT
  Category,
  SUM(Quantity) AS Cancelled_Items,
  SUM(Line_Amount) AS Total_Amount
FROM ecommerce.silver.cancelled_products_agg
GROUP BY Category;


INSERT OVERWRITE ecommerce.gold.revenue_per_brand
SELECT
  Brand,
  SUM(Revenue) AS Revenue
FROM ecommerce.silver.revenue_per_product_agg
GROUP BY Brand;


INSERT OVERWRITE ecommerce.gold.revenue_per_category
SELECT
  Category,
  SUM(Revenue) AS Revenue
FROM ecommerce.silver.revenue_per_product_agg
GROUP BY Category;
