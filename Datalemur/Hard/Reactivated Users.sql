SELECT 
    EXTRACT(MONTH FROM u.login_date) AS mth,
    COUNT(DISTINCT u.user_id) AS reactivated_users
FROM user_logins AS u
LEFT JOIN user_logins AS prev
    ON u.user_id = prev.user_id
    AND EXTRACT(MONTH FROM prev.login_date) = EXTRACT(MONTH FROM u.login_date - INTERVAL '1 month')
WHERE prev.user_id IS NULL
GROUP BY  mth
ORDER BY  mth;
