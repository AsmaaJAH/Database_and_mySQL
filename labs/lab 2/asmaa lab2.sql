-- ------------------------------------------------------------
-- implementation of the Library schema using DDL statements.
-- ------------------------------------------------------------------------

create schema Library;
use Library;
Create Table Publisher (
publisher_name Varchar(50) not null,
address Varchar (100),
phone int(13),
Primary Key (publisher_name)
);
create table Book(
book_id varchar(5) primary key not null,
title varchar(100) not null,
publisher_name varchar(50),
constraint fk foreign key(publisher_name) references Publisher(publisher_name) ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table BookAuthors (
book_id varchar(5) not null,
auther_name Varchar(50) not null,
Primary Key(book_id, auther_name),
Constraint BookAuthorsFK Foreign Key (book_id) references Book (book_id) ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table LibraryBranch(
branch_name Varchar (50) not null,
branch_id varchar(5) Primary Key not null ,
address varchar (100) not null
);

Create Table BookCopies (
book_id varchar(5) not null,
branch_id varchar(5) not null,
no_of_copies int(6) default 0,
Primary Key (book_id, branch_id),
Constraint bookFK Foreign key card_no (book_id) references Book (book_id) ON DELETE CASCADE ON UPDATE RESTRICT,
Constraint branchFK Foreign Key (branch_id) references LibraryBranch (branch_id)ON DELETE CASCADE ON UPDATE CASCADE
);

Create Table Borrower (
borrower_name varchar(50) not null,
address varchar(100),
phone varchar(12),
card_no varchar(5) primary key not null
);

Create Table BookLoans (
book_id varchar(5) not null,
branch_id varchar(5) not null,
card_no varchar(5) not null,
date_out date not null,
due_date date not null,
primary key (book_id, branch_id, card_no),
Constraint LoansBookFK Foreign Key (book_id) references Book(book_id) ON DELETE CASCADE ON UPDATE RESTRICT,
Constraint LoansBranchFK Foreign Key (branch_id) references LibraryBranch(branch_id) ON DELETE CASCADE ON UPDATE RESTRICT,
Constraint cardFK Foreign Key (card_no) references Borrower(card_no) ON DELETE RESTRICT ON UPDATE RESTRICT
);


-- ---------------------------------------------------------------------------
-- a try of the INSERT, UPDATE and DELETE statements on the Publisher table.
-- ---------------------------------------------------------------------------
-- -------insert-------:
insert into Publisher values
('ASMAA GAMAL', '21 the sea Street-Agami', '01124542122');

insert into Publisher values
('ABO OBIEDA', '23 Sea Street Palastine','01015010473');

insert into Publisher values
('Occupaied Palastine', 'South West of Palastine','01000000000');

-- -------update-------:
UPDATE Publisher
SET publisher_name = 'ASMAA GAMAL NAGY'
WHERE publisher_name = 'ASMAA GAMAL';
-- -------delete-------:
DELETE FROM Publisher
WHERE publisher_name = 'Occupaied Palastine';

-- ---------------------------------------------------------------------------
-- Insert a row in the Book table that references a row in the Publisher table.
-- ---------------------------------------------------------------------------
-- -------insert-------:
insert into Book values('1A111', 'History of palastine', 'ABO OBIEDA');
-- -------update-------:
UPDATE Publisher
SET publisher_name = 'ABO OBIEDA##'
WHERE publisher_name = 'ABO OBIEDA';
-- -------delete-------:
DELETE FROM Publisher
WHERE publisher_name = 'ABO OBIEDA##';

-- -------------------------------------------------------------------
-- Inserting some random data into the library DB
-- -------------------------------------------------------------------
insert into Borrower values 
('Asmaa','12 St. Saad Zaghloul','01047332254','12345'),
('Gamal','26 St.Zaki Ragab Rogdi','01001701988','12346'),
('Abdel-Halem','33 St. Mohamed Ali','0113377521','12347'),
('Nagy','50 St. Salah EL-Din','01001234671','12348');

insert into LibraryBranch values 
('Sharpstown','15342',  '11 Downing Street'),
('Central','91234',  '45 Hude Park, NYC');

insert into Publisher values
('Pearson', 'Palastine', 35778912);

insert into Book values 
('10921', 'The Lost Tribe', 'Pearson'),
('36243', 'Tail of Two Cities', 'Pearson'),
('34444', 'Oliver Twist', 'Pearson');

insert into BookAuthors values 
('10921', 'Naguib Mahfouz'),
('10921', 'Stephen King'),
('36243', 'Taha Hussein'),
('34444', 'Stephen King'),
('34444', 'Charles Dickens');

insert into BookCopies values 
('10921', '15342', 6),
('10921', '91234', 10),
('36243', '15342', 5),
('34444', '91234', 12);

insert into BookLoans values 
('10921','15342','12345',date'2023-01-01',date'2023-01-08'),
('36243','15342', '12348',date'2023-11-20',date'2023-11-28'),
('34444','91234','12347',date'2023-10-01',date'2023-10-13'),
('34444','15342','12347', date'2023-10-01',date'2023-10-17'),
('10921','91234','12347',date'2023-10-02',date'2023-10-16'),
('36243','15342','12347',date'2023-10-03',date'2023-10-15'),
('36243','91234','12347',date'2023-10-04', date'2023-10-14'),
('10921','15342','12347',date'2023-10-05',date'2023-10-13');


-- ----------------------------------------------------------------
-- ----answering the question after creating the dummy database---- 
-- ----------------------------------------------------------------
-- a):
SELECT no_of_copies
FROM (Book NATURAL JOIN BookCopies) NATURAL JOIN LibraryBranch
WHERE title = 'The Lost Tribe' AND branch_name = 'Sharpstown'; 

-- b):
SELECT branch_name, no_of_copies
FROM (Book NATURAL JOIN BookCopies) NATURAL JOIN LibraryBranch
WHERE title = 'The Lost Tribe';

-- c):
SELECT borrower_name 
FROM Borrower AS Bname
WHERE NOT EXISTS (SELECT * 
FROM BookLoans AS Loans
WHERE Bname.card_no = Loans.card_no);

-- d):
SELECT title, borrower_name, Borrower.address
FROM ((Book NATURAL JOIN BookLoans) NATURAL JOIN LibraryBranch)
JOIN Borrower ON BookLoans.Card_no = Borrower.Card_no
WHERE Branch_name = 'Sharpstown' AND Due_date = '2023-11-28';

-- e):
Select branch_name, branch_id, count(*) as total_loaned_books
from LibraryBranch natural join BookLoans
group by branch_id;

-- f):
select borrower_name, address, count(*) as total_Checked_out_books
from Borrower natural join BookLoans
group by Card_no
having count(*) > 5;


-- g):
select title, no_of_copies
from Book  natural join BookCopies
where exists ( select *
from BookAuthors
where Book.book_id = book_id and auther_name = 'Stephen King')
and exists (select *
from LibraryBranch
where BookCopies.branch_id = branch_id and branch_name =
'Central');