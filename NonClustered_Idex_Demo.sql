CREATE NONCLUSTERED INDEX IX_Employees_FirstName_LastName
ON Employees(FirstName, LastName)

SET STATISTICS TIME ON
SET STATISTICS IO ON

select e.FirstName, ehe.LastName from Employees e cross join Employees ehe 

drop index IX_Employees_FirstName_LastName ON Employees

