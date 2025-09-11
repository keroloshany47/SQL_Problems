WITH monthly_open AS (
    SELECT
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS mth,   
        open,
        RANK() OVER (PARTITION BY ticker ORDER BY open DESC) AS rnk_high,
        RANK() OVER (PARTITION BY ticker ORDER BY open ASC)  AS rnk_low
    FROM stock_prices
)
SELECT
    ticker,
    MAX(CASE WHEN rnk_high = 1 THEN mth END) AS highest_mth,
    MAX(CASE WHEN rnk_high = 1 THEN open END) AS highest_open,
    MAX(CASE WHEN rnk_low = 1 THEN mth END) AS lowest_mth,
    MAX(CASE WHEN rnk_low = 1 THEN open END) AS lowest_open
FROM monthly_open
GROUP BY ticker
ORDER BY ticker;
