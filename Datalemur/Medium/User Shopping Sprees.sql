SELECT user_id
FROM transactions  AS t1
WHERE EXISTS (
    SELECT 1
    FROM transactions  AS t2
    JOIN transactions  AS t3 ON t3.user_id = t2.user_id
    WHERE t1.user_id = t2.user_id
      AND t2.user_id = t3.user_id
      AND t2.transaction_date = t1.transaction_date + INTERVAL '1 day'
      AND t3.transaction_date = t1.transaction_date + INTERVAL '2 day'
)
GROUP BY user_id
ORDER BY user_id;
