USE ROLE sysadmin;
USE WAREHOUSE compute_wh;

-- Creating Database

CREATE DATABASE library_db COMMENT = 'Library Database';
USE DATABASE library_db;
USE SCHEMA public;

-- Creating table Author

CREATE or REPLACE table AUTHOR(
AUTHOR_ID Number,
first_name VARchar(50),
middle_name varchar(50),
last_name Varchar(50)
);

-- Manually inserting data

INSERT INTO AUTHOR(AUTHOR_ID,FIRST_NAME,MIDDLE_NAME, LAST_NAME) 
Values
(1, 'Fiona', '','Macdonald')
,(2, 'Gian','Paulo','Faleschini');

-- Creating sequence

CREATE OR REPLACE SEQUENCE seq_author_id 
START 3 
INCREMENT 1 
COMMENT = 'Use this to fill in the AUTHOR_ID every time you add a row';

-- Manually inserting data using sequence.nextval

INSERT INTO AUTHOR(AUTHOR_ID,FIRST_NAME,MIDDLE_NAME, LAST_NAME) 
Values
(SEQ_AUTHOR_ID.nextval, 'Laura', 'K','Egendorf')
,(SEQ_AUTHOR_ID.nextval, 'Jan', '','Grover')
,(SEQ_AUTHOR_ID.nextval, 'Jennifer', '','Clapp')
,(SEQ_AUTHOR_ID.nextval, 'Kathleen', '','Petelinsek');

-- Creating sequence for table book

CREATE OR REPLACE SEQUENCE SEQ_BOOK_ID
START 1
INCREMENT 1
COMMENT = 'Use this sequence to fill BOOK_ID';

-- Creating table with automated sequence as default

CREATE OR REPLACE TABLE BOOK (
BOOK_UID NUMBER DEFAULT SEQ_BOOK_UID.nextval,
TITLE VARCHAR(50),
YEAR_PUBLISHED NUMBER(4,0)
);

INSERT INTO BOOK(TITLE,YEAR_PUBLISHED)
VALUES
 ('Food',2001)
,('Food',2006)
,('Food',2008)
,('Food',2016)
,('Food',2015);

-- Creating relationship table (MANY TO MANY)
CREATE TABLE BOOK_TO_AUTHOR
(  BOOK_UID NUMBER
  ,AUTHOR_UID NUMBER
);

INSERT INTO BOOK_TO_AUTHOR(BOOK_UID,AUTHOR_UID)
VALUES
 (1,1)  // This row links the 2001 book to Fiona Macdonald
,(1,2)  // This row links the 2001 book to Gian Paulo Faleschini
,(2,3)  // Links 2006 book to Laura K Egendorf
,(3,4)  // Links 2008 book to Jan Grover
,(4,5)  // Links 2016 book to Jennifer Clapp
,(5,6); // Links 2015 book to Kathleen Petelinsek

-- Selecting all the data
SELECT * 
    FROM book_to_author ba
    JOIN author a ON ba.author_id = a.author_id
    JOIN book b on ba.book_id = b.book_id;
