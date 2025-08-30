SELECT 
    category,
    product,
    total_spend
FROM (
SELECT 
    category,
    product,
    SUM(spend) AS total_spend ,
    RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC
      ) AS rank
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date ) =2022  )AS ranked_table
GROUP BY category, product
WHERE rank <=2
ORDER BY category , rank ;
