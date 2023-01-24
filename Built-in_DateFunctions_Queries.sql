SELECT ProjectID, [Name], 
	ISNULL(CAST([EndDate] AS varchar), 'In process')
FROM Projects

SELECT ProjectID, [Name], 
	YEAR(StartDate) AS [Year],
	MONTH(StartDate) AS [Month],
	DAY(StartDate) AS [Day]
FROM Projects

SELECT ProjectID, [Name], 
	DATEPART(YEAR, StartDate) AS [Year],
	DATEPART(QUARTER, StartDate) AS [Quarter],
	DATEPART(MONTH, StartDate) AS [Month],
	DATEPART(DAY, StartDate) AS [Day],
	DATEPART(HOUR, StartDate) AS [Hour]
FROM Projects

SELECT ProjectID, [Name], 
	DATEDIFF(MONTH, StartDate, EndDate) AS [Project Duration in Months]
FROM Projects

SELECT GETDATE()

SELECT EOMONTH(StartDate) AS [End of the Month of Start of the Project] FROM Projects