use company;


create table employee(
ssn char(9) primary key,
name varchar(20),
address varchar(255),
sex char(1),
salary decimal(10,2),
superssn char(9) references employee(ssn),
dno int references department(dno)
);

select * from employee;
desc employee;


create table department(
dno int primary key,
dname varchar(50),
mgrssn char(9) references employee(ssn),
mgrstartdate date
);
select * from department;

create table dlocation(
dno int references department(dno),
dloc varchar(50)
);

create table project(
pno int primary key,
pname varchar(50),
plocation varchar(50),
dno int references department(dno)
);

create table works_on(
ssn char(9) references employee(ssn),
pno int references project(pno),
hours decimal(10,2),
primary key(ssn,pno)
);


INSERT INTO EMPLOYEE VALUES ('101', 'Rahul Scott', 'Bangalore', 'M', 700000, NULL, 1);
INSERT INTO EMPLOYEE VALUES ('102', 'Sahana', 'Mysore', 'F', 2650000, '101', 5);
INSERT INTO EMPLOYEE VALUES ('103', 'Sarveshwar', 'Hubli', 'M', 2610000, '101', 5);
INSERT INTO EMPLOYEE VALUES ('104', 'Roopa', 'Belgaum', 'F', 610000, '101', 5);
INSERT INTO EMPLOYEE VALUES ('105', 'Sabah', 'Dharwad', 'F', 2620000, '101', 5);
INSERT INTO EMPLOYEE VALUES ('106', 'Ritik B', 'Bangalore', 'M', 630000, '102', 5);
INSERT INTO EMPLOYEE VALUES ('107', 'Manoj A', 'Mangalore', 'M', 640000, '103', 5);
INSERT INTO EMPLOYEE VALUES ('108', 'Roja', 'Mysore', 'F', 2600000, '104', 3);
INSERT INTO EMPLOYEE VALUES ('109', 'Saheb', 'Mysore', 'M', 600000, '103', 5);


INSERT INTO DEPARTMENT VALUES (1, 'IT', '101', '2020-01-10');
INSERT INTO DEPARTMENT VALUES (3, 'HR', '104', '2022-02-01');
INSERT INTO DEPARTMENT VALUES (5, 'Accounts', '102', '2021-05-15');


INSERT INTO DLOCATION VALUES (1, 'Bangalore');
INSERT INTO DLOCATION VALUES (2, 'Mysore');
INSERT INTO DLOCATION VALUES (3, 'Mangalore');
INSERT INTO DLOCATION VALUES (5, 'Bangalore');


INSERT INTO PROJECT VALUES (201, 'IoT', 'Bangalore', 1);
INSERT INTO PROJECT VALUES (204, 'AWS', 'Bangalore', 1);
INSERT INTO PROJECT VALUES (202, 'FinTech', 'Mysore', 2);
INSERT INTO PROJECT VALUES (203, 'AI', 'Bangalore', 5);


INSERT INTO WORKS_ON VALUES ('101', 201, 40);
INSERT INTO WORKS_ON VALUES ('101', 204, 35);
INSERT INTO WORKS_ON VALUES ('103', 203, 30);
INSERT INTO WORKS_ON VALUES ('108', 201, 20);
INSERT INTO WORKS_ON VALUES ('102', 203, 40);
INSERT INTO WORKS_ON VALUES ('105', 203, 35);

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM DLOCATION;
SELECT * FROM PROJECT;
SELECT * FROM WORKS_ON;


-- list of all projects that scoot worked on as employee or manager 
select distinct p.pno
from project p
join works_on w on p.pno=w.pno join employee e on e.ssn=w.ssn or p.dno=e.dno
where e.name like '%scott%';

select e.name,e.salary *1.10 as new_salary from employee e
join works_on w on e.ssn=w.ssn 
join project p on p.pno=w.pno
where p.pname='iot';

select sum(e.salary),max(e.salary),
min(e.salary),avg(e.salary) from employee e 
join department d on e.dno=d.dno 
where d.dname='Accounts';



select e.name from employee e
where not exists (
select p.pno from project p where p.dno=5 and p.pno not in(
select w.pno from works_on w where e.ssn=w.ssn)
);


select e.dno,count(*) as no_emp_earning_over6L
from employee e
where e.salary >600000
group by e.dno
having count(*) >5;


