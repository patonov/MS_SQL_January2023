SELECT 
	CASE
		WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN w.Age >= 61 THEN '[61+]'
	END AS [AgeGroup],
	COUNT(*) AS WizardCount
FROM WizzardDeposits AS w
GROUP BY 
	CASE
		WHEN w.Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN w.Age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN w.Age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN w.Age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN w.Age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN w.Age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN w.Age >= 61 THEN '[61+]'
	END

SELECT SUBSTRING(w.FirstName, 1, 1) FROM WizzardDeposits AS w
GROUP BY SUBSTRING(w.FirstName, 1, 1), w.DepositGroup
HAVING w.DepositGroup = 'Troll Chest'


SELECT 	
	w.DepositGroup, 
	IsDepositExpired,
	AVG(w.DepositInterest) AS [AverageInterest]	
FROM WizzardDeposits AS w
WHERE DepositStartDate > '1985-01-01'
GROUP BY w.DepositGroup, w.IsDepositExpired
ORDER BY w.DepositGroup DESC, w.IsDepositExpired