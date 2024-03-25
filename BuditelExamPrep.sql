CREATE DATABASE ActiveVolcanoes

CREATE TABLE [Location](
	Id INT IDENTITY PRIMARY KEY, 
	Country VARCHAR(77) NOT NULL, 
	Volcanoes INT
)

CREATE TABLE Volcanoes (
	Id INT IDENTITY PRIMARY KEY, 
	[Name] VARCHAR(133) NOT NULL, 
	LocationId INT NOT NULL,
	Height INT,
	CONSTRAINT FK_Volcanoes_Locations foreign key (LocationId) references [Location](Id)
)

INSERT INTO [Location] VALUES
('Argentina', 57),
('Ecuador', 47),
('Russia', 192)

INSERT INTO Volcanoes VALUES
('Antofalla', 1, 6450),
('Cotopaxi', 2,	5897),
('Guallatiri', 1, 6060),
('Sangay', 2, 5320),
('Kluchevskaya', 3, 4850)

SELECT v.[Name] FROM Volcanoes AS v
JOIN [Location] AS l ON v.LocationId = l.Id
WHERE l.Country = 'Argentina'

SELECT 
	l.Id,
	l.Country,
	l.Volcanoes,
	v.Id,
	v.Name,
	v.LocationId,
	v.Height
FROM Volcanoes AS v
JOIN [Location] AS l ON v.LocationId = l.Id
WHERE v.Height < 6000