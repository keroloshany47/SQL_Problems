
SELECT sub.submission_date,
       (SELECT COUNT(DISTINCT hacker_id)
        FROM Submissions s1
        WHERE NOT EXISTS (
            SELECT 1
            FROM (
                SELECT DISTINCT submission_date
                FROM Submissions
                WHERE submission_date <= sub.submission_date
            ) d
            WHERE NOT EXISTS (
                SELECT 1
                FROM Submissions s2
                WHERE s2.hacker_id = s1.hacker_id
                  AND s2.submission_date = d.submission_date
            )
        )
       ) AS unique_hackers,
       s.hacker_id,
       h.name
FROM (
    SELECT submission_date, hacker_id
    FROM (
        SELECT submission_date,
               hacker_id,
               RANK() OVER (PARTITION BY submission_date
                            ORDER BY COUNT(*) DESC, hacker_id ASC) rnk
        FROM Submissions
        GROUP BY submission_date, hacker_id
    ) ranked
    WHERE rnk = 1
) s
JOIN Hackers h ON s.hacker_id = h.hacker_id
JOIN (SELECT DISTINCT submission_date FROM Submissions) sub
     ON s.submission_date = sub.submission_date
ORDER BY sub.submission_date;

