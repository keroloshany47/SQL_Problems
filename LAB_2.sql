-- Exercise 1
SELECT p.payment_id
FROM (
	SELECT payment_id, customer_id, amount, date(payment_date) as payment_date
	FROM PAYMENT
	WHERE customer_id in (4, 5) AND payment_id BETWEEN 101 AND 120
) p
WHERE p.customer_id <> 5 AND (p.amount > 8 OR DATE(p.payment_date) = '2005-08-23');

-- Exercise 2
SELECT p.payment_id
FROM (
	SELECT payment_id, customer_id, amount, date(payment_date) as payment_date
	FROM PAYMENT
	WHERE customer_id in (4, 5) AND payment_id BETWEEN 101 AND 120
) p
WHERE p.customer_id = 5 AND NOT (p.amount > 6 OR DATE(p.payment_date) = '2005-06-19');


-- Exercise 3
SELECT *
FROM PAYMENT
WHERE AMOUNT IN (1.98, 7.98, 9.98);


-- Exercise 4
SELECT FIRST_NAME, LAST_NAME
FROM CUSTOMER
WHERE LAST_NAME LIKE '_A%W%';

SELECT payment_id, customer_id, amount, date(payment_date) as payment_date
FROM PAYMENT
WHERE customer_id in (4, 5) AND payment_id BETWEEN 101 AND 120;