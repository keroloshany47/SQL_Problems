SELECT person_name
FROM Queue AS q1
WHERE (
    SELECT SUM(weight)
    FROM Queue AS q2
    WHERE q2.turn <= q1.turn
) <= 1000
ORDER BY turn DESC
LIMIT 1;

