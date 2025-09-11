WITH last_day AS (
    SELECT user_id, MAX(transaction_date) AS last_transaction
    FROM user_transactions
    GROUP BY user_id
)


SELECT ld.last_transaction AS transaction_date,
       u.user_id,
       COUNT(*) AS purchase_count
FROM user_transactions AS u
JOIN last_day As ld
  ON u.user_id = ld.user_id
 AND u.transaction_date = ld.last_transaction
GROUP BY ld.last_transaction, u.user_id
ORDER BY ld.last_transaction;
