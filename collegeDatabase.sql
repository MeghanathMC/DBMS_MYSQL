USE COLLEGE_DATABASE;

CREATE TABLE STUDENT(
USN VARCHAR(10) PRIMARY KEY,
SNAME VARCHAR(25),
ADDRESS VARCHAR(25),
PHONE BIGINT,
GENDER CHAR(1));

CREATE TABLE SEMSEC(
SSID VARCHAR(5) PRIMARY KEY,
SEM INT,
SEC CHAR(1));

CREATE TABLE CLASS(
USN VARCHAR(10),
SSID VARCHAR(5),
PRIMARY KEY(USN,SSID),
FOREIGN KEY(USN) REFERENCES STUDENT(USN),
FOREIGN KEY(SSID) REFERENCES SEMSEC(SSID)
);
CREATE TABLE SUBJECT(
SUBCODE VARCHAR(10),
TITLE VARCHAR(100),
SEM INT,
CREDITS INT,
PRIMARY KEY(SUBCODE)
);

CREATE TABLE IAMARKS(
USN VARCHAR(10),
SUBCODE VARCHAR(10),
SSID VARCHAR(5),
TEST1 INT,
TEST2 INT,
TEST3 INT,
PRIMARY KEY(USN,SUBCODE,SSID),
FOREIGN KEY(USN) REFERENCES STUDENT(USN),
FOREIGN KEY(SUBCODE) REFERENCES SUBJECT(SUBCODE),
FOREIGN KEY(SSID) REFERENCES SEMSEC(SSID)
);
SHOW TABLES;
DESC STUDENT;

INSERT INTO STUDENT VALUES ('1OX21CS001', 'Sahana R', 'Bangalore', 9123456780, 'F');
INSERT INTO STUDENT VALUES ('1OX21CS002', 'Sabah', 'Palya', 9234567891, 'F');
INSERT INTO STUDENT VALUES ('1OX21CS003', 'Roja', 'Shimoga', 9345678902, 'F');
INSERT INTO STUDENT VALUES ('1OX21CS004', 'Shanthini', 'Bangalore', 9567890124, 'F');
INSERT INTO STUDENT VALUES ('1OX21CS005', 'Roopa', 'Bangalore', 9678901235, 'F');
INSERT INTO STUDENT VALUES ('1OX21CS006', 'Vidhan', 'Rajasthan', 9789012346, 'M');
INSERT INTO STUDENT VALUES ('1OX21CS007', 'Pranav', 'Karnataka', 9890123457, 'M');
INSERT INTO STUDENT VALUES ('1OX21CS008', 'Trupthi', 'Bangalore', 9901234568, 'F');
INSERT INTO STUDENT VALUES ('1BI15CS101', 'Sarveshwar', 'Kudlu', 9988776655, 'M');


SELECT * FROM STUDENT;

INSERT INTO SEMSEC VALUES ('CSE4C', 4, 'C');
INSERT INTO SEMSEC VALUES ('CSE8A', 8, 'A');
INSERT INTO SEMSEC VALUES ('CSE8B', 8, 'B');
INSERT INTO SEMSEC VALUES ('CSE8C', 8, 'C');

INSERT INTO CLASS VALUES ('1BI15CS101', 'CSE8A');
INSERT INTO CLASS VALUES ('1OX21CS001', 'CSE4C');
INSERT INTO CLASS VALUES ('1OX21CS002', 'CSE8B');
INSERT INTO CLASS VALUES ('1OX21CS003', 'CSE4C');
INSERT INTO CLASS VALUES ('1OX21CS004', 'CSE8C');
INSERT INTO CLASS VALUES ('1OX21CS005', 'CSE8B');
INSERT INTO CLASS VALUES ('1OX21CS006', 'CSE8C');
INSERT INTO CLASS VALUES ('1OX21CS007', 'CSE8A');
INSERT INTO CLASS VALUES ('1OX21CS008', 'CSE8B');
 
 INSERT INTO SUBJECT VALUES ('21CS54', 'AIML', 8, 4);
INSERT INTO SUBJECT VALUES ('21CSL55', 'DBMS', 4, 4);
 
 
 
 SELECT * FROM IAMARKS;
 DESC IAMARKS;
 ALTER TABLE IAMARKS ADD COLUMN FINALIA INT;
INSERT INTO IAMARKS VALUES ('1BI15CS101', '21CSL55', 'CSE8A', 18, 16, 14, 0);
INSERT INTO IAMARKS VALUES ('1OX21CS001', '21CS54', 'CSE4C', 13, 14, 12, 0);
INSERT INTO IAMARKS VALUES ('1OX21CS002', '21CS54', 'CSE8B', 18, 18, 14, 0);
INSERT INTO IAMARKS VALUES ('1OX21CS005', '21CSL55', 'CSE8C', 14, 15, 13, 0);
INSERT INTO IAMARKS VALUES ('1OX21CS008', '21CSL55', 'CSE8C', 13, 17, 15, 0);

select * from student;
select s.*,ss.ssid,ss.sem,ss.sec from student s join class c on s.usn=c.usn
join semsec ss on ss.ssid=c.ssid where sem=4 and sec='c'; 

select ss.sem,ss.sec,s.gender ,count(*) as count 
from student s
join class c on c.usn=s.usn 
join semsec ss on ss.ssid=c.ssid
group by s.gender,ss.sem,ss.sec;


create view view_test1 as
select ia.usn,ia.subcode,sub.title from iamarks ia 
join subject sub on sub.subcode=ia.subcode
where ia.usn='1BI15CS101';
SELECT * FROM VIEW_TEST1;


SELECT * FROM IAMARKS;

UPDATE IAMARKS SET FINALIA =(TEST1+TEST2+TEST3-LEAST(TEST1,TEST2,TEST3))/2;

SELECT * FROM IAMARKS;


SELECT S.USN,S.SNAME,SS.SEM,SS.SEC,
CASE
WHEN IA.FINALIA BETWEEN 17 AND 20 THEN 'OUTSTANDING'
WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE'
WHEN IA.FINALIA < 12 THEN 'WEAK'
END AS CATEGORY
FROM STUDENT S
JOIN IAMARKS IA ON IA.USN=S.USN
JOIN SEMSEC SS ON SS.SSID=IA.SSID 
WHERE  SS.SEM=8 AND SS.SEC IN('A','B','C');
