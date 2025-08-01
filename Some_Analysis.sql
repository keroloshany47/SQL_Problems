-- 1. Retrieve all posts with location in 'agra', 'maharashtra', or 'west bengal'
SELECT *
FROM posts
WHERE location IN ('agra', 'maharashtra', 'west bengal');
--------------------------------------------------------------------------------
-- 2. Retrieve the top 5 hashtags by the number of follows (i.e., most followed hashtags)
SELECT TOP 5 
    h.hashtag_name AS [Hashtags], 
    COUNT(hf.hashtag_id) AS [Total Follows]
FROM hashtag_follow hf
JOIN hashtags h ON h.hashtag_id = hf.hashtag_id
GROUP BY h.hashtag_name
ORDER BY COUNT(hf.hashtag_id) DESC;
---------------------------------------------------------------------------------
-- 3. Retrieve the top 5 posts with the highest engagement rate,
-- where engagement is defined as the sum of likes and comments.
-- This query calculates total likes and total comments for each post,
-- then orders posts by the combined engagement in descending order.
SELECT TOP 5 
    p.post_id,
    p.caption,
    ISNULL(pl.LikeCount, 0) + ISNULL(cm.CommentCount, 0) AS Engagement,
    ISNULL(pl.LikeCount, 0) AS Likes,
    ISNULL(cm.CommentCount, 0) AS Comments
FROM posts p
LEFT JOIN (
    SELECT post_id, COUNT(*) AS LikeCount
    FROM post_likes
    GROUP BY post_id
) pl ON p.post_id = pl.post_id
LEFT JOIN (
    SELECT post_id, COUNT(*) AS CommentCount
    FROM comments
    GROUP BY post_id
) cm ON p.post_id = cm.post_id
ORDER BY Engagement DESC;
--------------------------------------------------------------------------------
-- 4. Retrieve users who have never made a post (i.e., most inactive users)
SELECT user_id, username AS [Most Inactive User]
FROM users
WHERE user_id NOT IN (SELECT user_id FROM posts);
--------------------------------------------------------------------------------
-- 5. Retrieve posts with the highest number of likes, ordered in descending order by like count
SELECT pl.user_id, pl.post_id, COUNT(*) AS LikeCount
FROM post_likes pl
JOIN posts p ON p.post_id = pl.post_id
GROUP BY pl.user_id, pl.post_id
ORDER BY COUNT(*) DESC;
--------------------------------------------------------------------------------
-- 6. Calculate the average number of posts per user (rounded to 2 decimal places)
SELECT ROUND(CAST(COUNT(post_id) AS DECIMAL(10,2)) / COUNT(DISTINCT user_id), 2) AS [Average Post per User]
FROM posts;
--------------------------------------------------------------------------------
-- 7. Retrieve login details by joining users and login tables
-- (SQL Server does not support NATURAL JOIN, so we use an explicit JOIN)
SELECT u.user_id, u.email, u.username, l.login_id AS login_number
FROM users u
JOIN login l ON u.user_id = l.user_id;
--------------------------------------------------------------------------------
-- 8. Analyze user login activity: Retrieve the number of logins per user per month.
-- This query extracts the month and year from each login_time,
-- then counts the number of logins per user for that period.
SELECT 
    u.user_id,
    u.username,
    DATEPART(YEAR, l.login_time) AS LoginYear,
    DATEPART(MONTH, l.login_time) AS LoginMonth,
    COUNT(l.login_id) AS LoginCount
FROM login l
JOIN users u ON l.user_id = u.user_id
GROUP BY 
    u.user_id,
    u.username,
    DATEPART(YEAR, l.login_time),
    DATEPART(MONTH, l.login_time)
