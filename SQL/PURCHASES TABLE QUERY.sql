-- DATE 19/04/25

   CREATE DATABASE UDAANUOS25;
   USE UDAANUOS25;
CREATE TABLE purchases (
    CustomerID INT,
    PurchaseDate DATE,
    ReturnDate DATE); 
    INSERT INTO purchases (CustomerID, PurchaseDate, ReturnDate) VALUES
(1, '2024-01-01', '2024-01-09'),
(2, '2024-01-02', '2024-01-16'),
(3, '2024-01-03', '2024-01-11'),
(4, '2024-01-04', '2024-01-08'),
(5, '2024-01-05', '2024-01-09'),
(6, '2024-01-06', '2024-01-10'),
(7, '2024-01-07', '2024-01-21'),
(8, '2024-01-08', '2024-01-29'),
(9, '2024-01-09', '2024-01-13'),
(10, '2024-01-10', '2024-01-24'); 

SELECT * FROM PURCHASES;
-- Write necessary code to find the difference between PurchaseDate and ReturnDate columns. Store the output in DateDifference.
SELECT datediff(PurchaseDate, ReturnDate) AS DATE_DIFF FROM PURCHASES;

use udaanuos25;
-- Write necessary code to extract the years from the column ReturnDate. Store the output in YearsData.
SELECT *, extract(year from ReturnDate) AS Year_Data
FROM PURCHASES; 

SELECT * FROM courses_data;
select * from enrollments_data; 
select * from student_information;

-- 39 Order by 
select * from student_information order by FirstName asc;
select * from student_information;

-- 40 group by
select count(Grade) Grade from enrollments_data group by Grade;

-- 41 Inner join
alter table student_information rename column `Student ID` to Student_ID; 
alter table enrollments_data rename column `Student ID` to Student_ID; 
-- select * from student_information inner join Student ID on enrollments_data = Student ID;
select * from student_information s inner join enrollments_data e on s.Student_ID = e.Student_ID;

-- 42 Left join
select * from student_information s left join enrollments_data e on s.Student_ID = e.Student_ID;

-- 43 right join
select * from student_information s right join enrollments_data e on s.Student_ID = e.Student_ID;

-- 44 cross join
select * from student_information s cross join enrollments_data e on s.Student_ID = e.Student_ID;

-- 45 having 
select * from student_information; 
select count(GPA) GPA from student_information group by GPA having avg(GPA)>3; 

-- 46 exists
select Student_ID  from student_information
where exists(select Student_ID from enrollments_data where Student_ID = 6);

-- 47 Any 
select Student_ID  from student_information
where Student_ID = any(select Student_ID from enrollments_data where Student_ID = 6);


