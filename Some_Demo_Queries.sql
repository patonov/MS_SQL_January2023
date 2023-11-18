use SoftUni

select DepartmentID,
sum(Salary) as TotalSalary
from Employees
group by DepartmentID
order by DepartmentID

select DepartmentID,
count(Salary) as SalaryCount
from Employees
group by DepartmentID
order by DepartmentID

select DepartmentID,
max(Salary) as MaxSalary
from Employees
group by DepartmentID
order by DepartmentID

select DepartmentID,
min(Salary) as MinSalary
from Employees
group by DepartmentID
order by DepartmentID

select DepartmentID,
avg(Salary) as AvgSalary
from Employees
group by DepartmentID
order by DepartmentID

select DepartmentID,
sum(Salary) as TotalSalary
from Employees
group by DepartmentID
having sum(Salary) >= 150000

go
use Gringotts

select count(*) from WizzardDeposits

select max(MagicWandSize) from WizzardDeposits

select DepositGroup, max(MagicWandSize) LongestMagicWand from WizzardDeposits group by DepositGroup

select top(2) 
a.DepositGroup 
from 
(select 
DepositGroup, 
avg(MagicWandSize) MinWandSize 
from WizzardDeposits 
group by DepositGroup) as a
order by a.MinWandSize

select DepositGroup, sum(DepositAmount) from WizzardDeposits group by DepositGroup

select 
	DepositGroup, 
	sum(DepositAmount) TotalDepositSum
from WizzardDeposits
group by DepositGroup, MagicWandCreator
having MagicWandCreator = 'Ollivander family' and sum(DepositAmount) < 150000
order by TotalDepositSum desc

select 
	DepositGroup, 
	MagicWandCreator, 
	min(DepositCharge) 
from WizzardDeposits
group by DepositGroup, MagicWandCreator
order by MagicWandCreator, DepositGroup

select 
	case
		when Age between 0 and 10 then '[0-10]'
		when Age between 11 and 20 then '[11-20]'
		when Age between 21 and 30 then '[21-30]'
		when Age between 31 and 40 then '[31-40]'
		when Age between 41 and 50 then '[41-50]'
		when Age between 51 and 60 then '[51-60]'
		when Age >= 61 then '[61+]'
	end as [Age Groups],
	count(*) as [Number of Group Members]
from WizzardDeposits
group by
	case
		when Age between 0 and 10 then '[0-10]'
		when Age between 11 and 20 then '[11-20]'
		when Age between 21 and 30 then '[21-30]'
		when Age between 31 and 40 then '[31-40]'
		when Age between 41 and 50 then '[41-50]'
		when Age between 51 and 60 then '[51-60]'
		when Age >= 61 then '[61+]'
	end
order by [Age Groups]

select substring(w.FirstName, 1, 1) aaa from WizzardDeposits w
group by substring(w.FirstName, 1, 1), w.DepositGroup
having w.DepositGroup = 'Troll Chest'