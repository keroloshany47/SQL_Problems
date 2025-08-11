WITH counts AS (
    SELECT h.hacker_id, h.name, COUNT(c.challenge_id) AS total_challenges
    FROM Hackers h
    JOIN Challenges c ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
),
max_count AS (
    SELECT MAX(total_challenges) AS max_ch FROM counts
)
SELECT *
FROM counts
WHERE total_challenges = (SELECT max_ch FROM max_count)
   OR total_challenges NOT IN (
        SELECT total_challenges
        FROM counts
        GROUP BY total_challenges
        HAVING COUNT(*) > 1
   )
ORDER BY total_challenges DESC, hacker_id;
