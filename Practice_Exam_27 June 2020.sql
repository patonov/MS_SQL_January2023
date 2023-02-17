CREATE DATABASE WMS

USE WMS

CREATE TABLE Clients(
	ClientId INT NOT NULL IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Phone CHAR(12) NOT NULL
)

CREATE TABLE Mechanics(
	MechanicId INT NOT NULL IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(255) NOT NULL
)

CREATE TABLE Models(
	ModelId INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL UNIQUE
)

CREATE TABLE Jobs(
	JobId INT NOT NULL IDENTITY PRIMARY KEY,
	ModelId INT NOT NULL FOREIGN KEY REFERENCES Models(ModelId),
	[Status] NVARCHAR(11) NOT NULL DEFAULT 'Pending' CHECK([Status] IN ('Pending', 'In Progress', 'Finished', 'Pending')),
	ClientId INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientId),
	MechanicId INT NULL FOREIGN KEY REFERENCES Mechanics(MechanicId),
	IssueDate DATE NOT NULL,
	FinishDate DATE NULL
)

CREATE TABLE Orders(
	OrderId INT NOT NULL IDENTITY PRIMARY KEY,
	JobId INT NOT NULL FOREIGN KEY REFERENCES Jobs(JobId),
	IssueDate DATE NULL,
	Delivered BIT NOT NULL DEFAULT 0
)

CREATE TABLE Vendors(
	VendorId INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL UNIQUE
)

CREATE TABLE Parts(
	PartId INT NOT NULL IDENTITY PRIMARY KEY,
	SerialNumber NVARCHAR(50) NOT NULL UNIQUE,
	[Description] NVARCHAR(255) NULL,
	Price MONEY NOT NULL CHECK(Price > 0 AND Price < 9999.99),
	VendorId INT NOT NULL FOREIGN KEY REFERENCES Vendors(VendorId),
	StockQty INT NOT NULL DEFAULT 0 CHECK(StockQty >= 0)
)

CREATE TABLE OrderParts(
	OrderId INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderId),
	PartId INT NOT NULL FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT NOT NULL DEFAULT 1 CHECK(Quantity > 0),
	CONSTRAINT PK_OrderParts PRIMARY KEY(OrderId, PartId)
)

CREATE TABLE PartsNeeded(
	JobId INT NOT NULL FOREIGN KEY REFERENCES Jobs(JobId),
	PartId INT NOT NULL FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT NOT NULL DEFAULT 1 CHECK(Quantity > 0),
	CONSTRAINT PK_PartsNeeded PRIMARY KEY(JobId, PartId)
)

INSERT INTO Clients(FirstName, LastName, Phone) VALUES
('Teri', 'Ennaco', '570-889-5187'),
('Merlyn',	'Lawler', '201-588-7810'),
('Georgene', 'Montezuma', '925-615-5185'),
('Jettie', 'Mconnell', '908-802-3564'),
('Lemuel', 'Latzke', '631-748-6479'),
('Melodie', 'Knipp', '805-690-1682'),
('Candida', 'Corbley', '908-275-8357')

INSERT INTO Parts(SerialNumber, [Description], Price, VendorId) VALUES
('WP8182119', 'Door Boot Seal',	117.86, 2),
('W10780048', 'Suspension Rod',	42.81, 1),
('W10841140', 'Silicone Adhesive', 6.77, 4),
('WPY055980', 'High Temperature Adhesive', 13.94, 3)

UPDATE Jobs SET MechanicId = 3 WHERE [Status] = 'Pending'
UPDATE Jobs SET [Status] = 'In Progress' WHERE MechanicId = 3 AND [Status] != 'Finished'

delete OrderParts where OrderId = 19
delete Orders where OrderId = 19

select 
	CONCAT(m.FirstName, ' ', m.LastName) as Mechanic,
	j.[Status],
	j.IssueDate as IssueDate
from Jobs as j
join Mechanics as m on m.MechanicId = j.MechanicId
order by j.MechanicId asc, IssueDate asc, j.JobId


select concat(c.FirstName, ' ', c.LastName) as Client,
DATEDIFF(day, j.IssueDate, '2017-04-24') as [Days going],
j.[Status]
from Jobs as j
join Clients as c on c.ClientId = j.ClientId
where j.[Status] != 'Finished'
order by [Days going] desc, j.ClientId asc

