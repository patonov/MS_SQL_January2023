select 
	FirstName 
from Employees
where FirstName like '[gr]%'

select 
	FirstName 
from Employees
where FirstName like '[a-b]%'

select 
	FirstName 
from Employees
where FirstName like 'g_y'

select 
	FirstName 
from Employees
where FirstName like 'g_%'

select 
	FirstName 
from Employees
where FirstName like '%u%'

select 
left(FirstName, 1) as [letter], 
count(left(FirstName, 1)) as tralala from Employees
group by left(FirstName, 1)
order by letter

SELECT 
	* 
FROM (SELECT EmployeeID, FirstName, LastName, Salary, cume_dist() OVER(PARTITION BY Salary ORDER BY EmployeeID) AS [Cumulate] 
FROM Employees WHERE Salary BETWEEN 10000 AND 50000) AS [GotinoE]
ORDER BY Salary DESC

SELECT 
	* 
FROM (SELECT EmployeeID, FirstName, LastName, Salary, first_value(FirstName) OVER(PARTITION BY Salary ORDER BY EmployeeID) AS [Champion in the Group] 
FROM Employees WHERE Salary BETWEEN 10000 AND 50000) AS [GotinoE]
ORDER BY Salary DESC

SELECT 
	* 
FROM (SELECT EmployeeID, FirstName, LastName, Salary, cume_dist() OVER(PARTITION BY Salary ORDER BY EmployeeID) AS [Cumulate], percent_rank() OVER(PARTITION BY Salary ORDER BY EmployeeID) AS [Percentage]  
FROM Employees WHERE Salary BETWEEN 10000 AND 50000) AS [GotinoE]
ORDER BY Salary DESC

