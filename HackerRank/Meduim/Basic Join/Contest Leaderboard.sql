SELECT h.hacker_id,
       h.name,
       SUM(bs.max_score) AS total_score
FROM Hackers h
JOIN (
    SELECT hacker_id, challenge_id, MAX(score) AS max_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) AS best_scores
  ON h.hacker_id = best_scores.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(best_scores.max_score) > 0
ORDER BY total_score DESC, h.hacker_id ASC;
