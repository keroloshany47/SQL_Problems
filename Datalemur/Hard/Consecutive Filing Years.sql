WITH consecutive_years AS (
    SELECT 
        user_id,
        EXTRACT(YEAR FROM filing_date)::int AS yr,
        EXTRACT(YEAR FROM filing_date)::int 
          - ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY EXTRACT(YEAR FROM filing_date)) AS grp
    FROM filed_taxes
    WHERE LOWER(product) LIKE 'turbotax%'
    GROUP BY user_id, EXTRACT(YEAR FROM filing_date)
)
SELECT DISTINCT user_id
FROM consecutive_years
GROUP BY user_id, grp
HAVING COUNT(*) >= 3
ORDER BY user_id;
