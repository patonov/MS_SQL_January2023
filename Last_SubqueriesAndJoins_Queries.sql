USE SoftUni

SELECT
	e.EmployeeID,
	e.FirstName,
	(CASE 
	WHEN YEAR(p.StartDate) >= 2005 THEN NULL
	ELSE p.[Name]
	END) AS ProjectName
FROM Employees AS e
JOIN EmployeesProjects AS epr ON e.EmployeeID = epr.EmployeeID
JOIN Projects AS p ON epr.ProjectID = p.ProjectID
WHERE epr.EmployeeID = 24



SELECT
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	m.[FirstName] AS ManagerName
FROM Employees AS e
JOIN Employees AS m ON m.EmployeeID = e.ManagerID
WHERE m.EmployeeID IN (3, 7)
ORDER BY e.EmployeeID ASC

SELECT TOP 50 
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName,
	d.[Name] AS DepartmentName
FROM Employees AS e
JOIN Employees AS m ON e.ManagerID = m.EmployeeID
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

SELECT MIN(Averageee) AS MinAverageSalary FROM (SELECT AVG(Salary) AS Averageee FROM Employees GROUP BY DepartmentID) AS MinAveDep

USE Geography

SELECT * FROM Peaks
SELECT * FROM Mountains
SELECT * FROM MountainsCountries

SELECT 
	mc.CountryCode,
	COUNT(m.MountainRange) AS MountainRanges
FROM MountainsCountries AS mc
JOIN Mountains AS m ON m.Id = mc.MountainId
GROUP BY mc.CountryCode
HAVING mc.CountryCode IN ('US', 'RU', 'BG')


SELECT TOP 5
	CountryName,
	RiverName
FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId 
WHERE c.ContinentCode = 'AF'
ORDER BY CountryName ASC

SELECT interim.ContinentCode,
	   interim.CurrencyCode,
	   interim.CurrencyUsage
  FROM Continents AS c
  JOIN (
	   SELECT ContinentCode AS ContinentCode,
	   COUNT(CurrencyCode) AS CurrencyUsage,
	   CurrencyCode AS CurrencyCode,
	   DENSE_RANK() OVER (PARTITION BY ContinentCode
	                      ORDER BY COUNT(CurrencyCode) DESC
						  ) AS [CurrenciesRank]
	   FROM Countries
	   GROUP BY ContinentCode, CurrencyCode
	   HAVING COUNT(CurrencyCode) > 1
	   ) AS interim ON c.ContinentCode = interim.ContinentCode
WHERE interim.CurrenciesRank = 1

SELECT
	COUNT(*) AS [Count] 
FROM Countries AS c 
LEFT JOIN MountainsCountries AS m ON c.CountryCode = m.CountryCode
WHERE m.MountainId IS NULL