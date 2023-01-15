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
('����', '������', '��������', '����� �, �����'),
('�����', '�����', '��������', '������� �� ����'),
('����', '��������', '��������', '������ ����, �� �� ���')

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes) VALUES
('BG17FIN0V1441TFJT', '����', '�������', '0899091071', '�������', '112', '��������� ��������� - ��� ���� ���� � �������'),
('BG17FIN0V3334TFJT', '���������', '������', '0888091021', '�������', '112', '������ ����� - �������� � ��������, ������'),
('BG17FIN0V1111TFJT', '��� �����', '�������', '0799111973', '����� �����', '112', '����� ��� �����, ������ �� � �� ��������')

INSERT INTO RoomStatus (RoomStatus, Notes) VALUES
('�����', NULL),
('��������', NULL),
('� ������', NULL)

INSERT INTO RoomTypes (RoomType, Notes) VALUES
('� ���� �����', NULL),
('� ��� �����', NULL),
('���������', NULL)

INSERT INTO BedTypes (BedType, Notes) VALUES
('�����', NULL),
('������', NULL),
('�������', NULL)

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus, Notes) VALUES
('� ���� �����', '�����', 100.50, '��������', '������� �� ���������� �� �� �������.'),
('� ���� �����', '������', 50.50, '��������', '�������� �������� � ������.'),
('���������', '�������', 400.50, '��������', '����� ������� ���� ��������.')

INSERT INTO Payments (EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes) VALUES
(1, '2022-01-17', 'BG17FIN0V1441TFJT', '2022-01-16', '2022-01-17', 1, 100.50, 0.10, 10.05, 110.55, NULL),
(2, '2022-12-30', 'BG17FIN0V3334TFJT', '2022-12-29', '2022-12-30', 1, 50.50, 0.10, 5.05, 55.55, NULL),
(3, '2022-01-02', 'BG17FIN0V1111TFJT', '2022-01-01', '2022-01-02', 1, 400.50, 0.10, 40.05, 440.55, NULL)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes) VALUES
(1, '2022-01-16', 'BG17FIN0V1441TFJT', 1, 100.50, 0.00, N'������ ������ ������ ������.'),
(1, '2022-12-29', 'BG17FIN0V3334TFJT', 2, 50.50, 0.02, N'������ �����������.'),
(1, '2022-01-01', 'BG17FIN0V1111TFJT', 3, 400.50, 10.22, N'���� ��� ���� ����.')