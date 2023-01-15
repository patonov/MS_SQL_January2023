USE SoftUni
SELECT t.[Name] FROM Towns AS t ORDER BY t.[Name]

SELECT d.[Name] FROM Departments AS d ORDER BY d.[Name]

SELECT e.FirstName, e.LastName, e.JobTitle, e.Salary FROM Employees AS e ORDER BY e.Salary DESC

UPDATE Employees SET Salary = Salary * 1.1
SELECT e.Salary FROM Employees AS e

USE Hotel
UPDATE Payments SET TaxRate = TaxRate - 0.03
SELECT p.TaxRate FROM Payments AS p