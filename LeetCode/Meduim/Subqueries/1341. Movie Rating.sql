(
    SELECT name AS results
    FROM (
        SELECT u.name, COUNT(mr.movie_id) AS cnt
        FROM Users u
        JOIN MovieRating mr ON u.user_id = mr.user_id
        GROUP BY u.user_id, u.name
        ORDER BY cnt DESC, u.name ASC
        LIMIT 1
    ) AS top_user
)

UNION ALL

(
    SELECT title AS results
    FROM (
        SELECT m.title, AVG(mr.rating) AS avg_rating
        FROM Movies m
        JOIN MovieRating mr ON m.movie_id = mr.movie_id
        WHERE mr.created_at >= '2020-02-01' 
          AND mr.created_at < '2020-03-01'
        GROUP BY m.movie_id, m.title
        ORDER BY avg_rating DESC, m.title ASC
        LIMIT 1
    ) AS top_movie
);
