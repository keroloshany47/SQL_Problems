-- Write your MySQL query statement below
WITH confirmation_rate AS (
    SELECT 
        s.user_id,
        SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) / 
        (COUNT(c.action) + CASE WHEN COUNT(c.action) = 0 THEN 1 ELSE 0 END) AS confirmation_rate
    FROM Signups s
    LEFT JOIN Confirmations c ON s.user_id = c.user_id
    GROUP BY s.user_id
)
SELECT 
    user_id,
    ROUND(confirmation_rate, 2) AS confirmation_rate
FROM confirmation_rate;
