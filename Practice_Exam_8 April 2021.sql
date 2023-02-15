CREATE DATABASE [Service]

USE [Service]

GO

CREATE TABLE Users(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Username VARCHAR(30) NOT NULL UNIQUE,
	[Password] VARCHAR(50) NOT NULL,
	[Name] VARCHAR(50) NULL,
	Birthdate DATETIME NULL,
	Age INT NOT NULL CHECK(Age >= 14 AND Age <= 110),
	Email VARCHAR(50) NOT NULL
)

CREATE TABLE Departments(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Employees(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(25) NULL,
	LastName NVARCHAR(25) NULL,
	Birthdate DATETIME NULL,
	Age INT NULL CHECK(Age >= 18 AND Age <= 110),
	DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id)
)

CREATE TABLE Categories(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id)
)

CREATE TABLE [Status](
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Label] VARCHAR(20) NOT NULL
)

CREATE TABLE Reports(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	StatusId INT NOT NULL FOREIGN KEY REFERENCES [Status](Id),
	OpenDate DATETIME NOT NULL,
	CloseDate DATETIME NULL,
	[Description] VARCHAR(200) NOT NULL,
	UserId INT NOT NULL FOREIGN KEY REFERENCES Users(Id),  
	EmployeeId INT NULL FOREIGN KEY REFERENCES Employees(Id)
)

INSERT INTO Employees(FirstName, LastName, Birthdate, DepartmentId) VALUES
('Marlo', 'O''Malley', '1958-9-21', 1),
('Niki', 'Stanaghan', '1969-11-26',	4),
('Ayrton', 'Senna',	'1960-03-21', 9),
('Ronnie', 'Peterson', '1944-02-14', 9),
('Giovanna', 'Amati', '1959-07-20', 5)

INSERT INTO Reports(CategoryId,	StatusId, OpenDate,	CloseDate, [Description], UserId, EmployeeId) VALUES
(1, 1, '2017-04-13', NULL, 'Stuck Road on Str.133',	6, 2),
(6, 3, '2015-09-05', '2015-12-06', 'Charity trail running', 3, 5),
(14, 2,	'2015-09-07', NULL, 'Falling bricks on Str.58', 5, 2),
(4, 3, '2017-07-03', '2017-07-06', 'Cut off streetlight on Str.11', 1, 1)

UPDATE Reports SET CloseDate = GETDATE() WHERE CloseDate IS NULL

--DELETE Reports WHERE StatusId = 4

SELECT [Description], FORMAT(OpenDate, 'dd-MM-yyyy') FROM Reports WHERE EmployeeId IS NULL ORDER BY OpenDate ASC

SELECT r.[Description], c.[Name] FROM Reports AS r
JOIN Categories AS c ON r.CategoryId = c.Id
WHERE r.CategoryId IS NOT NULL
ORDER BY r.[Description] ASC, c.[Name] ASC

select top 5 c.[Name] as CategoryName, count(r.CategoryId) as ReportsNumber from Reports as r
join Categories as c on r.CategoryId = c.Id
group by r.CategoryId, c.Name
order by ReportsNumber desc, c.Name asc 

select u.Username, c.[Name] as CategoryName from Reports as r
join Users as u on r.UserId = u.Id
join Categories as c on r.CategoryId = c.Id
where datepart(month, r.OpenDate) = datepart(month, u.Birthdate) and datepart(day, r.OpenDate) = datepart(day, u.Birthdate)
order by u.Username asc, c.Name asc

select concat(e.FirstName, ' ', e.LastName) as FullName, COUNT(r.UserId) as UsersCount from Employees as e 
left join Reports as r on r.EmployeeId = e.Id
left join Users as u on r.EmployeeId = u.Id
group by concat(e.FirstName, ' ', e.LastName)
order by UsersCount desc, FullName asc

select 
CASE WHEN CONCAT(e.FirstName,' ',e.LastName) IS NOT NULL
THEN CONCAT(e.FirstName,' ',e.LastName)
ELSE
'None'
END as Employee, 
ISNULL(d.Name, 'none') as Department, 
ISNULL(c.Name, 'none') as Category, 
ISNULL(r.[Description], 'none'), 
ISNULL(format(r.OpenDate, 'dd.MM.yyyy'), 'none'), 
ISNULL(st.[Label], 'none') as [Status], 
ISNULL(u.Name, 'none') as [User]
from Reports as r
left join Employees as e on r.EmployeeId = e.Id
left join Departments as d on d.Id = e.DepartmentId
left join Categories as c on r.CategoryId = c.Id
left join [Status] as st on r.StatusId = st.Id
left join Users as u on r.UserId = u.Id
order by e.FirstName desc, e.LastName desc, Department asc, Category asc, [Description] asc, r.OpenDate asc, [Status] asc, [User] asc

go

create function udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
returns int
as
begin
	declare @result int = DATEDIFF(HOUR, @StartDate, @EndDate)

	IF @result IS NULL
	BEGIN
	RETURN 0
	END

	RETURN @result
end

go
SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours FROM Reports
go
