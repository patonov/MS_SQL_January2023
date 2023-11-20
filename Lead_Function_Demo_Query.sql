SELECT 
SUM([Host Wizard Deposit] - [Guest Wizard Deposit]) AS SumDifference 
FROM
(SELECT
	--FirstName AS [Host Wizzard],
	DepositAmount AS [Host Wizard Deposit],
	--LEAD (FirstName) OVER ( order by Id ) AS [Guest Wizard],
	LEAD (DepositAmount) OVER ( order by Id) AS [Guest Wizard Deposit]
	FROM WizzardDeposits
) AS DepositTable