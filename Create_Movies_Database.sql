CREATE DATABASE Movies

USE [Movies]

CREATE TABLE Directors(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	DirectorName NVARCHAR(50) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Genres(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	GenreName NVARCHAR(20) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Categories (
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	CategoryName NVARCHAR(20) NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

CREATE TABLE Movies(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	Title NVARCHAR(MAX) NOT NULL, 
	DirectorId INT NOT NULL FOREIGN KEY REFERENCES Directors(Id), 
	CopyrightYear INT NOT NULL, 
	[Length] TIME NOT NULL,
	GenreId INT NOT NULL FOREIGN KEY REFERENCES Genres(Id), 
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id), 
	Rating FLOAT NOT NULL, 
	Notes NVARCHAR(MAX) NULL
)

INSERT INTO Directors(DirectorName, Notes) VALUES
('����� �����', NULL),
('����� ���������', NULL),
('������ �������', NULL),
('����� ��������', NULL),
('����� ����', NULL)

INSERT INTO Genres(GenreName, Notes) VALUES
('�����������', '!���� �� ���������'),
('����������', NULL),
('�����', NULL),
('������', NULL),
('�������', NULL)

INSERT INTO Categories(CategoryName, Notes) VALUES
('���������1', '����� 1989 �.'),
('���������2', '���� 1989 �.'),
('����������� ����', NULL),
('��������� ����', NULL),
('����', NULL)

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes) VALUES
('���������� �� ��������', 1, '1999', '02:05:00', 1, 4, 99.99, '����� ����'),
('������� 5', 3, '1996', '01:01:00', 3, 4, 55.13, '���� �� ������������ �����'),
('����� �������', 5, '2006', '03:02:44', 3, 5, 55.78, '����������������� ����� ����'),
('����� ���� � ��� ���� �����', 4, '1991', '00:45:17', 5, 3, 92.36, '���� ���� ����� ���� � ��������'),
('������ ������ 2 �����������', 2, '2000', '04:15:00', 4, 4, 09.10, '��� � ������ ���� - ����������, �� � ���������')
