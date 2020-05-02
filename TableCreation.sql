-- Casteel Chapter 3, pp. 90-95
-- Table Creation, Constraints and Management

-- 1. Create a new table containing the category code and description for the categories of books
-- sold by JustLee Books. The table should be called CATEGORY, and the columns should be
-- CatCode and CatDesc. The CatCode column should store a maximum of 2 characters, and the
-- CatDesc column should store a maximum of 10 characters.

DROP TABLE CATEGORY;
CREATE TABLE CATEGORY (
    CatCode VARCHAR(2),
    CatDesc VARCHAR(10)
);    

DESCRIBE CATEGORY;

-- 2. Create a new table containing these four columns: Emp#, Lastname, Firstname, and
-- Job_class. The table name should be EMPLOYEES. The Job_class column should be able to
-- store character strings up to a maximum length of four, but the column values shouldn’t be
-- padded if the value has less than four characters. The Emp# column contains a numeric ID and
-- should allow a five-digit number. Use column sizes you consider suitable for the Firstname and
-- Lastname columns.

CREATE TABLE EMPLOYEES_NEW (
    Emp# NUMBER(5),
    Lastname VARCHAR(10),
    Firstname VARCHAR(10),
    Job_class CHAR(4)
);    

-- 3. Add two columns to the EMPLOYEES table. One column, named EmpDate, contains the
-- date of employment for each employee, and its default value should be the system date. The
-- second column, named EndDate, contains employees’ date of termination.

ALTER TABLE EMPLOYEES_NEW 
ADD (EmpDate DATE DEFAULT SYSDATE,
        EndDate DATE);

DESCRIBE EMPLOYEES_NEW;        

-- 4. Modify the Job_class column of the EMPLOYEES table so that it allows storing a maximum
-- width of two characters.

ALTER TABLE EMPLOYEES_NEW
MODIFY (JOB_CLASS CHAR(2));

DESCRIBE EMPLOYEES_NEW;

-- 5. Delete the EndDate column from the EMPLOYEES table.

ALTER TABLE EMPLOYEES_NEW
DROP COLUMN EndDate;

-- 6. Rename the EMPLOYEES table as JL_EMPS

DROP TABLE JL_EMPS;
RENAME EMPLOYEES_NEW TO JL_EMPS;

-- Chapter 4, pp. 129-134

-- 1. Modify the following SQL command so that the Rep_ID column is the PRIMARY KEY for
-- the table and the default value of Y is assigned to the Comm column. (The Comm column
-- indicates whether the sales representative earns commission.)
-- CREATE TABLE store_reps
-- (rep_ID NUMBER(5),
-- last VARCHAR2(15),
-- first VARCHAR2(10),
-- comm CHAR(1) );

DROP TABLE STORE_REPS CASCADE CONSTRAINTS;
CREATE TABLE STORE_REPS (
    REP_ID NUMBER(5),
    LAST VARCHAR2(15),
    FIRST VARCHAR2(10),
    COMM CHAR(1) DEFAULT 'Y',
    CONSTRAINT STORE_REPS_PK PRIMARY KEY (REP_ID)
);    

DESCRIBE STORE_REPS;

-- 2. Change the STORE_REPS table so that NULL values can’t be entered in the name columns
-- (First and Last).

ALTER TABLE STORE_REPS
MODIFY (FIRST NOT NULL, LAST NOT NULL);

-- 3. Change the STORE_REPS table so that only a Y or N can be entered in the Comm column.

ALTER TABLE STORE_REPS
ADD (CONSTRAINT CHECKY_N_COMM CHECK (Comm IN ('Y', 'N')));

-- 4. Add a column named Base_salary with a datatype of NUMBER(7,2) to the STORE_REPS
-- table. Ensure that the amount entered is above zero.

ALTER TABLE STORE_REPS
ADD (BASE_SALARY NUMBER(7, 2), CONSTRAINT CHECK_GREATER_ZERO_BASESALARY CHECK (BASE_SALARY > 0));

-- 5. Create a table named BOOK_STORES to include the columns listed in the following chart:

DROP TABLE BOOK_STORES;
CREATE TABLE BOOK_STORES (
    STORE_ID NUMBER(8) CONSTRAINT STORE_ID_PK PRIMARY KEY,
    NAME VARCHAR2(30) CONSTRAINT UNIQUE_NAME UNIQUE NOT NULL,
    CONTACT VARCHAR2(30),
    REP_ID VARCHAR2(5)
);

-- 6. Add a constraint to make sure the Rep_ID value entered in the BOOK_STORES table is a
-- valid value contained in the STORE_REPS table. The Rep_ID columns of both tables were
-- initially created as different datatypes. Does this cause an error when adding the constraint?
-- Make table modifications as needed so that you can add the required constraint

ALTER TABLE BOOK_STORES
MODIFY (REP_ID NUMBER(5));

