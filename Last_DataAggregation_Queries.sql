USE Gringotts

SELECT * FROM WizzardDeposits

SELECT 
	SUM(x.NextWizzardDeposit) AS SumDifference 
FROM (SELECT DepositAmount - (SELECT DepositAmount FROM WizzardDeposits WHERE Id = w.Id + 1) AS NextWizzardDeposit FROM WizzardDeposits AS w) AS x

USE SoftUni

SELECT 
	e.DepartmentID,
	SUM(e.Salary) AS TotalSalary
FROM Employees AS e
GROUP BY e.DepartmentID
ORDER BY e.DepartmentID


SELECT 
	e.DepartmentID,
	MIN(e.Salary) AS MinimumSalary
FROM Employees AS e
WHERE e.HireDate > '2000-01-01'
GROUP BY e.DepartmentID
HAVING e.DepartmentID IN (2, 5, 7)

GO

SELECT * INTO [EmpInterimTab] FROM Employees
WHERE [Salary] > 30000
 
DELETE FROM [EmpInterimTab]
WHERE [ManagerID] = 42
 
UPDATE [EmpInterimTab]
SET [Salary] += 5000
WHERE [DepartmentID] = 1
 
SELECT [DepartmentID],
    AVG([Salary]) AS [AverageSalary]
FROM [EmpInterimTab]
GROUP BY [DepartmentID]

GO

SELECT 
	ehee.DepartmentID,
	ehee.MaxSalary
FROM
(
SELECT 
	e.DepartmentID,
	MAX(e.Salary) AS MaxSalary
FROM Employees AS e
GROUP BY e.DepartmentID) AS ehee
WHERE ehee.MaxSalary NOT BETWEEN 30000 AND 70000

SELECT
	e.DepartmentID,
	MAX(e.Salary) AS MaxSalary
FROM Employees AS e
GROUP BY e.DepartmentID
HAVING MAX(e.Salary) NOT BETWEEN 30000 AND 70000

SELECT COUNT(e.Salary) AS [Count]
FROM Employees AS e
LEFT JOIN Employees AS m ON e.ManagerID = m.ManagerID
WHERE e.ManagerID IS NULL

GO

WITH SalaryRank 
	AS (SELECT 
		e.DepartmentID,
		e.Salary,
		DENSE_RANK() OVER (PARTITION BY e.DepartmentId ORDER BY e.Salary DESC) AS [Rank]
		FROM Employees AS e
		)
SELECT DISTINCT DepartmentID,
       Salary AS ThirdHighestSalary
  FROM SalaryRank
 WHERE [Rank] = 3

SELECT TOP(10) 
	e.FirstName, 
	e.LastName, 
	e.DepartmentID
FROM Employees AS e
WHERE e.Salary > (SELECT AVG(ehee.Salary)
				FROM Employees AS ehee
				WHERE e.DepartmentID = ehee.DepartmentID)
ORDER BY e.DepartmentID








