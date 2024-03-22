# DBMS_MYSQL

#LAB PROGRAMS
#DBMS IMPORTANT MANAGEMENT SYTEMS

. Library Database Management
Aim: Demonstrating the creation of tables and applying the view concepts on the tables.
Program: Consider the following schema for a Library Database:
• BOOK(Book_id, Title, Publisher_Name, Pub_Year)
• BOOK_AUTHORS(Book_id, Author_Name)
• PUBLISHER(Name, Address, Phone)
• BOOK_COPIES(Book_id, Programme_id, No-of_Copies)
• BOOK_LENDING(Book_id, Programme_id, Card_No, Date_Out, Due_Date)
• LIBRARY_PROGRAMME(Programme_id, Programme_Name, Address)
Write SQL queries to:
1. Retrieve details of all books in the library – id, title, name of publisher, authors, number of copies
in each Programme, etc.
2. Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun
2017.
3. Delete a book in the BOOK table. Update the contents of other tables to reflect this data
manipulation operation.
4. Partition the BOOK table based on the year of publication. Demonstrate its working with a simple
query.
5. Create a view of all books and their number of copies that are currently available in the Library.



. Database Operationsin an Order
Aim: Discussthe various concepts on constraints and update operations.
Program: Consider the following schema for an Order Database:
• SALESMAN(Salesman_id, Name, City, Commission)
• CUSTOMER(Customer_id, Cust_Name, City, Grade, Salesman_id)
• ORDERS(Ord_No, Purchase_Amt, Ord_Date, Customer_id, Salesman_id)
Write SQL queries to:
1. Count the customers with grades above Bangalore’s average.
2. Find the name and numbers of allsalesmen who had more than one customer.
3. List all the salesmen and indicate those who have and don't have customers in their cities (Use
UNION operation).
4. Create a view that finds the salesman who hasthe customer with the highest order of a day.
5. Demonstrate the DELETE operation by removing the salesman with id 1000. All his orders must
also be deleted.





Write SQL queries to:
1. List the titles of all movies directed by ‘Hitchcock’.
2. Find the movie names where one or more actors acted in two or more movies.
3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN
operation).
4. Find the title of movies and number ofstars for each movie that has at least one rating and
find the highest number of stars that movie received. Sort the result by movie title.
5. Update the rating of allmovies directed by ‘Steven Spielberg’ to 5.



. Make a list of all project numbers for projectsthat involve an employee whose last name is
‘Scott’, either as a worker or as a manager of the department that controls the project.
2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10
percent raise.
3. Find the sum of the salaries of all employees of the ‘Accounts’ department, as well as the
maximum salary, the minimum salary, and the average salary in this department.
4. Retrieve the name of each employee who works on all the projects controlled by department
number 5 (use NOT EXISTS operator).
5. For each department that has more than five employees, retrieve the department number
and the number of its employees who are making more than Rs.6,00,000.
T


