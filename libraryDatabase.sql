-- create database new_library;
 
use new_library;

create table  publisher(
     name varchar(20) primary key,
     address varchar(20),
    phone varchar(10));
    
 create table book(
     book_id int primary key,
     title varchar(20),
     pub_year integer,
     publisher_name varchar(20),
     foreign key(publisher_name) references publisher(name) on delete cascade
     );
     
create table book_authors(
     book_id int,
     foreign key(book_id) references book(book_id) on delete cascade,
     author_name varchar(20),
     primary key(book_id)
     );

 create table library_branch(
     branch_id int primary key,
     address varchar(20),
     branch_name varchar(20)
     );
     
 create table book_copies(
     book_id integer,
     foreign key(book_id) references book(book_id) on delete cascade,
     branch_id integer,
     foreign key(branch_id) references library_branch(branch_id) on delete cascade,
     no_of_copies int
     );
     
     
create table book_lending(
      book_id integer,
      foreign key(book_id) references book(book_id) on delete cascade,
     branch_id integer,
     foreign key(branch_id) references library_branch(branch_id) on delete cascade,
     card_no integer,
     date_out date,
     due_date date,
     primary key(book_id,branch_id,card_no));
     
	show tables;
    
desc publisher;

 INSERT INTO PUBLISHER VALUES('PEARSON','BANGALORE','9875462530');
  INSERT INTO PUBLISHER VALUES('MCGRAW','NEWDELHI','7845691234');
   INSERT INTO PUBLISHER VALUES('SAPNA','BANGALORE','7845963210');
   
   select * from publisher;
   
   desc book;
   alter table book drop column pub_year;
   alter table book add column pub_year year;
   
   INSERT INTO BOOK VALUES(1111, 'SE', 'PEARSON', 2005);
INSERT INTO BOOK VALUES(2222, 'DBMS', 'MCGRAW', 2004);
INSERT INTO BOOK VALUES(3333, 'ANOTOMY', 'PEARSON', 2010);
INSERT INTO BOOK VALUES(4444, 'ENCYCLOPEDIA', 'SAPNA', 2010);

desc book_authors;
INSERT INTO BOOK_AUTHORS VALUES(1111, 'SOMMERVILLE');
INSERT INTO BOOK_AUTHORS VALUES(2222, 'NAVATHE');
INSERT INTO BOOK_AUTHORS VALUES(3333, 'HENRY GRAY');
INSERT INTO BOOK_AUTHORS VALUES(4444, 'THOMAS');

   desc book_copies;
   
   INSERT INTO BOOK_COPIES VALUES(1111, 11, 5);
INSERT INTO BOOK_COPIES VALUES(3333, 22, 6);
INSERT INTO BOOK_COPIES VALUES(4444, 33, 10);
INSERT INTO BOOK_COPIES VALUES(2222, 11, 12);
INSERT INTO BOOK_COPIES VALUES(4444, 55, 3);
   
    desc library_branch;
 
INSERT INTO LIBRARY_BRANCH VALUES(11, 'CENTRAL TECHNICAL', 'MG ROAD');
INSERT INTO LIBRARY_BRANCH VALUES(22, 'MEDICAL', 'BH ROAD');
INSERT INTO LIBRARY_BRANCH VALUES(33, 'CHILDREN', 'SS PURAM');
INSERT INTO LIBRARY_BRANCH VALUES(44, 'SECRETARIAT', 'SIRAGATE');
INSERT INTO LIBRARY_BRANCH VALUES(55, 'GENERAL', 'JAYANAGAR');
select * from library_branch;
    
    
    INSERT INTO BOOK_LENDING VALUES(2222, 11, 1, '2017-01-10', '2017-08-20');
INSERT INTO BOOK_LENDING VALUES(3333, 22, 2, '2017-07-09', '2017-08-12');
INSERT INTO BOOK_LENDING VALUES(4444, 55, 1, '2017-04-11', '2017-08-09');
INSERT INTO BOOK_LENDING VALUES(2222, 11, 5, '2017-08-09', '2017-08-19');
INSERT INTO BOOK_LENDING VALUES(4444, 33, 1, '2017-07-10', '2017-08-15');
INSERT INTO BOOK_LENDING VALUES(1111, 11, 1, '2017-05-12', '2017-06-10');
INSERT INTO BOOK_LENDING VALUES(3333, 22, 1, '2017-07-10', '2017-07-15');

-- --1. Retrieve details of all books in the library – id, title, name of publisher, authors, number of
-- copies in each Programme, etc: - 

SELECT LB.BRANCH_NAME, B.BOOK_ID,TITLE, PUBLISHER_NAME,AUTHOR_NAME, NO_OF_COPIES
     FROM BOOK B, BOOK_AUTHORS BA, BOOK_COPIES BC, LIBRARY_BRANCH LB
     WHERE B.BOOK_ID = BA.BOOK_ID AND BA.BOOK_ID = BC.BOOK_ID AND BC.BRANCH_ID = LB.BRANCH_ID
    GROUP BY LB.BRANCH_NAME, B.BOOK_ID, TITLE, PUBLISHER_NAME, AUTHOR_NAME, NO_OF_COPIES;
    
  --   2. Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to
-- Jun 2017: -

	select card_no from book_lending
    where date_out between '2017-01-01' and '2017-06-30' group by card_no having count(*) >3;
    
    
 --    Delete a book in the BOOK table. Update the contents of other tablesto reflect this data
-- manipulation operation:-

delete from book where book_id=3333;


select * from book_copies;
select * from book_lending;
select * from library_branch;

-- Partition the BOOK table based on the year of publication. Demonstrate its working with a
-- simple query: -

SELECT BOOK_ID, TITLE, PUBLISHER_NAME, PUB_YEAR
FROM BOOK
GROUP BY PUB_YEAR, BOOK_ID, TITLE, PUBLISHER_NAME;
     --(or) 
SELECT * FROM BOOK WHERE Pub_Year = 2005;


-- . Create a view of all books and their number of copies that are currently available in the Library: -

create view books_available as
select b.book_id,b.title,bc.no_of_copies from book b,book_copies bc where b.book_id=bc.book_id;

select * from books_available;
