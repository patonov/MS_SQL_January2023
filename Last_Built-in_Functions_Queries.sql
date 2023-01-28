USE [Geography]

SELECT
	p.PeakName AS [PeakName],
	r.RiverName AS [RiverName],
	LOWER(CONCAT([PeakName], SUBSTRING([RiverName], 2, LEN([RiverName]) - 1))) AS [Mix]
FROM Peaks AS p
JOIN Rivers AS r ON SUBSTRING(p.PeakName, LEN(p.PeakName), 1) = SUBSTRING(r.RiverName, 1, 1)
ORDER BY Mix ASC

USE Diablo

SELECT TOP 50
	g.[Name],
	FORMAT(g.Start, 'yyyy-MM-dd') AS [Start]
FROM Games AS g
WHERE YEAR(g.[Start]) IN (2011, 2012)
ORDER BY [Start], g.[Name]

SELECT
	Username,
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider], Username

SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username


SELECT [Name] AS Game
     , CASE
            WHEN DATEPART(hour,[Start]) >= 0 AND DATEPART(hour,[Start]) < 12 THEN 'Morning'
            WHEN DATEPART(hour, [Start]) >= 12 AND DATEPART(hour,[Start]) < 18 THEN 'Afternoon'
            WHEN DATEPART(hour, [Start]) >= 18 AND DATEPART(hour,[Start]) < 24 THEN 'Evening'
       END AS 'Part of the Day'
     , CASE
            WHEN [Duration] <= 3 THEN 'Extra Short'
            WHEN [Duration] >= 4 AND [Duration] <= 6 THEN 'Short'
            WHEN [Duration] > 6 THEN 'Long'
            ELSE 'Extra Long'        
       END AS 'Duration'
  FROM Games
ORDER BY [Name], Duration, [Start]