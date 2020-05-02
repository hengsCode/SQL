-- Casteel Chapter 5, pp. 167-172
-- Data Manipulation Language (DML) and Transaction Control

-- 1. Add a new row in the ORDERS table with the following data: Order# = 1021, Customer# =
-- 1009, and Order date = July 20, 2009.

DELETE FROM ORDERS
WHERE ORDER# = 1021;

INSERT INTO ORDERS (ORDER#, CUSTOMER#, ORDERDATE)
VALUES (1021, 1009, '20-JUL-09');

SELECT ORDER#, CUSTOMER#, ORDERDATE
FROM ORDERS
WHERE ORDER# = 1021;

-- 2. Modify the zip code on order 1017 to 33222.

UPDATE ORDERS
SET SHIPZIP = 33222
WHERE ORDER# = 1017;

SELECT SHIPZIP
FROM ORDERS
WHERE ORDER# = 1017;

-- 4. Add a new row in the ORDERS table with the following data: Order# = 1022, Customer# =
-- 2000, and Order date = August 6, 2009. Describe the error raised and what caused the error.

INSERT INTO ORDERS (ORDER#, CUSTOMER#, ORDERDATE)
VALUES (1022, 2000, '06-AUG-09');

-- There is no valid PK Value of 2000 for the FK CUSTOMER# in table CUSTOMERS)

-- 6. Create a script using substitution variables that allows a user to set a new cost amount for a
-- book based on the ISBN.

UPDATE BOOKS
SET COST = '&Cost'
WHERE ISBN = '&ISBN';

-- 7. Execute the script and set the following values: isbn = 1059831198 and cost = $20.00.

SELECT ISBN, TO_CHAR(COST, '$99.99') NEW_COST
FROM BOOKS
WHERE ISBN = 1059831198;

-- 9. Delete Order# 1005. You need to address both the master order record and the related detail
-- records.

DELETE FROM ORDERITEMS
WHERE ORDER# = 1005;

DELETE FROM ORDERS
WHERE ORDER# = 1005;

SELECT *
FROM ORDERS
WHERE ORDER# = 1005;

SELECT *
FROM ORDERITEMS
WHERE ORDER# = 1005;