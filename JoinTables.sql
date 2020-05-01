-- Casteel Chapter 9, pp. 323-330
-- Joining Data from Multiple Tables

-- 1. Create a list that displays the title of each book and the name and phone number of the
-- contact at the publisher‘s office for reordering each book.

-- IMPLICT (INNER) JOIN, takes only the intersect between the two

SELECT B.TITLE, P.NAME, P.PHONE
FROM BOOKS B
JOIN PUBLISHER P
ON B.PUBID = P.PUBID;

-- 3. Produce a list of all customers who live in the state of Florida and have ordered books about
-- computers.

SELECT DISTINCT C.CUSTOMER#
FROM CUSTOMERS C
JOIN ORDERS O
ON C.CUSTOMER# = O.CUSTOMER#
JOIN ORDERITEMS OI
ON O.ORDER# = OI.ORDER#
JOIN BOOKS B
ON OI.ISBN = B.ISBN
WHERE UPPER(C.STATE) = 'FL' AND UPPER(B.CATEGORY) IN ('COMPUTER');

-- 4. Determine which books customer Jake Lucas has purchased. Perform the search using the
-- customer name, not the customer number. If he has purchased multiple copies of the same
-- book, unduplicate the results.

SELECT DISTINCT B.TITLE
FROM BOOKS B
JOIN ORDERITEMS OI
ON B.ISBN = OI.ISBN
JOIN ORDERS O
ON O.ORDER# = OI.ORDER#
JOIN CUSTOMERS C
ON C.CUSTOMER# = O.CUSTOMER#
WHERE UPPER(C.FIRSTNAME) = 'JAKE' AND UPPER(C.LASTNAME) = 'LUCAS';

-- 5. Determine the profit of each book sold to Jake Lucas, using the actual price the customer
-- paid (not the book‘s regular retail price). Sort the results by order date. If more than one book
-- was ordered, sort the results by profit amount in descending order. Perform the search using the
-- customer name, not the customer number.

SELECT (OI.QUANTITY * OI.PAIDEACH - B.COST) AS "Profit"
FROM BOOKS B
JOIN ORDERITEMS OI
ON B.ISBN = OI.ISBN
JOIN ORDERS O
ON O.ORDER# = OI.ORDER#
JOIN CUSTOMERS C
ON C.CUSTOMER# = O.CUSTOMER#
WHERE (UPPER(C.FIRSTNAME), UPPER(C.LASTNAME)) IN (('JAKE', 'LUCAS'));

-- 9. Display a list of all books in the BOOKS table. If a book has been ordered by a customer,
-- also list the corresponding order number and the state in which the customer resides.

SELECT B.TITLE, O.ORDER#, C.STATE
FROM BOOKS B
JOIN ORDERITEMS OI
ON B.ISBN = OI.ISBN
JOIN ORDERS O
ON O.ORDER# = OI.ORDER#
JOIN CUSTOMERS C
ON C.CUSTOMER# = O.CUSTOMER#;

-- REVIEW THIS ONE 
-- 10. An EMPLOYEES table was added to the JustLee Books database to track employee
-- information. Display a list of each employee‘s name, job title, and manager‘s name. Use
-- column aliases to clearly identify employee and manager name values. Include all employees in
-- the list and sort by manager name.

SELECT E.FIRST_NAME || ' ' || E.LAST_NAME AS "Employee Name", J.JOB_TITLE, ME.FIRST_NAME || ' ' || ME.LAST_NAME AS "Manager Name"
FROM EMPLOYEES E
LEFT OUTER JOIN EMPLOYEES ME
ON E.MANAGER_ID = ME.EMPLOYEE_ID
JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY "Manager Name";

-- The Marketing Department of JustLee Books is preparing for its annual sales promotion. Each
-- customer who places an order during the promotion will receive a free gift with each book
-- purchased. Each gift will be based on the book‘s retail price. JustLee Books also participates in
-- co-op advertising programs with certain publishers. If the publisher‘s name is included in
-- advertisements, JustLee Books is reimbursed a certain percentage of the advertisement costs.

-- To determine the projected costs of this year‘s sales promotion, the Marketing Department
-- needs the publisher‘s name, profit amount, and free gift description for each book in the
-- JustLee Books inventory.

-- Used sub-query in WHERE clause to grab the gift associated with the retail price for each book

SELECT P.NAME, (B.RETAIL - B.COST) AS "Profit", PT.GIFT
FROM PROMOTION PT, PUBLISHER P
JOIN BOOKS B
ON P.PUBID = B.PUBID
WHERE PT.GIFT = (SELECT GIFT FROM PROMOTION WHERE B.RETAIL BETWEEN MINRETAIL AND MAXRETAIL);

-- Also, the Marketing Department is analyzing books that don‘t sell. A list of ISBNs for allbooks
-- with no sales recorded is needed. Use a set operation to complete this task.

-- Use LEFT OUTER JOIN to get the left side union of BOOKS (i.e. everything in books)
    
SELECT B.ISBN
FROM BOOKS B
LEFT OUTER JOIN ORDERITEMS O
ON B.ISBN = O.ISBN
WHERE O.ORDER# IS NULL;

