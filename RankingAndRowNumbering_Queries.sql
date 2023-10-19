use SoftUni
go

SELECT 
	* 
FROM (SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER(PARTITION BY Salary ORDER BY EmployeeID) AS [Rank] 
FROM Employees WHERE Salary BETWEEN 10000 AND 50000) AS [GotinoE]
ORDER BY Salary DESC


select * from (SELECT EmployeeID, FirstName, LastName, Salary, ROW_NUMBER() over (partition by FirstName order by EmployeeID) as RowsNumBer
FROM Employees) as [tapnya]
order by RowsNumBer desc

select * from (SELECT EmployeeID, FirstName, LastName, Salary, ROW_NUMBER() over (partition by concat_ws(' ', FirstName, LastName) order by EmployeeID) as RowsNumBer
FROM Employees) as [tapnya]
order by RowsNumBer desc

select * from (SELECT EmployeeID, FirstName, LastName, Salary, rank() over (partition by Salary order by EmployeeID) as [Rank]
FROM Employees) as [tapnya]
order by [Rank] desc

select * from (SELECT EmployeeID, FirstName, LastName, Salary, NTILE(4) OVER(PARTITION BY Salary ORDER BY EmployeeID DESC) AS Quartile
FROM Employees) as [tapnya]
order by Quartile desc

select * from (SELECT EmployeeID, FirstName, LastName, Salary, NTILE(4) OVER(ORDER BY EmployeeID DESC) AS Quartile
FROM Employees) as [tapnya]
order by Quartile desc