ALTER TABLE BOOK_STORES 
ADD (CONSTRAINT BOOK_STORES_FK_REPID FOREIGN KEY (REP_ID) REFERENCES STORE_REPS (REP_ID));


-- The management of JustLee Books has approved implementing a new commission policy and
-- benefits plan for the account managers. The following changes need to be made to the existing
-- database:
-- • Two new columns must be added to the ACCTMANAGER table: one to indicate the
-- commission classification assigned to each employee and another to contain each
-- employee’s benefits code. The commission classification column should be able to store
-- integers up to a maximum value of 99 and be named Comm_id. The value of the Comm_id
-- column should be set to a value of 10 automatically if no value is provided when a row is
-- added. The benefits code column should also accommodate integer values up to a
-- maximum of 99 and be named Ben_id.
-- • A new table, COMMRATE, must be created to store the commission rate schedule and
-- must contain the following columns:
-- ?? Comm_id: A numeric column similar to the one added to the ACCTMANAGER
-- table
-- ?? Comm_rank: A character field that can store a rank name allowing up to 15
-- characters
-- ?? Rate: A numeric field that can store two decimal digits (such as .01 or .03)
-- • A new table, BENEFITS, must be created to store the available benefit plan options and
-- must contain the following columns:
-- ?? Ben_id: A numeric column similar to the one added to the ACCTMANAGER table
-- ?? Ben_plan: A character field that can store a single character value
-- ?? Ben_provider: A numeric field that can store a three-digit integer
-- ?? Active: A character field that can hold a value of Y or N
-- Required: Create the SQL statements to address the changes needed to support the new
-- commission and benefits data.

DROP TABLE COMMRATE CASCADE CONSTRAINTS;
DROP TABLE BENEFITS CASCADE CONSTRAINTS;
ALTER TABLE ACCTMANAGER
ADD (COMM_ID NUMBER(2) DEFAULT 10, BEN_ID NUMBER(2));

ALTER TABLE ACCTMANAGER
ADD (CONSTRAINT COMMID_CHECK CHECK (COMM_ID <= 99), CONSTRAINT BENID_CHECK CHECK (BEN_ID <= 99));

CREATE TABLE COMMRATE (
    COMM_ID NUMBER(2) DEFAULT 10 CONSTRAINT COMMID_CHECK2 CHECK (COMM_ID <= 99),
    COMM_RANK VARCHAR2(15 CHAR),
    RATE NUMBER(5,2)
);

CREATE TABLE BENEFITS (
    BEN_ID NUMBER(2) CONSTRAINT BENID_CHECK2 CHECK (BEN_ID <= 99),
    BEN_PLAN CHAR(1),
    BEN_PROVIDER NUMBER(3),
    ACTIVE CHAR(1) CONSTRAINT ACTIVE_CHECK CHECK (ACTIVE IN ('Y', 'N'))
);    

--Create two tables based on the E-R model shown in Figure 4-41 and the business rules in the
--following list for a work order tracking database. Include all the constraints in the CREATE
--TABLE statements. You should have only two CREATE TABLE statements and no ALTER
--TABLE statements. Name all constraints except NOT NULLs.

--Use your judgment for column datatypes and sizes:
--• Proj# and Wo# are used to uniquely identify rows in these tables.
--• Each project added must be assigned a name, and no duplicate project names are allowed.
--• Each work order must be assigned to a valid project when added, and be assigned a
--description and number of hours.
--• Each work order added must have a different description.
--• The number of hours assigned to a work order should be greater than zero.
--• If data is provided for the Wo_complete column, only Y or N are acceptable values.
--Create and execute the SQL statements needed to enforce the data relationships among these
--tables.

DROP TABLE PROJECT;
DROP TABLE WORKORDERS;

CREATE TABLE PROJECT (
    PROJ# NUMBER(5) CONSTRAINT PROJECT_PK PRIMARY KEY,
    P_NAME VARCHAR2(10 CHAR) CONSTRAINT UNIQUENAME UNIQUE NOT NULL,
    P_DESC VARCHAR2(100 CHAR),
    P_BUDGET NUMBER(6, 2)
);  

CREATE TABLE WORKORDERS (
    WO# NUMBER(5) CONSTRAINT WORKORDERS_PK PRIMARY KEY,
    PROJ# NUMBER(5),
        CONSTRAINT WORKORDERS_FK_PROJ# FOREIGN KEY (PROJ#) REFERENCES
            PROJECT (PROJ#),
    WO_DESC VARCHAR2(100 CHAR) CONSTRAINT UNIQUEDESC UNIQUE NOT NULL,
    WO_ASSIGNED VARCHAR2(10 CHAR),
    WO_HOURS NUMBER(2) NOT NULL CONSTRAINT HOURS_CHECK CHECK (WO_HOURS > 0),
    WO_START DATE,
    WO_DUE DATE,
    WO_COMPLETE CHAR(1) CONSTRAINT COMPLETE_CHECK CHECK (WO_COMPLETE IN ('Y', 'N'))
);    



