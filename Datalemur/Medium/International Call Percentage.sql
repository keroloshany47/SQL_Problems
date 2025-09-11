SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN c1.country_id <> c2.country_id THEN 1 ELSE 0 END) 
        / COUNT(*), 
        1
    ) AS international_calls_pct
FROM phone_calls AS c
JOIN phone_info AS cc 
    ON c.caller_id = cc.caller_id
JOIN phone_info AS cv 
    ON c.receiver_id = cv.caller_id;
