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