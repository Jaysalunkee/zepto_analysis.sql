-- Q1. Top 10 products with the highest discount amount (₹)
SELECT
    name,
    mrp,
    discountedSellingPrice,
    (mrp - discountedSellingPrice) AS discount_amount
FROM zepto
ORDER BY discount_amount DESC
LIMIT 10;


-- Q2. Out-of-stock products with MRP higher than the average MRP
SELECT
    name,
    category,
    mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > (
      SELECT AVG(mrp)
      FROM zepto
  )
ORDER BY mrp DESC;


-- Q3. Total inventory value available in each category
SELECT
    category,
    ROUND(SUM(discountedSellingPrice * availableQuantity), 2) AS inventory_value
FROM zepto
WHERE outOfStock = FALSE
GROUP BY category
ORDER BY inventory_value DESC;


-- Q4. Premium products with low discounts
SELECT
    name,
    category,
    mrp,
    discountPercent
FROM zepto
WHERE mrp >= 500
  AND discountPercent <= 10
  AND outOfStock = FALSE
ORDER BY mrp DESC;


-- Q5. Top 5 categories with the highest average savings (₹)
SELECT
    category,
    ROUND(AVG(mrp - discountedSellingPrice), 2) AS avg_saving
FROM zepto
GROUP BY category
ORDER BY avg_saving DESC
LIMIT 5;


-- Q6. Best-value products based on price per 100g
SELECT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND((discountedSellingPrice * 100.0) / weightInGms, 2) AS price_per_100g
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_100g ASC;


-- Q7. Classify products by package size
SELECT
    name,
    weightInGms,
    CASE
        WHEN weightInGms < 500 THEN 'Small Pack'
        WHEN weightInGms BETWEEN 500 AND 2000 THEN 'Family Pack'
        ELSE 'Bulk Pack'
    END AS pack_type
FROM zepto;


-- Q8. Average product weight and total stock available by category
SELECT
    category,
    ROUND(AVG(weightInGms), 2) AS avg_weight,
    SUM(availableQuantity) AS total_stock
FROM zepto
GROUP BY category
ORDER BY total_stock DESC;
