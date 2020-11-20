-- Casteel Chapter 12, pp. 462-468
-- Subqueries

-- 1. List the book title and retail price for all books with a retail price lower than the average
-- retail price of all books sold by JustLee Books.

SELECT B.TITLE, B.RETAIL 
FROM BOOKS B
WHERE B.RETAIL < (SELECT AVG(RETAIL) FROM BOOKS);

-- 2. Determine which books cost less than the average cost of other books in the same category.

SELECT B.TITLE
FROM BOOKS B
WHERE B.COST < (SELECT AVG(B2.COST) FROM BOOKS B2 WHERE B.CATEGORY = B2.CATEGORY GROUP BY B2.CATEGORY); 

SELECT B.TITLE
FROM BOOKS B
JOIN (SELECT CATEGORY, AVG(COST) AS "Average Cost/Category" FROM BOOKS GROUP BY CATEGORY) B2
ON B.CATEGORY = B2.CATEGORY
WHERE B.COST < B2."Average Cost/Category";

-- 3. Determine which orders were shipped to the same state as order 1014.

SELECT O.ORDER#
FROM ORDERS O
WHERE O.SHIPSTATE = (SELECT SHIPSTATE FROM ORDERS WHERE ORDER# = 1014);

-- 4. Determine which orders had a higher total amount due than order 1008.

SELECT OI.ORDER#, SUM(OI.QUANTITY * OI.PAIDEACH) AS "TOTAL"
FROM ORDERITEMS OI
GROUP BY OI.ORDER#
HAVING SUM(OI.QUANTITY * OI.PAIDEACH) > (SELECT SUM(QUANTITY * PAIDEACH) FROM ORDERITEMS WHERE ORDER# = 1008);

-- 5. Determine which author or authors wrote the books most frequently purchased by customers
-- of JustLee Books

SELECT A.FNAME, A.LNAME
FROM AUTHOR A
JOIN BOOKAUTHOR BA
ON A.AUTHORID = BA.AUTHORID
WHERE BA.ISBN IN (SELECT ISBN FROM ORDERITEMS GROUP BY ISBN HAVING SUM(QUANTITY) = (SELECT MAX(COUNT(*)) FROM ORDERITEMS GROUP BY ISBN));

