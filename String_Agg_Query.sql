SELECT STRING_AGG(FirstName,'-') AS Result FROM Employees

select STRING_AGG ( Salary,'-' ) WITHIN GROUP ( ORDER BY FirstName ) from Employees
group by DepartmentID, Salary
having Salary > 13500
