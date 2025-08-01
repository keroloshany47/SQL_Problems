-- Exercise 1 (return 200 rows)
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name, first_name;

-- Exercise 2 (return 6 rows)
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'WILLIAMS' OR last_name = 'DAVIS'
ORDER BY last_name, first_name;

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name IN ('WILLIAMS', 'DAVIS')
ORDER BY last_name, first_name;
