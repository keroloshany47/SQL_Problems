SELECT *
FROM LANGUAGE;
-- This query could be described in english as: "show me all the columns and the rows in the language table"

-- You can explicitly name the columns you are interested in, such as:
SELECT language.language_id, language.name, language.last_update
FROM language;

-- You can choose to include only a subset of the columns in the language table as well:
SELECT name
FROM language;

/* You can spice things up in your SELECT clause by including things such as:
	- Literals, such as numbers or strings
    - Expressions, such as (amount * -1)
    - Built-in functions, such as ROUND(amount, 2)
    - User-defined function calls
    
Let's take a look at the language table, then think about how can we get the following result set:
   
language_id  |  language_usage  |  lang_pi_value  (id * 3.14) |  language_name (upper case)
1				COMMON				3.14							ENGLISH
2				COMMON				6.28							ITALIAN
3				COMMON				9.42							JAPANESE
..................................................................................  */
SELECT language_id,  'COMMON' AS language_usage, (language_id * 3.14) AS lang_pi_value , UPPER(NAME) AS language_name
FROM language;




SELECT * 
FROM language;

SELECT 
	language_id,
    'COMMON' AS language_usage,
    language_id * 3.14 AS lang_pi_value,
    UPPER(name) AS language_name
FROM language;

/* If you only need to execute a built-in function or evaluate a simple expression, 
you can skip the from clause entirely */

SELECT version(), user(), database();

-- _____________________________________________________________________________________________________________________________________________
-- _____________________________________________________________________________________________________________________________________________

-- Removing Duplicates
/* In some cases, a query might return duplicate rows of data.
For example, if you were to retrieve the IDs of all actors who appeared in a film, you would see the following: */

SELECT actor_id
FROM film_actor 
ORDER BY actor_id;

/* Since some actors appeared in more than one film, you will see the same actor ID multiple times,
However, I want to see the distinct set of the actors, instead of seeing the actor IDs repeated for each film in which they appeared */

SELECT DISTINCT actor_id
FROM film_actor 
ORDER BY actor_id;

/* Important Note
Keep in mind that generating a distinct set of results requires the data to be sorted, which can be time consuming for large result sets.
Do NOT fall into the trap of using distinct just to be sure there are no duplicates; instead, take the time to understand tha data you are working with
so that you will know whether  duplicates are possible. */

-- _____________________________________________________________________________________________________________________________________________
-- _____________________________________________________________________________________________________________________________________________

/* [1] Derived (subquery-generated) tables
	It's a query contained within another query. It surrounded by parentheses and can be found in 
    various parts of a SELECT statement; within the FROM clause. */
    
-- Subquery
SELECT CONCAT(first_name, ' ', last_name) AS full_name, cust.address_id
FROM (
SELECT first_name, last_name, email, address_id
FROM customer
WHERE first_name = 'JESSIE'
) AS cust;


SELECT first_name, last_name, email
FROM customer
WHERE first_name = 'JESSIE';


/*  Execution Process

1. Derived Subquery Execution:

The subquery inside the FROM clause:
SELECT first_name, last_name, email
FROM customer
WHERE first_name = 'JESSIE'
is executed first, and its result set is held temporarily in memory.

2. Temporary Table Creation (in-memory):
This result acts like a temporary table, aliased as cust.

3. Outer Query:
The outer query selects from that result:
SELECT CONCAT(cust.first_name, ' ', cust.last_name) AS full_name
FROM cust;

4. Cleanup:
After the main query finishes, the temporary result from the subquery is discarded. */



/* [2] Temporary Tables
		Every relational database allows the ability to define volatile, or temporary tables. 
        These tables look just like permanent tables, but any data inserted into a temp. 
        table will disappear at some point (generally when your database session is closed). */
        
CREATE TEMPORARY TABLE actors_j (
	actor_id smallint(5),
    first_name varchar(45),
    last_name varchar(45)
);

INSERT INTO actors_j
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

SELECT *
FROM actors_j;


/* [3] Views- A view is a query is stored in the data dictionary, It looks and acts like a table, 
		but there is no data associated with a view (this is why it called a virual tables).
        You're not storing a copy of the data — you're storing the query definition.  */


SELECT * FROM CUSTOMER;

CREATE VIEW cust_vw AS 
SELECT customer_id, first_name, last_name, active
FROM customer;

SELECT *
FROM cust_vw;

-- Query the data dictionary
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'sakila';

SHOW FULL TABLES IN sakila
WHERE TABLE_TYPE = 'VIEW';

-- Additiona details you can query
SELECT 
    TABLE_NAME,
    VIEW_DEFINITION,
    DEFINER,
    SECURITY_TYPE,
    CHECK_OPTION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'sakila';

-- _____________________________________________________________________________________________________________________________________________
-- _____________________________________________________________________________________________________________________________________________

-- WHERE Clause
SELECT * 
FROM film;

SELECT title 
FROM film
WHERE rating = 'G' AND rental_duration >= 7;

-- _____________________________________________________________________________________________________________________________________________
-- _____________________________________________________________________________________________________________________________________________

-- GROUP BY and HAVING
SELECT CUSTOMER_ID, COUNT(*) NUM_RENTAL
FROM RENTAL
GROUP BY CUSTOMER_ID
ORDER BY NUM_RENTAL DESC;

-- _____________________________________________________________________________________________________________________________________________
-- _____________________________________________________________________________________________________________________________________________

-- ORDER BY 
SELECT c.first_name, c.last_name, time(r.rental_date) AS rental_time
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
ORDER BY c.last_name; -- you can order asc or desc

-- _____________________________________________________________________________________________________________________________________________
-- _____________________________________________________________________________________________________________________________________________

/* Execution Order */

SELECT CUSTOMER_ID, COUNT(*) NUM_RENTAL
FROM RENTAL
WHERE customer_id > 5
GROUP BY CUSTOMER_ID
HAVING COUNT(*) > 40
ORDER BY NUM_RENTAL DESC;

-- 1. FROM (Server take a  look at rental)
SELECT * 
FROM RENTAL;

-- 2. WHERE 
SELECT * 
FROM RENTAL
WHERE customer_id > 5;

-- 3. GROUP BY
-- 4. HAVING

-- 5. SELECT
-- 6. ORDER BY