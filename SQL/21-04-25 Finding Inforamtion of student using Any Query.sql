-- 21/04-25 Work Assignment 
  /* Create the table
CREATE TABLE student_info (
    StudentID INT PRIMARY KEY,
    FirstNames VARCHAR(50),
    LastNames VARCHAR(50)
);

-- Insert 10 values for each variable
INSERT INTO student_info (StudentID, FirstNames, LastNames) VALUES
(1, 'John', 'Doe'),
(2, 'Alice', 'Smith'),
(3, 'Bob', 'Johnson'),
(4, 'Emily', 'Brown'),
(5, 'Michael', 'Davis'),
(6, 'Sarah', 'Wilson'),
(7, 'David', 'Lee'),
(8, 'Jessica', 'Taylor'),
(9, 'Chris', 'Evans'),
(10, 'Emma', 'Thompson');
Copy and Paste the following code to create a table exam_info within the database

-- Create the table
CREATE TABLE exam_info (
    StudentID INT PRIMARY KEY,
    Subjects VARCHAR(50),
    Scores integer
);
 
-- Insert 10 values for each variable
INSERT INTO exam_info (StudentID, Subjects, Scores) VALUES
(1, 'Math',  80),
(2, 'English',  75),
(3, 'Science',  78),
(4, 'Math',  60),
(5, 'English', 86),
(6, 'Science', 90),
(7, 'Science', 75),
(8, 'English', 75),
(9, 'Math',  55),
(10, 'Math',  67);
Write necessary code to filter all the columns of student_info table where StudentID from both tables equals to each other 
AND Scores is greater than 75. That means you are finding the information of the students who scored more than 75 in the exam. */
use udaanuos25;
CREATE TABLE student_info (
    StudentID INT PRIMARY KEY,
    FirstNames VARCHAR(50),
    LastNames VARCHAR(50)
);
INSERT INTO student_info (StudentID, FirstNames, LastNames) VALUES
(1, 'John', 'Doe'),
(2, 'Alice', 'Smith'),
(3, 'Bob', 'Johnson'),
(4, 'Emily', 'Brown'),
(5, 'Michael', 'Davis'),
(6, 'Sarah', 'Wilson'),
(7, 'David', 'Lee'),
(8, 'Jessica', 'Taylor'),
(9, 'Chris', 'Evans'),
(10, 'Emma', 'Thompson');
select * from student_info;
-- create another table

CREATE TABLE exam_info (
    StudentID INT PRIMARY KEY,
    Subjects VARCHAR(50),
    Scores integer
);
INSERT INTO exam_info (StudentID, Subjects, Scores) VALUES
(1, 'Math',  80),
(2, 'English',  75),
(3, 'Science',  78),
(4, 'Math',  60),
(5, 'English', 86),
(6, 'Science', 90),
(7, 'Science', 75),
(8, 'English', 75),
(9, 'Math',  55),
(10, 'Math',  67);
select * from exam_info; 
select * from student_info s inner join exam_info e on s.StudentID=e.StudentID
where Scores > any (select s.StudentID from student_info where Scores > 75);

