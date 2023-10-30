-- Database: EventsManagement
-- DROP DATABASE IF EXISTS "EventsManagement";

CREATE DATABASE "EventsManagement"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
--1)  Database Creation 
Create table Events (
Event_Id Int, 
Event_Name Varchar(30),
 Event_Date Date, 
Event_Location Varchar(100), 
Event_Description Varchar(200), 
primary key (Event_Id));

Create table Attendees (
Attendee_Id Int, 
Attendee_Name Varchar(30), 
Attendee_Phone numeric, 
Attendee_Email Varchar(30), 
Attendee_City Varchar(20), 
primary key (Attendee_Id));

Create table Registrations (
Registration_Id Int, 
Event_Id Int, 
Attendee_Id Int, 
Registration_Date Date, 
Registration_Amount numeric, 
primary key (Registration_Id), 
FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id));

--2) Data Creation 
Insert into Events 
(Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) values 
('101', 'Taylor swift', '2024-01-08', 'Mumbai', 'Music Show'), 
('102', 'Comicon', '2023-11-23', 'Bangalore', 'Exhibition'),
('103', 'IIMF', '2023-11-12', 'Hyderabad', 'Music Show'),
('104', 'Hitcki', '2024-03-06', 'Kochi', 'Comedy'),
('105', 'Ted Talk', '2024-02-23', 'Kolkata', 'Comedy')
;
Select * from Events;

Insert into Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) values 
('1001', 'Pravalika', '9999999991', 'Pravalika@gmail.com', 'Hyderabad'),
('1002', 'Raj kumar', '9999999992', 'Raj@gmail.com', 'Delhi'),
('1003', 'Abhiram', '9999999993', 'Abhiram@gmail.com', 'Mumbai'),
('1004', 'Kumar', '9999999994', 'Kumar@gmail.com', 'Uttar Pradesh'),
('1005', 'Katty', '9999999995', 'Katty@gmail.com', 'Mumbai'),
('1006', 'Shiv', '9999999996', 'Shiv@gmail.com', 'Goa'),
('1007', 'Dinesh', '9999999997', 'Dinesh@gmail.com', 'Uttrakhand'),
('1008', 'Sarthak', '9999999998', 'Sarthak@gmail.com', 'Delhi')
;
Select * from Attendees;

Insert into Registrations 
(Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) values 
('10001', '101', '1001', '2024-01-08', '7500'),
('10002', '102', '1003', '2023-09-25', '1000'),
('10003', '103', '1002', '2023-10-29', '2000'),
('10004', '104', '1004', '2023-10-20', '500'),
('10005', '101', '1005', '2023-09-10', '7500'),
('10006', '103', '1008', '2023-09-15', '2000'),
('10007', '101', '1007', '2023-11-23', '7500'),
('10008', '102', '1006', '2023-11-12', '1000')
;
Select *from Registrations;

--3) Manage Event Details 
a) Insert New event 
Insert INTO Events (Event_Id, Event_Name, Event_Date, Event_Location, Event_Description) VALUES 
('106', 'Untold Stories', '2023-11-19', 'Delhi', 'Storytelling');

--b) Update event's information 
UPDATE Events
SET Event_Location = 'Bangalore' Where Event_Id = '104'
;

--c) Deleting an event 
Delete from Events where Event_Id = '105'
;

--4) Manage Track attendees and handle events 
--a) Insert new attendee 
Insert into Attendees (Attendee_Id, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City) 
values ('1009', 'Kavitha', '9999999999', 'Kavitha@gmail.com', 'Hyderabad');

--b) Register attendee 
Insert into Registrations (Registration_Id, Event_Id, Attendee_Id, Registration_Date, Registration_Amount) 
values ('10009', '101', '1009', '2023-11-11', '7500');

--5) Retrieve event information, Generate attendee list, Calculate event attendee statistics
Select * from Events;
Select * from Attendees;
select * from Registrations;
with Event1 as(
select E.Event_id, E.event_name, E.event_date, E.event_location,
sum(R.registration_amount) over(partition by E.event_id) as Amountgenperevent
from Events E join Registrations R on E.event_id = R.event_id
join Attendees A on A.attendee_id = R.attendee_id)
select Event_id, event_name, event_location, Amountgenperevent 
from Event1
group by 1,2,3,4

