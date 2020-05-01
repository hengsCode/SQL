-- Casteel Chapter 8, pp. 277-281
-- Restricting Rows and Sorting Data

-- 1. Which customers live in New Jersey? List each customer’s last name, first name, and state.

-- Use WHERE clause to restrict records
-- Use ' ' for string comparisons and also remember that strings are case sensitive!!!!
-- Use of UPPER to ensure that data values in STATE are consistent (i.e. all in uppercase)

SELECT LASTNAME, FIRSTNAME, STATE
FROM CUSTOMERS
WHERE UPPER(STATE) = 'NJ';

-- 3. Which books aren’t in the Fitness category? List each book title and category.

-- Can use NOT IN or <> 
-- Since we only care about books not in a specific category you'd probably use <> instead
-- But with coding you should always think about writing code that doesn't need to be changed a lot when new information 
-- is provided ... Books that aren't in Fitness and Computer 

SELECT TITLE, CATEGORY
FROM BOOKS
WHERE UPPER(CATEGORY) NOT IN ('FITNESS');

-- OR

SELECT TITLE, CATEGORY
FROM BOOKS
WHERE UPPER(CATEGORY) <> 'FITNESS';

-- 5. Which orders were placed on or before April 1, 2009? List each order number and order
-- date.

SELECT ORDER#, ORDERDATE
FROM ORDERS
WHERE ORDERDATE <= '01-APR-09';

-- 7. List all customers who were referred to the bookstore by another customer. List each
-- customer’s last name and the number of the customer who made the referral.

-- IS NOT NULL restricts records to those that are non-null
-- Need to use IS to consider NULL values and not logical operators like =

SELECT LASTNAME, REFERRED 
FROM CUSTOMERS
WHERE REFERRED IS NOT NULL;

-- 9. Use a search pattern to find any book title with “A” for the second letter and “N” for the
-- fourth letter. List each book’s ISBN and title. Sort the list by title in descending order.

-- Use wildcards '_' (single char) and '%' (filler char)
-- Use ORDER BY COLUMN DESC for descending order

SELECT ISBN, TITLE
FROM BOOKS
WHERE UPPER(TITLE) LIKE '_A_N%'
ORDER BY TITLE DESC;

-- 10. List the title and publish date of any computer book published in 2005. Perform the task of
-- searching for the publish date by using three different methods: a) a range operator, b) a logical
-- operator, and c) a search pattern operation.

-- BETWEEN as a range operator
-- Note that BETWEEN also includes the specified range indexes

-- a)
SELECT TITLE, PUBDATE
FROM BOOKS
WHERE UPPER(CATEGORY) IN ('COMPUTER') AND PUBDATE BETWEEN '01-JAN-05' AND '31-DEC-05';

-- Can't simultaneously do <= <=, so you must have AND

-- b)
SELECT TITLE, PUBDATE
FROM BOOKS
WHERE UPPER(CATEGORY) IN ('COMPUTER') AND PUBDATE >= '01-JAN-05' AND PUBDATE <= '31-DEC-05';

-- Wildcard to get all dates in the year 2005

SELECT TITLE, PUBDATE
FROM BOOKS
WHERE UPPER(CATEGORY) IN ('COMPUTER') AND PUBDATE >= '01-JAN-05' AND PUBDATE <= '31-DEC-05';
c)
SELECT TITLE, PUBDATE
FROM BOOKS
WHERE UPPER(CATEGORY) IN ('COMPUTER') AND PUBDATE LIKE '%05';

-- During an afternoon at work, you receive various requests for data stored in the database. As
-- you fulfill each request, you decide to document the SQL statements you used to find the data
-- to assist with future requests. The following are two of the requests that were made:

-- 1. A manager at JustLee Books requests a list of the titles of all books generating a profit of
-- at least $10.00. The manager wants the results listed in descending order, based on each
-- book’s profit.

SELECT TITLE
FROM BOOKS
WHERE (RETAIL - COST) >= 10
ORDER BY (RETAIL - COST) DESC;

-- 2. A customer service representative is trying to identify all books in the Computer or Family
-- Life category and published by Publisher 1 or Publisher 3. However, the results shouldn’t
-- include any book selling for less than $45.00.

-- Note that IN is an OR function 

SELECT TITLE
FROM BOOKS
WHERE UPPER(CATEGORY) IN ('COMPUTER', 'FAMILY LIFE') AND PUBID IN (1, 3) AND RETAIL >= 45;
