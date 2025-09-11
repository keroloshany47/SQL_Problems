SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN c1.country_id <> c2.country_id THEN 1 ELSE 0 END) 
        / COUNT(*), 
        1
    ) AS international_calls_pct
FROM phone_calls pc
JOIN phone_info c1 
    ON pc.caller_id = c1.caller_id
JOIN phone_info c2 
    ON pc.receiver_id = c2.caller_id;
