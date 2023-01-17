SELECT * FROM Employees AS e WHERE e.JobTitle = 'Sales Representative'

UPDATE Employees SET Salary = Salary * 1.5 WHERE MiddleName IS NULL

SELECT CONCAT(FirstName, '.', LastName, '@', 'softuni.bg') AS [Full Email Address] FROM Employees

SELECT DISTINCT Salary FROM Employees

SELECT FirstName, LastName, JobTitle FROM Employees WHERE Salary BETWEEN 20000 AND 30000

SELECT CONCAT_WS(' ', [FirstName], [MiddleName], [LastName]) AS [Full name] FROM [Employees] WHERE [Salary] IN (25000, 14000, 12500, 23600)

SELECT FirstName, LastName FROM Employees WHERE ManagerID IS NULL

SELECT TOP(5) FirstName, LastName, Salary FROM Employees ORDER BY Salary DESC

SELECT FirstName, LastName FROM Employees WHERE DepartmentID != 4


