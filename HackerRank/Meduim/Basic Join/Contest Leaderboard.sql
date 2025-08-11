SELECT h.hacker_id,
       h.name,
       SUM(best_score.max_score) AS total_score
FROM Hackers AS h
JOIN (
    SELECT hacker_id, challenge_id, MAX(score) AS max_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) AS best_score 
  ON h.hacker_id = best_score.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(best_score.max_score) > 0
ORDER BY total_score DESC, h.hacker_id ASC;
