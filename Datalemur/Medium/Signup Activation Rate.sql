SELECT 
    ROUND
        (
            CAST(COUNT(DISTINCT CASE WHEN t.signup_action = 'Confirmed' THEN e.user_id END) AS DECIMAL) 
            /COUNT(DISTINCT e.user_id),2
        ) AS activation_rate
FROM emails AS e
LEFT JOIN texts AS t 
  ON e.email_id = t.email_id;
