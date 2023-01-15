CREATE DATABASE Hotel

USE Hotel

CREATE TABLE Employees(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	FirstName NVARCHAR(20) NOT NULL, 
	LastName NVARCHAR(20) NOT NULL, 
	Title NVARCHAR(40) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Customers(
	AccountNumber VARCHAR(17) NOT NULL PRIMARY KEY, 
	FirstName NVARCHAR(20) NOT NULL, 
	LastName NVARCHAR(20) NOT NULL, 
	PhoneNumber VARCHAR(10) NOT NULL, 
	EmergencyName NVARCHAR(40) NOT NULL, 
	EmergencyNumber VARCHAR(10) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE RoomStatus(
	RoomStatus NVARCHAR(14) NOT NULL PRIMARY KEY, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE RoomTypes(
	RoomType NVARCHAR(14) NOT NULL PRIMARY KEY, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE BedTypes(
	BedType NVARCHAR(14) NOT NULL PRIMARY KEY,
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Rooms(
	RoomNumber INT NOT NULL IDENTITY PRIMARY KEY, 
	RoomType NVARCHAR(14) NOT NULL FOREIGN KEY REFERENCES RoomTypes(RoomType), 
	BedType NVARCHAR(14) NOT NULL FOREIGN KEY REFERENCES BedTypes(BedType),
	Rate MONEY NOT NULL,
	RoomStatus NVARCHAR(14) NOT NULL FOREIGN KEY REFERENCES RoomStatus(RoomStatus),
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Payments(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id), 
	PaymentDate DATE NOT NULL, 
	AccountNumber VARCHAR(17) NOT NULL FOREIGN KEY REFERENCES Customers(AccountNumber), 
	FirstDateOccupied DATE NOT NULL, 
	LastDateOccupied DATE NOT NULL, 
	TotalDays INT NOT NULL, 
	AmountCharged MONEY NOT NULL, 
	TaxRate FLOAT NOT NULL, 
	TaxAmount MONEY NOT NULL, 
	PaymentTotal MONEY NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Occupancies(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),  
	DateOccupied DATE NOT NULL, 
	AccountNumber VARCHAR(17) NOT NULL FOREIGN KEY REFERENCES Customers(AccountNumber),
	RoomNumber INT NOT NULL FOREIGN KEY REFERENCES Rooms(RoomNumber), 
	RateApplied MONEY NOT NULL, 
	PhoneCharge MONEY NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

INSERT INTO Employees VALUES
('Пешо', 'Емплоя', 'хигенист', 'добър е, заеби'),
('Владо', 'Плъха', 'параджия', 'отвътре му идва'),
('Симо', 'Камерата', 'камериер', 'кръгъл апаш, да го еба')

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
('BG17FIN0V1441TFJT', 'Джон', 'Мейнъра', '0899091071', 'пожарна', '112', 'британски олигофрен - пие като смок и буйства'),
('BG17FIN0V3334TFJT', 'Джахалина', 'Минети', '0888091021', 'полиция', '112', 'палава кучка - проблеми с хигената, мирише'),
('BG17FIN0V1111TFJT', 'Бай Митьо', 'Волгата', '0799111973', 'бърза помощ', '112', 'пълен бай Ганьо, напива се и се напикава')

INSERT INTO RoomStatus (RoomStatus, Notes) VALUES
('заето', NULL),
('свободно', NULL),
('в ремонт', NULL)

INSERT INTO RoomTypes (RoomType, Notes) VALUES
('с едно легло', NULL),
('с две легла', NULL),
('специална', NULL)

INSERT INTO BedTypes (BedType, Notes) VALUES
('пълно', NULL),
('празно', NULL),
('смесено', NULL)

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus, Notes) VALUES
('с едно легло', 'пълно', 100.50, 'свободно', 'Вратата на тоалетната не се затваря.'),
('с едно легло', 'празно', 50.50, 'свободно', 'Напукано огледало в банята.'),
('специална', 'смесено', 400.50, 'свободно', 'Много чистене след ползване.')

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) VALUES
(1, '2022-01-17', 'BG17FIN0V1441TFJT', '2022-01-16', '2022-01-17', 1, 100.50, 0.10, 10.05, 110.55, NULL),
(2, '2022-12-30', 'BG17FIN0V3334TFJT', '2022-12-29', '2022-12-30', 1, 50.50, 0.10, 5.05, 55.55, NULL),
(3, '2022-01-02', 'BG17FIN0V1111TFJT', '2022-01-01', '2022-01-02', 1, 400.50, 0.10, 40.05, 440.55, NULL)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) VALUES
(1, '2022-01-16', 'BG17FIN0V1441TFJT', 1, 100.50, 0.00, N'Оставя стаята голяма кочина.'),
(1, '2022-12-29', 'BG17FIN0V3334TFJT', 2, 50.50, 0.02, N'Скучно пребиваване.'),
(1, '2022-01-01', 'BG17FIN0V1111TFJT', 3, 400.50, 10.22, N'Този път беше леко.')