SELECT e.user_id
FROM emails AS e
JOIN texts AS t 
    ON e.email_id = t.email_id 
WHERE t.action_date = DATE_ADD(e.signup_date, INTERVAL 1 DAY)
  AND t.signup_action = 'Confirmed';
