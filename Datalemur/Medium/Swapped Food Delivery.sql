WITH order_counts AS (
  SELECT COUNT(order_id) AS oc
  FROM orders
)

SELECT
  CASE
    WHEN order_id % 2 != 0 AND order_id != oc THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = oc THEN order_id
    ELSE order_id - 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN order_counts
ORDER BY corrected_order_id;



-------------------------------------------------------------------------
-- this is AI solution but i really like it 
SELECT
    order_id AS corrected_order_id,
    CASE
        WHEN order_id % 2 = 1 
             AND order_id != (SELECT MAX(order_id) FROM orders)
        THEN LEAD(item) OVER (ORDER BY order_id)      -- odd → خُد اللي بعده
        WHEN order_id % 2 = 0 
        THEN LAG(item) OVER (ORDER BY order_id)       -- even → خُد اللي قبله
        ELSE item                                     -- آخر odd يفضل زي ما هو
    END AS item
FROM orders
ORDER BY order_id;
