SELECT * FROM Employees ORDER BY Salary DESC, FirstName, LastName DESC, MiddleName

GO

CREATE VIEW V_EmployeesSalaries 
AS
SELECT FirstName, LastName, Salary FROM Employees

GO

SELECT * FROM V_EmployeesSalaries

GO 

CREATE VIEW V_EmployeeNameJobTitle 
AS
SELECT FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS [Full Name], JobTitle FROM Employees

GO

SELECT DISTINCT JobTitle FROM Employees