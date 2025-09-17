WITH yearly_spend AS (
    SELECT
        EXTRACT(YEAR FROM transaction_date) AS year,
        product_id,
        SUM(spend) AS curr_year_spend
    FROM user_transactions
    GROUP BY EXTRACT(YEAR FROM transaction_date), product_id
)
SELECT
    year,
    product_id,
    curr_year_spend,
    LAG(curr_year_spend) OVER (
        PARTITION BY product_id
        ORDER BY year
    ) AS prev_year_spend,
    ROUND(
        100.0 * (curr_year_spend - LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year))
              / LAG(curr_year_spend) OVER (PARTITION BY product_id ORDER BY year),
        2
    ) AS yoy_rate
FROM yearly_spend
ORDER BY product_id, year;
