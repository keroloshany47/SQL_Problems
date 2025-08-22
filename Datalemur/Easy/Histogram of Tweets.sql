SELECT
    tweet_count AS tweet_bucket,
    COUNT(*) AS users_num
FROM (
    SELECT
        user_id,
        COUNT(*) AS tweet_count
    FROM tweets
    WHERE tweet_date >= '2022-01-01'
      AND tweet_date < '2023-01-01'
    GROUP BY user_id
) AS user_tweet_counts
GROUP BY tweet_count
ORDER BY tweet_bucket;
