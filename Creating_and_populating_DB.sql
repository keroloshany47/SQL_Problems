-- 1. PERSON Table
CREATE TABLE PERSON (
PERSON_ID SMALLINT UNSIGNED,
FNAME VARCHAR(20),
LNAME VARCHAR(20),
EYE_COLOR CHAR(2) ,
BIRTH_DATE DATE,
STREET VARCHAR(30),
CITY VARCHAR(20),
STATE VARCHAR(20),
COUNRTY VARCHAR(20),
POSTAL_CODE VARCHAR(20),
CONSTRAINT PK_PERSON PRIMARY KEY (PERSON_ID)
);


-- CHECK CONSTRAINTS
/* MySQL allows a check constraint to be attached to a column definition:
eye_color char(2) check (eye_color in ('BR, 'BL', 'GR'))
While the check constraint operates as expected on most database servers, the MySQL
server allows check constraints to be defined but does not enforce them.

However, MySQL provides another characher data type called 'ENUM' that merges
the check constraint into the data type definition. */

CREATE TABLE PERSON (
PERSON_ID SMALLINT UNSIGNED,
FNAME VARCHAR(20),
LNAME VARCHAR(20),
EYE_COLOR ENUM('BR', 'BL', 'GR') ,
BIRTH_DATE DATE,
STREET VARCHAR(30),
CITY VARCHAR(20),
STATE VARCHAR(20),
COUNRTY VARCHAR(20),
POSTAL_CODE VARCHAR(20),
CONSTRAINT PK_PERSON PRIMARY KEY (PERSON_ID)
);

-- If you want to make sure that the person table created as expected:
DESC PERSON;
/*
col 1: filed name
col 2: data type
col 3: Is it nullable? (can has a null value or not?)
col 4: whether a column takes part in amy keys (PK or FK)
col 5: whether the column will be populated with a default value if you omit the column (insert)
col 6: show any other pertinent info. that might apply to a column.
*/

-- Take a look at the Null column, do you notice anything?


-- 2. FAVORITE_FOOD Table
CREATE TABLE FAVORITE_FOOD (
PERSON_ID SMALLINT UNSIGNED,
FOOD VARCHAR(20),
CONSTRAINT PK_FAVORITE_FOOD PRIMARY KEY (PERSON_ID, FOOD),
CONSTRAINT FK_FAV_FOOD_PERSON_ID FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
);

/*
The FK column defined in the many side of the relationship between two tables. 

This constraints the values of the person_id column in the favorite_food table to include
only values found in the person table.

With this constraint, I will not be able to add a row to the favorite_food table indicating
that person_id 27 likes pizza if there isn't already a row in person table having
a person_id of 27.
*/

DESC FAVORITE_FOOD;

-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------


/* Generation Numeric Key Data */

/* 
You will first need to disable the FK constraint on the favorite_food table,
and then re-enable the constraints when finished 
*/

SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE PERSON 
	MODIFY PERSON_ID SMALLINT UNSIGNED AUTO_INCREMENT;
    
SET FOREIGN_KEY_CHECKS = 1;

/* 
When you insert data into the person table, you simply provide a null value for the person_id 
column, and MySQL will populate the column with the next available number 
(by default, MySQL starts at 1 for auto-increment columns).
*/

-- Lets take a look at the table description (definition)
DESC PERSON;

-- 3. Inserting data into the person table
INSERT INTO PERSON (PERSON_ID, FNAME, LNAME, EYE_COLOR, BIRTH_DATE)
VALUES (NULL, 'William', 'Turner', 'BR', '1972-05-27');


SELECT PERSON_ID, FNAME, LNAME, EYE_COLOR, BIRTH_DATE
FROM PERSON;

/*
The value provided for the birth_date column was a string, As long as you match the required 
format, MySQL will convert the string to a date for you.

The column names and the values provided must correspond in number and type. 
If you name 7 columns and provide only 6 values or if you provide values that can not be 
converted to the appropriate data type for the corresponding column, you'll receive an error.
*/

-- Willam Turner has provided info. about his favorite food:
INSERT INTO FAVORITE_FOOD (PERSON_ID, FOOD)
VALUES (1, 'pizza');
INSERT INTO FAVORITE_FOOD (PERSON_ID, FOOD)
VALUES (1, 'cookies');
INSERT INTO FAVORITE_FOOD (PERSON_ID, FOOD)
VALUES (1, 'nachos');

SELECT food
FROM FAVORITE_FOOD
ORDER BY food;

-- Write an INSERT statement to add Susan Smith to the person table as:
/*
- First name: Susan
- Last name: Smith
- Eye color: Blue
- Birth date: 1975-11-02
- Street: 23 Maple St.
- City: Arlington
- State: VA
- Country: USA
- Postal code: 20220
*/

SELECT PERSON_ID, FNAME, LNAME, BIRTH_DATE
FROM PERSON;


-- 4. Updating the data
/* Let's update the address data for William Turner
- Street: 1225 Tremont St.
- City: Boston
- State: MA
- Country: 'USA'
- Postal code: 02138 */

UPDATE PERSON
SET STREET = '1225 Tremont St.',
	CITY = 'Boston',
	STATE = 'MA',
    COUNRTY = 'USA',
    POSTAL_CODE = '02138'
WHERE PERSON_ID = 1;

SELECT * 
FROM PERSON
WHERE PERSON_ID = 1;

/* The server responded with two lines:
- Rows matched: 1, tells you that the condition in the WHERE clause matched 
a single row in the table.

- Changed: 1, tells you that a single row in the table has been modified.

NOTE: if you leave off the WHERE clause, you UPDATE statement will modify every row in the table. */

-- 5. Deleting Data
DELETE FROM PERSON
WHERE PERSON_ID = 2;

SELECT *
FROM PERSON;

/* Like the UPDATE statement, more than one row can be deleted depending on the 
conditions in your WHERE clause, and all rows will be deleted if the WHERE clause is omitted.*/


-- Non unique primary key
INSERT INTO PERSON (PERSON_ID, FNAME, LNAME, EYE_COLOR, BIRTH_DATE)
VALUES(1, 'Charles', 'Fulton', 'GR', '1968-01-15');

-- Non existent foreign key
INSERT INTO FAVORITE_FOOD (PERSON_ID, FOOD)
VALUES(999, 'Fish');

-- Column value violations
UPDATE PERSON
SET EYE_COLOR = 'ZZ'
WHERE PERSON_ID = 1;

-- Invalid data conversions
UPDATE PERSON
SET BIRTH_DATE = 'DEC-21-1980'
WHERE PERSON_ID = 1;

/* In general it's a good idea to explicitly specify the format string rather than 
relying on the default format. 

Here's another verion of the statement that uses the str_to_date function to 
specify which format string to use: */

SELECT BIRTH_DATE 
FROM PERSON;

UPDATE PERSON
SET BIRTH_DATE = str_to_date('DEC-21-1980', '%b-%d-%Y')
WHERE PERSON_ID = 1;

SELECT BIRTH_DATE 
FROM PERSON;