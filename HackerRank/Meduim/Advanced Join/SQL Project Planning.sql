/*
Enter your query here.
*/
WITH ordered AS (
    SELECT 
        Start_Date,
        End_Date,
        LAG(End_Date) OVER (ORDER BY Start_Date) AS prev_end
    FROM Projects
),
flagged AS (
    SELECT 
        Start_Date,
        End_Date,
        CASE 
            WHEN prev_end = Start_Date THEN 0 
            ELSE 1 
        END AS is_new
    FROM ordered
),
project_groups AS (
    SELECT 
        Start_Date,
        End_Date,
        SUM(is_new) OVER (ORDER BY Start_Date ROWS UNBOUNDED PRECEDING) AS project_id
    FROM flagged
)
SELECT 
    MIN(Start_Date) AS project_start,
    MAX(End_Date)   AS project_end
FROM project_groups
GROUP BY project_id
ORDER BY DATEDIFF(MAX(End_Date), MIN(Start_Date)), MIN(Start_Date);

