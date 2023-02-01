SELECT COUNT(*) AS [Count] FROM WizzardDeposits 

SELECT MAX(MagicWandSize) AS LongestMagicWand FROM WizzardDeposits

SELECT TOP 2
	w.DepositGroup
FROM WizzardDeposits AS w
GROUP BY w.DepositGroup
ORDER BY AVG(MagicWandSize) ASC

SELECT
	w.DepositGroup,
	SUM(w.DepositAmount)
FROM WizzardDeposits AS w
GROUP BY w.DepositGroup

SELECT
	w.DepositGroup,
	SUM(w.DepositAmount) AS TotalSum
FROM WizzardDeposits AS w
GROUP BY w.DepositGroup, w.MagicWandCreator 
HAVING w.[MagicWandCreator] = 'Ollivander Family'

SELECT * FROM
(
SELECT
	w.DepositGroup,
	SUM(w.DepositAmount) AS TotalSum
FROM WizzardDeposits AS w
GROUP BY w.DepositGroup, w.MagicWandCreator 
HAVING w.[MagicWandCreator] = 'Ollivander Family') AS tab 
WHERE tab.TotalSum < 150000
ORDER BY tab.TotalSum DESC

SELECT 
	w.DepositGroup,
	w.MagicWandCreator,
	MIN(w.DepositCharge) AS MinDepositCharge
FROM [WizzardDeposits] AS w
GROUP BY w.DepositGroup, w.MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup









