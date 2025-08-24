SELECT sender_id, COUNT(message_id) AS message_count
FROM messages
WHERE DATE(sent_date) BETWEEN '2022-08-01' AND '2022-08-31'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
