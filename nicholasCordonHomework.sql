-- SQL Lab Nicholas Cordon

-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.
-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
-- 2.1 SELECT
-- Task – Select all records from the Employee table.
    SELECT * FROM employee
-- Task – Select all records from the Employee table where last name is King.
    SELECT * FROM employee WHERE lastname = 'King'
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
    SELECT * FROM employee WHERE firstname = 'Andrew' AND reportsto IS null
-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
    SELECT * FROM album ORDER BY title DESC
-- Task – Select first name from Customer and sort result set in ascending order by city
    SELECT firstname FROM Customer ORDER BY city ASC
-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
    INSERT INTO Genre (genreid, name)
    Values (27,'Wubstep'), (28, 'Folk Metal');
-- Task – Insert two new records into Employee table
    INSERT INTO employee (employeeid, lastname, firstname)
Values (10,'Brown', 'Anthony'), (11, 'Castilio', 'Andrew')
-- Task – Insert two new records into Customer table
INSERT INTO customer (customerid, firstname, lastname, email)
VALUES (60, 'Nick', 'Cordon', 'email@emailing.com'), 
(61, 'Jackie', 'Chan', 'super@emailing.com');
-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
UPDATE Customer
SET firstname = 'Robert ', lastname = 'Walter'
WHERE customerid = 32;
-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
UPDATE Artist
SET name = 'CCR'
WHERE artistid = 76;
-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”
Select * From invoice where billingaddress like 'T%'
-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
Select * From invoice where total between 15 and 50
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
SELECT * FROM employee Where hiredate between timestamp '2003-1-1' and timestamp '2004-3-1'
-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).

set schema 'chinook';

Alter Table invoice
	drop constraint fk_invoicecustomerid;

Alter Table invoice
	ADD constraint fk_customer_id
	foreign key (customerid) References chinook.customer (customerid) on delete cascade;

Alter Table invoiceline 
	drop constraint fk_invoicelineinvoiceid;

Alter Table invoiceline 
	ADD constraint fk_invoiceline_id
	foreign key (invoiceid) References chinook.invoice (invoiceid) on delete cascade;

	Delete From customer 
	where firstname = 'Robert' and lastname = 'Walter';
-- 3.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions
-- Task – Use a function that returns the current time.
SELECT NOW();
-- Task – Use a function that returns the length of a mediatype from the mediatype table
SELECT mediatype.name, LENGTH(mediatype.name) AS lengthofmediatype
FROM mediatype;
-- 3.2 System Defined Aggregate Functions
-- Task – Use a function that returns the average total of all invoices
SELECT AVG(invoice.total)
FROM invoice
-- Task – Use a function that returns the most expensive track
select * from track where unitprice in(
SELECT MAX(unitprice) AS LargestPrice
FROM track)
-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
Select customer.customerid, invoice.invoiceid
FROM invoice INNER JOIN customer ON customer.customerid = invoice.invoiceid;
-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
Select customer.customerid, customer.firstname, customer.lastname,
invoice.invoiceid, invoice.total
FROM invoice full Outer JOIN customer ON customer.customerid = invoice.invoiceid;
-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.

select artist.name, album.title
from artist right join album on artist.name = album.title;
-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
SELECT * FROM artist
CROSS JOIN album Order By artist.name ASC;

-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.
Select * from employee as worker
inner join employee as leader on worker.employeeid = leader.reportsto