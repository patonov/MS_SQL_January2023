CREATE DATABASE Airport

USE Airport

CREATE TABLE Passengers(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	FullName VARCHAR(100) NOT NULL,
	Email VARCHAR(50) NOT NULL
)

CREATE TABLE Pilots(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Age TINYINT CHECK(Age >= 21 AND Age <= 62) NOT NULL,
	Rating FLOAT CHECK(Rating >= 0.0 AND Rating <= 10.0) NULL
)

CREATE TABLE AircraftTypes(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	TypeName VARCHAR(30) NOT NULL
)

CREATE TABLE Aircraft(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	Manufacturer VARCHAR(25) NOT NULL,
	Model VARCHAR(30) NOT NULL,
	[Year] INT NOT NULL,
	FlightHours INT NULL,
	Condition CHAR(1) NOT NULL,
	TypeId INT NOT NULL FOREIGN KEY REFERENCES AircraftTypes(Id)
)

CREATE TABLE PilotsAircraft(
	AircraftId INT NOT NULL FOREIGN KEY REFERENCES Aircraft(Id),
	PilotId INT NOT NULL FOREIGN KEY REFERENCES Pilots(Id),
	CONSTRAINT PK_PilotsAircraft PRIMARY KEY(AircraftId, PilotId)
)

CREATE TABLE Airports(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	AirportName VARCHAR(70) NOT NULL,
	Country VARCHAR(100) NOT NULL
)

CREATE TABLE FlightDestinations(
	Id INT NOT NULL IDENTITY PRIMARY KEY, 
	AirportId INT NOT NULL FOREIGN KEY REFERENCES Airports(Id),
	[Start] DATETIME NOT NULL,
	AircraftId INT NOT NULL FOREIGN KEY REFERENCES Aircraft(Id),
	PassengerId INT NOT NULL FOREIGN KEY REFERENCES Passengers(Id),
	TicketPrice DECIMAL(18, 2) NOT NULL DEFAULT 15.00
)

INSERT INTO Passengers([FullName], [Email])
SELECT 
	CONCAT(FirstName, ' ', LastName) AS [FullName],
	CONCAT(FirstName, LastName, '@gmail.com') AS [Email]
FROM Pilots WHERE Id BETWEEN 5 AND 15

UPDATE Aircraft SET Condition = 'A' WHERE (Condition = 'C' OR Condition = 'B') AND (FlightHours IS NULL OR FlightHours <= 100) AND [Year] >= 2013

DELETE FROM Passengers WHERE LEN(FullName) <= 10

SELECT 
	Manufacturer,
	Model,
	FlightHours,
	Condition
FROM Aircraft
ORDER BY FlightHours DESC

SELECT FirstName, LastName,	Manufacturer, Model, FlightHours
FROM Pilots AS p
JOIN PilotsAircraft AS ac ON p.Id = ac.PilotId
JOIN Aircraft AS a ON a.Id = ac.AircraftId
WHERE a.FlightHours IS NOT NULL AND a.FlightHours < 304
ORDER BY a.FlightHours DESC, FirstName ASC

GO

SELECT top 20
	fd.Id AS [DestinationId],
	fd.[Start],
	p.FullName,
	a.AirportName,
	fd.TicketPrice
FROM FlightDestinations AS fd
JOIN Airports AS a ON fd.AirportId = a.Id
JOIN Passengers AS p ON p.Id = fd.PassengerId
WHERE DAY(fd.[Start]) % 2 = 0
ORDER BY TicketPrice DESC, a.AirportName ASC

SELECT 
	fd.AircraftId,
	a.Manufacturer,
	a.FlightHours,
	COUNT(fd.AircraftId) AS FlightDestinationsCount,
	ROUND(AVG(fd.TicketPrice), 2) AS AvgPrice
FROM Aircraft AS a
JOIN FlightDestinations AS fd ON a.Id = fd.AircraftId 
GROUP BY fd.AircraftId, a.Manufacturer, a.FlightHours
HAVING COUNT(fd.AircraftId) >= 2
ORDER BY COUNT(fd.AircraftId) DESC, fd.AircraftId

SELECT 
	FullName,
	COUNT(fd.AircraftId) AS CountOfAircraft,
	SUM(fd.TicketPrice) AS TotalPayed
FROM Passengers AS p
JOIN FlightDestinations AS fd ON fd.PassengerId = p.Id
GROUP BY FullName
HAVING SUBSTRING(FullName, 2, 1) = 'a' AND COUNT(fd.AircraftId) > 1
ORDER BY FullName
