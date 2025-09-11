WITH ranked AS (
    SELECT
        card_name,
        issued_amount,
        issue_year,
        issue_month,
        ROW_NUMBER() OVER (
            PARTITION BY card_name 
            ORDER BY issue_year, issue_month
        ) AS rn
    FROM monthly_cards_issued
)
SELECT
    card_name,
    issued_amount
FROM ranked
WHERE rn = 1
ORDER BY issued_amount DESC;
