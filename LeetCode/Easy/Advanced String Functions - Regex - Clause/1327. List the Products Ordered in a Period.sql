SELECT P.product_name ,SUM(O.unit) AS unit 
FROM Products AS P
JOIN Orders AS O
ON P.product_id = O.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