ORDER BY u.user_id, LoginYear, LoginMonth;
--------------------------------------------------------------------------------
-- 9. Retrieve users who have never commented on any post
SELECT user_id, username AS [User Never Comment]
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);
--------------------------------------------------------------------------------
-- 10. Identify the most active commenters:
-- Retrieve the top 10 users with the highest average comments per post they've engaged in.
-- The query calculates total comments per user and divides by the number of posts they commented on.
WITH UserCommentStats AS (
    SELECT 
        u.user_id,
        u.username,
        COUNT(*) AS TotalComments,
        COUNT(DISTINCT c.post_id) AS UniquePostsCommented
    FROM comments c
    JOIN users u ON c.user_id = u.user_id
    GROUP BY u.user_id, u.username
)
SELECT TOP 10 
    user_id,
    username,
    TotalComments,
    UniquePostsCommented,
    ROUND(CAST(TotalComments AS DECIMAL(10,2)) / NULLIF(UniquePostsCommented,0), 2) AS AvgCommentsPerPost
FROM UserCommentStats
ORDER BY AvgCommentsPerPost DESC;
--------------------------------------------------------------------------------
-- 11. Analyze location-based engagement:
-- Retrieve the average number of likes and comments per post for each location.
-- This helps identify which locations have posts with higher engagement.
WITH PostEngagement AS (
    SELECT 
        p.location,
        p.post_id,
        ISNULL(pl.LikeCount, 0) AS Likes,
        ISNULL(cm.CommentCount, 0) AS Comments
    FROM posts p
    LEFT JOIN (
        SELECT post_id, COUNT(*) AS LikeCount
        FROM post_likes
        GROUP BY post_id
    ) pl ON p.post_id = pl.post_id
    LEFT JOIN (
        SELECT post_id, COUNT(*) AS CommentCount
        FROM comments
        GROUP BY post_id
    ) cm ON p.post_id = cm.post_id
)
SELECT 
    location,
    AVG(Likes) AS AvgLikes,
    AVG(Comments) AS AvgComments,
    AVG(Likes + Comments) AS AvgEngagement
FROM PostEngagement
GROUP BY location
ORDER BY AvgEngagement DESC;
--------------------------------------------------------------------------------
-- 12 Identify Influential Users:
-- Retrieve users who have the highest total engagement on their posts.
-- Total engagement is the sum of likes and comments on all posts by the user.
WITH UserPostEngagement AS (
    SELECT 
        p.user_id,
        SUM(ISNULL(pl.LikeCount, 0) + ISNULL(cm.CommentCount, 0)) AS TotalEngagement
    FROM posts p
    LEFT JOIN (
        SELECT post_id, COUNT(*) AS LikeCount
        FROM post_likes
        GROUP BY post_id
    ) pl ON p.post_id = pl.post_id
    LEFT JOIN (
        SELECT post_id, COUNT(*) AS CommentCount
        FROM comments
        GROUP BY post_id
    ) cm ON p.post_id = cm.post_id
    GROUP BY p.user_id
)
SELECT TOP 10 
    u.user_id,
    u.username,
    e.TotalEngagement
FROM UserPostEngagement e
JOIN users u ON e.user_id = u.user_id
ORDER BY e.TotalEngagement DESC;
-------------------------------------------------------------------------------
-- 13. Retrieve users who have posted more than 5 times, ordered by the number of posts descending
SELECT user_id, COUNT(user_id) AS post_count
FROM posts
GROUP BY user_id
HAVING COUNT(user_id) > 5
ORDER BY COUNT(user_id) DESC;
--------------------------------------------------------------------------------
-- 14. Retrieve entities (users) who have more than 40 followers, ordered by follower count descending
SELECT followee_id, COUNT(follower_id) AS follower_count
FROM follows
GROUP BY followee_id
HAVING COUNT(follower_id) > 40
ORDER BY COUNT(follower_id) DESC;
--------------------------------------------------------------------------------
-- 15. Retrieve comments that contain either the word "good" or "beautiful"
-- Note: SQL Server does not support REGEXP, so we use LIKE instead.
SELECT *
FROM comments
WHERE comment_text LIKE '%good%'
   OR comment_text LIKE '%beautiful%';
--------------------------------------------------------------------------------
-- 16. Retrieve the top 5 posts with the longest captions, ordered by caption length in descending order
SELECT TOP 5 
    user_id, 
    caption, 
    LEN(caption) AS caption_length
FROM posts
ORDER BY LEN(caption) DESC;
----------------------------------------------------------------------------------------------------