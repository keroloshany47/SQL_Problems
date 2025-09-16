SELECT 
    7 AS mth,
    COUNT(DISTINCT july.user_id) AS monthly_active_users
FROM (
    SELECT DISTINCT user_id
    FROM user_actions
    WHERE event_date BETWEEN '2022-06-01 00:00:00' AND '2022-06-30 23:59:59'
) AS june
JOIN (
    SELECT DISTINCT user_id
    FROM user_actions  
    WHERE event_date BETWEEN '2022-07-01 00:00:00' AND '2022-07-31 23:59:59'
) AS july
ON july.user_id = june.user_id;

