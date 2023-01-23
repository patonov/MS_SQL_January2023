USE SoftUni

SELECT FirstName, LastName FROM Employees WHERE FirstName LIKE 'Sa%'

SELECT FirstName, LastName FROM Employees WHERE LastName LIKE '%ei%'

SELECT COUNT(*)
	FROM Employees
	GROUP BY DepartmentID
HAVING MIN(Salary) > 5000;

SELECT FirstName FROM Employees WHERE DepartmentID IN (3, 10) AND HireDate BETWEEN '1995-01-01' AND '2005-12-31'

SELECT FirstName FROM Employees WHERE DepartmentID IN (3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005

SELECT * FROM (SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER(PARTITION BY Salary ORDER BY EmployeeID) AS [Rank] 
FROM Employees WHERE Salary BETWEEN 10000 AND 50000) AS [TRALALA]
WHERE [Rank] = 2
ORDER BY Salary DESC

SELECT FirstName, LastName FROM Employees WHERE JobTitle NOT LIKE('%engineer%')

SELECT TownID, [Name] FROM Towns WHERE [Name] LIKE '[MKBE]%' ORDER BY [Name]

SELECT TownID, [Name] FROM Towns WHERE [Name] NOT LIKE '[RBD]%' ORDER BY [Name]

GO

CREATE OR ALTER VIEW [V_EmployeesHiredAfter2000]
AS SELECT FirstName, LastName FROM Employees WHERE HireDate >= '2001-01-01'  

GO

SELECT FirstName, LastName FROM Employees WHERE YEAR(HireDate) >= 2001

SELECT FirstName, LastName FROM Employees WHERE LEN(LastName) = 5

USE Geography
SELECT CountryName, IsoCode AS [ISO Code] FROM Countries WHERE CountryName LIKE '%a%a%a%' ORDER BY IsoCode



