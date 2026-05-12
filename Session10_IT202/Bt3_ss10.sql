CREATE DATABASE bt3_ss10;
USE bt3_ss10;

CREATE VIEW Department_Revenue_View AS
SELECT d.Dept_Name AS Department,
COUNT(DISTINCT i.Patient_ID) AS Total_Patients,
SUM(i.Amount) AS Total_Revenue
FROM Departments AS d
JOIN Invoices AS i ON d.Dept_ID = i.Dept_ID
GROUP BY d.Dept_Name;

SELECT * FROM Department_Revenue_View;

UPDATE Department_Revenue_View
SET Total_Revenue = 999999
WHERE Department = 'Nội';
