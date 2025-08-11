-- Write your MySQL query statement below
WITH percentage AS (
    SELECT 
        r.contest_id,
        COUNT(DISTINCT r.user_id) * 100.0 / (SELECT COUNT(*) FROM Users) AS percentage
    FROM Register AS r
    GROUP BY r.contest_id
)
SELECT 
    contest_id,
    ROUND(percentage, 2) AS percentage
FROM percentage
ORDER BY percentage DESC, contest_id ASC;

