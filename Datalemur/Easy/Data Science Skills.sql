-- first solution 
SELECT candidate_id  
FROM candidates
GROUP BY candidate_id
HAVING SUM (  Case WHEN skill = "Python" THEN 1 
                   WHEN skill = "PostgreSQL" THEN 1 
                   WHEN skill = "Tableau" THEN 1 
                        ELSE 0 end )=3
ORDER BY candidate_id ASC;
-- second solution 
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id ASC;
