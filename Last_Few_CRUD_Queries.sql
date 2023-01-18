USE SoftUni

SELECT TOP(7) FirstName, LastName, HireDate FROM Employees ORDER BY HireDate DESC

GO

UPDATE Employees SET Salary = Salary * 1.12 WHERE DepartmentID IN (1, 2, 4, 11)

SELECT Salary FROM Employees

UPDATE Employees SET Salary = Salary / 1.12 WHERE DepartmentID IN (1, 2, 4, 11)

GO

USE Geography

SELECT PeakName FROM Peaks ORDER BY PeakName ASC

SELECT TOP(30) CountryName, [Population] FROM Countries WHERE [ContinentCode] = 'EU' ORDER BY [Population] DESC, CountryName

SELECT CountryName, CountryCode, 
	CASE CurrencyCode
		WHEN 'EUR' THEN 'Euro'
		ELSE 'Not Euro'
	END AS 'Currency'
FROM Countries ORDER BY CountryName

GO

USE Diablo
SELECT [Name] FROM Characters ORDER BY [Name] ASC