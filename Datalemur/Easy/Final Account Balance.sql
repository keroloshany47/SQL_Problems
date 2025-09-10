SELECT account_id,
       SUM(
         CASE
           WHEN transaction_type = 'Deposit' THEN amount
           WHEN transaction_type = 'Withdrawal' THEN -amount
         END
       ) AS final_balance
FROM transactions
GROUP BY account_id;
