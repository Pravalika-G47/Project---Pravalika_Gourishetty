
--1. Database Creation:
create database student_database;
use student_database;

--a)	Creating table StudentInfo:
Create table StudentInfo (
STU_ID int, 
STU_NAME varchar(100),
DOB DATE,
PHONE_NO VARCHAR(10),
EMAIL_ID varchar(50),
ADDRESS varchar(250),
primary key (STU_ID));


--b)	creating table CourseInfo:
Create table CourseInfo(
COURSE_ID INT ,
COURSE_NAME VARCHAR(100),
COURSE_INSTRUCTOR_NAME VARCHAR(100), 
primary key (COURSE_ID));


--c)	creating table EnrollmentInfo:
Create table EnrollmentInfo(
ENROLLMENT_ID INT, 
STU_ID int, 
COURSE_ID INT, 
ENROLL_STATUS varchar(20),
primary key (ENROLLMENT_ID), 
FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
FOREIGN KEY (COURSE_ID) REFERENCES CourseInfo(COURSE_ID));

--2) Data Creation
Insert Into StudentInfo
(STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID ,ADDRESS) Values
('101', 'Virat', '1991-02-13',9898989898, 'Virat123@gamil.com', 'Banglore'),
('102', 'Dhoni', '1984-08-04',9999999995, 'Dhoni201@gamil.com', 'Banglore'),
('103', 'Bhuvi', '1994-08-15',9999999976, 'Bhuvi301@gamil.com', 'Chennai'),
('104', 'Robin', '1994-01-23',9999999669, 'Robin401@gamil.com', 'Mumbai'),
('105', 'John Austin', '1993-06-24',9999993456, 'John501@gamil.com', 'Hyderabad'),
('106', 'Daniel', '1992-07-27',9999997654, 'Dan601@gamil.com', 'Hyderabad');

Insert Into CourseInfo(COURSE_ID,COURSE_NAME, COURSE_INSTRUCTOR_NAME) values
(001, 'SQL','Sofy'),
(002, 'Python','Arvind'),
(003, 'AWS','Seema'),
(004, 'JAVA','Harry'),
(005, 'CSS','Jacky');


insert into EnrollmentInfo(ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS) values 
(10001, 101, 001,'ENROLLED'),
(10002, 103, 002,'ENROLLED'),
(10003, 104, 004,'ENROLLED'),
(10004, 102, 003,'ENROLLED'),
(10005, 105, 003,'NOT ENROLLED'),
(10006, 106, 005,'ENROLLED');


--3) Retrieve the Student Information 

--a) Write a query to retrieve Student details, Such as Student Name, Contact Informations and Enrollment Status  

Select s.STU_NAME, s.PHONE_NO, s.ADDRESS,
e.ENROLL_STATUS 
from StudentInfo s join EnrollmentInfo e
on s.STU_ID=e.STU_ID 
order by e.ENROLL_STATUS ;

--b) Write a query to retrieve a list of courses in which a specific student enrolled

select c.COURSE_NAME, s.STU_NAME
from EnrollmentInfo e
join CourseInfo c on e.course_id = c.course_id
join StudentInfo s on s.STU_ID = e.STU_ID;

--C) Write a query to retrieve course information, including course name, instructor information

 Select * From CourseInfo;
 
 --d) Write a query to retrieve course information for a specific course

     Select COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME
      from CourseInfo
      where COURSE_NAME='SQL';

--e) Write a query to retrieve course information for multiple courses

    Select COURSE_ID, 
                COURSE_NAME, 
  COURSE_INSTRUCTOR_NAME
    from CourseInfo
    where COURSE_NAME in ('SQL','Python');

--f) Test the queries to ensure accurate retrieval of Student Information
--(Execute queries and verify the results against the expected output)

Select * From StudentInfo;

--4) Reporting and Analytics (Using joining queries)

--a) Write a query to retrieve the number of students enrolled in each course

Select c.Course_Name , 
count(c.course_id) as numberofStudents
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1;

--b) Write a query to retrieve the list of students enrolled in a specific course

select e.COURSE_ID, 
c.COURSE_NAME, 
s.STU_NAME
from CourseInfo c join EnrollmentInfo e on c.course_id=e.course_ID 
join StudentInfo s on s.STU_ID = e.STU_ID where e.enroll_status = 'ENROLLED';

--c) Write a query to retrieve the count of enrolled students for each instructor

Select c.COURSE_INSTRUCTOR_NAME , count(e.Stu_id) as numberofStudents
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1;

--d) Write a query to retrieve the list of students who are enrolled in a multiple course

Select e.stu_id , count(c.course_id) as numberofStud
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1
having count(c.course_id) >1

--e)  Write a query to retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)

Select e.stu_id , count(c.course_id) as numberofStud
from CourseInfo c join EnrollmentInfo e
on c.course_id=e.course_ID
where e.enroll_status = 'ENROLLED'
group by 1
having count(c.course_id) >1
order by count(c.course_id) desc
