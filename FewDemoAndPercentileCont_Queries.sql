use SoftUni
go

select *, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary DESC) OVER (PARTITION BY DepartmentId) AS MedianCont
from Employees
go

use BookShop

select STUFF(a.FirstName, 4, 0, 'dobar') from Authors as a
where AuthorId = 1

select a.FirstName from Authors as a
where AuthorId = 1

select CHARINDEX('yd', a.FirstName) from Authors as a
where AuthorId = 1

select round(sqrt(square(pi() * AuthorId)), 2) from Authors