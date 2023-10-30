--1) Database setup

CREATE DATABASE "Student_Database"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
create table Student_table
(Student_id int, Stu_name varchar(100),  Department varchar(50), email_id varchar(50), 
Phone_no numeric, Address varchar(250),  Date_Of_Birth DATE, Gender Varchar(30),  
Major Varchar(50), GPA numeric, Grade varchar(10));

--2) Data entry
Insert Into Student_table
(Student_id, Stu_name, Department, email_id, Phone_no, Address,  Date_Of_Birth, Gender, Major, 
GPA, Grade) Values
('1', 'Pravalika Gourishetty', 'Business', 'PravalikaG@gmail.com', '9999999991',  'Delhi', '1999-04-26', 'Female', 'MBA', '8.8', 'A'), 
 ('2', 'Krishna Kumar', 'Arts and Sciences', 'krishnakumar@gmail.com',  '9999999992', 'Bangalore', '1992-07-15', 'Male', 'Mathematics', '8.6', 'A'), 
 ('3', 'Ravi Nema', 'Business', 'Ravinema@gmail.com', '9999999993',  'Delhi', '1995-06-28', 'Male', 'MBA', '8.5', 'A'), 
 ('4', 'Deepa Navya', 'Arts and Sciences', 'Deepanavya@gmail.com',  '9999999994', 'Dehradhun', '1997-01-12', 'Male', 'Physics', '7.6', 'B'),  
 ('5', 'Katrina', 'Arts and communication', 'Katrina@gmail.com', '9999999995', 'Mumbai', '1995-10-26', 'Female', 'Communication', '6.9', 'B'), 
 ('6', 'Santosh', 'Arts and Sciences', 'Santosh@gmail.com',  '9999999996', 'Goa', '2000-01-03', 'Female', 'Computer Science', '5.5', 'C'),  
 ('7', 'Hima', 'Human Development', 'Hima@gmail.com', '9999999997', 'Uttar Pradesh', '2000-10-05', 'Male', 'Counseling', '7.0', 'B'),  
 ('8', 'Pranavi Yadav', 'Arts and communication', 'Pranavi@gmail.com', '9999999998', 'Gujarat', '1999-11-16', 'Male', 'Theatre', '9.2', 'A'), 
 ('9', 'Sampath', 'Business', 'Sampath@gmail.com', '9999999999', 'Rajasthan', '2003-08-14', 'Male', 'Accounting', '7.9', 'B'), 
 ('10', 'Sandhya', 'Arts and Sciences', 'Sandhya@gmail.com',  '9999999911', 'Mumbai', '1997-03-12', 'Female', 'Physics', '4.9', 'C');
 
Select * from Student_table;

--3) Student information retrieval 

 Select * from Student_table 
 Order By GPA desc, Grade;
 
 --4) Male students
 Select * from Student_table 
 where Gender = 'Male';

--5) GPA less than 5
 Select * from Student_table 
 where GPA <5.0;
 
 --6) Update email_id and Grade 
UPDATE Student_table
SET email_id = 'Sarada@gmail.com', Grade = 'D'
Where Student_id = '9';

--7) Grade B
SELECT Stu_name, date_part('year',age(Date_Of_Birth)) as Age
FROM Student_table
Where Grade = 'B';

--8) Grouping and calculation 
Select Department, Gender, Avg(GPA)
From Student_table
Group By 1,2;

--9) Renaming
Alter table Student_table
Rename to Student_info;

Select * from Student_info;

--10) Students with highest GPA
Select Stu_name, GPA
From Student_info where GPA = (Select Max(GPA) From Student_info);



