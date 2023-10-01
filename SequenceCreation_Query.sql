use SoftUni
go

CREATE VIEW v_EmployeesByDepartment AS
SELECT 
	FirstName + ' ' + LastName AS [Full Name],
    Salary
FROM Employees

go

select * from v_EmployeesByDepartment

INSERT INTO Projects ([Name], StartDate) 
SELECT [Name] + ' Restructuring', GETDATE()
FROM Departments

select [Name], [StartDate] from Projects

CREATE SEQUENCE seq_Customers_CustomerID 
             AS INT
     START WITH 1
   INCREMENT BY 1

go

SELECT NEXT VALUE FOR seq_Customers_CustomerID




