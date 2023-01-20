CREATE DATABASE TableRelationsDemoBD

USE TableRelationsDemoBD

-- 1.One-To-One Relationship

CREATE TABLE Passports(
	PassportID INT NOT NULL IDENTITY(101, 1),
	PassportNumber CHAR(8) NOT NULL UNIQUE
)

ALTER TABLE Passports
ADD CONSTRAINT PK_Passport PRIMARY KEY(PassportID)

CREATE TABLE Persons(
	PersonID INT NOT NULL IDENTITY PRIMARY KEY,
	FirstName VARCHAR(MAX) NOT NULL,
	Salary FLOAT NOT NULL,
	PassportID INT NOT NULL UNIQUE
)

ALTER TABLE Persons
ADD FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)

GO

--02.One-To-Many Relationship

CREATE TABLE Manufacturers(
	ManufacturerID INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,	
	EstablishedOn DATETIME2 NOT NULL
)

CREATE TABLE Models(
	ModelID INT NOT NULL IDENTITY(101, 1) PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	ManufacturerID INT NOT NULL FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

--3.Many-To-Many Relationship

CREATE TABLE Students(
	StudentID INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50)
)

CREATE TABLE Exams(
	ExamID INT NOT NULL IDENTITY(101, 1) PRIMARY KEY,
	[Name] VARCHAR(50)
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID),
	ExamID INT NOT NULL FOREIGN KEY REFERENCES Exams(ExamID),
	CONSTRAINT PK_StudentsExams PRIMARY KEY(StudentID, ExamID)
)

--4.Self-Referencing
CREATE TABLE Teachers(
	TeacherID INT NOT NULL IDENTITY(101, 1) PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	ManagerID INT NOT NULL FOREIGN KEY REFERENCES Teachers(TeacherID)
)


--09. *Peaks in Rila

USE Geography

SELECT m.MountainRange, p.PeakName, p.Elevation, mc.CountryCode, c.CountryName
FROM Mountains AS m 
JOIN Peaks AS p ON p.MountainId = m.Id
JOIN MountainsCountries AS mc ON mc.MountainId = m.Id
JOIN Countries AS c ON mc.CountryCode = c.CountryCode
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC





