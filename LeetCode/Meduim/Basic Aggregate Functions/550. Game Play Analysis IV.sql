--first solution 
SELECT 
    ROUND(
        COUNT(DISTINCT A2.player_id) / COUNT(DISTINCT first_login.player_id),
        2
    ) AS fraction
FROM (
    SELECT player_id, MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
) AS first_login
LEFT JOIN Activity AS A2
    ON A2.player_id = first_login.player_id
    AND A2.event_date = DATE_ADD(first_login.first_date, INTERVAL 1 DAY);



--second solution
SELECT 
    ROUND(
        COUNT(DISTINCT A1.player_id) / 
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
        2
    ) AS fraction
FROM Activity A1
JOIN Activity A2
  ON A1.player_id = A2.player_id
 AND A2.event_date = DATE_ADD(A1.event_date, INTERVAL 1 DAY)
WHERE A1.event_date = (
    SELECT MIN(event_date) 
    FROM Activity 
    WHERE player_id = A1.player_id
);
