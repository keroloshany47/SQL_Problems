/*
Enter your query here.
Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
*/
SELECT con.contest_id,
       con.hacker_id,
       con.name,
       SUM(COALESCE(ss.total_submissions, 0))            AS total_submissions,
       SUM(COALESCE(ss.total_accepted_submissions, 0))   AS total_accepted_submissions,
       SUM(COALESCE(vs.total_views, 0))                  AS total_views,
       SUM(COALESCE(vs.total_unique_views, 0))           AS total_unique_views
FROM Contests con
JOIN Colleges col   ON con.contest_id = col.contest_id
JOIN Challenges cha ON col.college_id = cha.college_id
LEFT JOIN (
    SELECT challenge_id,
           SUM(total_views)          AS total_views,
           SUM(total_unique_views)   AS total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
) vs ON cha.challenge_id = vs.challenge_id
LEFT JOIN (
    SELECT challenge_id,
           SUM(total_submissions)           AS total_submissions,
           SUM(total_accepted_submissions)  AS total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
) ss ON cha.challenge_id = ss.challenge_id
GROUP BY con.contest_id, con.hacker_id, con.name
HAVING SUM(COALESCE(ss.total_submissions, 0))
     + SUM(COALESCE(ss.total_accepted_submissions, 0))
     + SUM(COALESCE(vs.total_views, 0))
     + SUM(COALESCE(vs.total_unique_views, 0)) > 0
ORDER BY con.contest_id;

