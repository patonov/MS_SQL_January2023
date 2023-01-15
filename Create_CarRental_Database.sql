CREATE DATABASE CarRental

USE CarRental

CREATE TABLE Categories(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	CategoryName NVARCHAR(20) NOT NULL, 
	DailyRate MONEY NOT NULL, 
	WeeklyRate MONEY NOT NULL, 
	MonthlyRate MONEY NOT NULL, 
	WeekendRate MONEY NOT NULL
)

CREATE TABLE Cars(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	PlateNumber NCHAR(9) NOT NULL, 
	Manufacturer NVARCHAR(50) NOT NULL, 
	Model NVARCHAR(50) NOT NULL, 
	CarYear INT NOT NULL,
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id), 
	Doors INT NOT NULL, 
	Picture VARBINARY(MAX) NULL, 
	Condition NVARCHAR(10) NULL, 
	Available BIT NOT NULL
)

CREATE TABLE Employees(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	FirstName NVARCHAR(20) NOT NULL, 
	LastName NVARCHAR(20) NOT NULL, 
	Title NVARCHAR(20) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Customers(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	DriverLicenceNumber VARCHAR(14) NOT NULL, 
	FullName NVARCHAR(20) NOT NULL, 
	[Address] NVARCHAR(40) NOT NULL, 
	City NVARCHAR(30) NOT NULL,
	ZIPCode VARCHAR(6) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE RentalOrders(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(Id), 
	CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(Id), 
	CarId INT NOT NULL FOREIGN KEY REFERENCES Cars(Id), 
	TankLevel REAL NOT NULL, 
	KilometrageStart INT NOT NULL, 
	KilometrageEnd INT NOT NULL, 
	TotalKilometrage INT NOT NULL, 
	StartDate DATE NOT NULL, 
	EndDate DATE NOT NULL, 
	TotalDays INT NOT NULL, 
	RateApplied MONEY NOT NULL, 
	TaxRate FLOAT NOT NULL, 
	OrderStatus NVARCHAR(10) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

INSERT INTO Categories(CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate) VALUES
('Икономична', 8.00, 56.00, 224.00, 16.00),
('Нормална', 16.00, 112.00, 448.00, 36.00),
('Газарска', 24.00, 168.00, 672.00, 52.00)

INSERT INTO Cars(PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) VALUES
('E 2442 БX', 'Волгоградски автомобилен завод', 'Жигули', 1984, 1, 4, NULL, 'лошо', 1),
('E 7777 УИ', 'Волгоградски автомобилен завод', 'Москвич', 1981, 2, 4, NULL, 'добро', 1),
('С 1111 ЕЕ', 'Волгоградски автомобилен завод', 'Волга', 1989, 3, 4, NULL, 'перфектно', 1)

INSERT INTO Employees(FirstName, LastName, Title, Notes) VALUES
('Пешо', 'Чофърчето', 'таксиметров шофьор', NULL),
('Къчно', 'Муткодеров', 'шофьор-монтьор', NULL),
('Стойчо', 'Свинчото', 'тираджия', NULL)

INSERT INTO Customers(DriverLicenceNumber, FullName, [Address], City, ZIPCode, Notes) VALUES
(999666444, 'Пешо Тиквата', 'кв. Манастирски Ливади, 16', 'Чуричене', '1000', NULL),
(888666444, 'Мито Волгата', 'кв. Лозенец, бл. 37', 'Крънджилица', '1000', NULL),
(555666444, 'Динчо Тричката', 'кв. Надежда, бл. 111', 'Кърналово', '1000', NULL)


INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes) VALUES
(1, 1, 1, 66.50, 113200, 113300, 113301, '2022-11-11', '2022-11-13', 2, 8.00, 0.1, 'чакаща', NULL),
(2, 2, 2, 100.00, 110200, 110300, 110301, '2022-10-10', '2022-10-13', 3, 16.00, 0.1, 'приета', NULL),
(3, 3, 3, 20.00, 213200, 213300, 213301, '2022-12-11', '2022-12-13', 2, 52.00, 0.1, 'отказана', NULL)