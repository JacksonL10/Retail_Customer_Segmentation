-- Retail Customer Segmentation 
-- Database: analytics_practice
-- Table: retail_orders
USE analytics_practice;

SELECT
  COUNT(*) AS row_count,
  MIN(DAY) AS min_day,
  MAX(DAY) AS max_day,
  MIN(WEEK_NO) AS min_week,
  MAX(WEEK_NO) AS max_week
FROM retail_orders;

SELECT
  ROUND(SUM(SALES_VALUE), 2) AS total_sales
FROM retail_orders;

SELECT
  household_key
  ROUND(SUM(SALES_VALUE), 2) AS total_sales
FROM retail_orders
GROUP BY household_key
ORDER BY total_sales DESC
LIMIT 10;

SELECT
  household_key,
  COUNT(DISTINCT BASKET_ID) AS baskets
FROM retail_orders
GROUP BY household_key
ORDER BY baskets DESC
LIMIT 10;

SELECT
  WEEK_NO,
  ROUND(SUM(SALES_VALUE), 2) AS weekly_sales
FROM retail_orders
GROUP BY WEEK_NO
ORDER BY WEEK_NO;

SELECT
  household_key,
  ROUND(AVG(basket_items), 2) AS avg_items_per_basket
FROM (
  SELECT
    household_key,
    BASKET_ID
    SUM(QUANTITY) AS basket_items
  FROM retail_orders
  GROUP BY household_key, BASKET_ID
) t
GROUP BY household_key
ORDER BY avg_items_per_basket DESC
LIMIT 10;

SELECT
  ROUND(SUM(SALES_VALUE), 2) AS total_sales,
  ROUND(SUM(RETAIL_DISC), 2) AS total_retail_discount,
  ROUND(SUM(COUPON_DISC + COUNPON_MATCH_DISC), 2) AS total_coupon_discount
FROM retail_orders;

SELECT
  SUM(CASE WHEN (RETAIL_DISC <> 0 OR COUPON_DISC <> 0 OR COUPON_MATCH_DISC <> 0) THEN 1 ELSE 0 END) AS dicounted_rows,
  SUM(CASE WHEN (RETAIL_DISC = 0 AND COUPON_DISC = 0 AND COUPON_MATCH_DISC = 0) THEN 1 ELSE 0 END) AS non_discounted_rows
FROM retail_orders;

SELECT
  household_key,
  MAX(DAY) AS recency_day,
  COUNT(DISTINCT BASKET_ID) AS frequency_baskets,
  ROUND(SUM(SALES_VALUE), 2) AS monetary_sales
FROM retail_orders
GROUP BY household_key
ORDER BY monetary_sales DESC
LIMIT 20;

SELECT
  PRODUCT_ID,
  ROUND(SUM(SALES_VALUE), 2) AS product_sales
FROM retail_orders
GROUP BY PRODUCT_ID
ORDER BY product_sales DESC
LIMIT 10;