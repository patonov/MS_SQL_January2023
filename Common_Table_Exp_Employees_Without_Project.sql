GO

WITH Employees_Without_Project_CTE (FirstName, LastName, DepartmentName, ProjectNameYok)
AS
(
  SELECT e.FirstName, e.LastName, d.[Name] as DepartmentName, p.[Name] as ProjectNameYok
  FROM Employees AS e 
  LEFT JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
  LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
  LEFT JOIN Projects AS p ON ep.ProjectID = p.ProjectID
  where p.[Name] is null
)

--SELECT FirstName, LastName, DepartmentName, ProjectNameYok FROM Employees_Without_Project_CTE;

select * from Employees_Without_Project_CTE;