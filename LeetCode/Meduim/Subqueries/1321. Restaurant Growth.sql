-- Write your MySQL query statement below
WITH DailySums AS (
    SELECT 
        visited_on,
        SUM(amount) as daily_total
    FROM Customer
    GROUP BY visited_on
)
SELECT 
    d1.visited_on,
    SUM(d2.daily_total) as amount,
    ROUND(AVG(d2.daily_total), 2) as average_amount
FROM DailySums d1
JOIN DailySums d2 
ON d2.visited_on BETWEEN 
    DATE_SUB(d1.visited_on, INTERVAL 6 DAY) AND d1.visited_on
GROUP BY d1.visited_on
HAVING COUNT(d2.visited_on) = 7  -- Ensure we have exactly 7 days
ORDER BY d1.visited_on;
