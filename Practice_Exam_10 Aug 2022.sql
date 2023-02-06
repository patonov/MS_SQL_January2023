CREATE DATABASE NationalTouristSitesOfBulgaria

USE NationalTouristSitesOfBulgaria

GO

CREATE TABLE Categories(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Locations(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	Municipality VARCHAR(50) NULL,
	Province VARCHAR(50) NULL,
)

CREATE TABLE Sites(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(100) NOT NULL,
	LocationId INT NOT NULL FOREIGN KEY REFERENCES Locations(Id),
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	Establishment VARCHAR(15) NULL
)

CREATE TABLE Tourists(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	Age INT NOT NULL CHECK(Age >= 0 AND Age <= 120),
	PhoneNumber VARCHAR(20) NOT NULL,
	Nationality VARCHAR(30) NOT NULL,
	Reward VARCHAR(20) NULL
)

CREATE TABLE SitesTourists(
	TouristId INT NOT NULL FOREIGN KEY REFERENCES Tourists(Id),
	SiteId INT NOT NULL FOREIGN KEY REFERENCES Sites(Id),
	CONSTRAINT PK_SitesTourists PRIMARY KEY(TouristId, SiteId)
)

CREATE TABLE BonusPrizes(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE TouristsBonusPrizes(
	TouristId INT NOT NULL FOREIGN KEY REFERENCES Tourists(Id),
	BonusPrizeId INT NOT NULL FOREIGN KEY REFERENCES BonusPrizes(Id),
	CONSTRAINT PK_TouristsBonusPrizes PRIMARY KEY(TouristId, BonusPrizeId)
)

GO

INSERT INTO Tourists([Name], Age, PhoneNumber, Nationality, Reward) VALUES
('Borislava Kazakova', 52, '+359896354244', 'Bulgaria', NULL),
('Peter Bosh', 48, '+447911844141',	'UK', NULL),
('Martin Smith', 29, '+353863818592', 'Ireland', 'Bronze badge'),
('Svilen Dobrev', 49, '+359986584786', 'Bulgaria', 'Silver badge'),
('Kremena Popova', 38, '+359893298604', 'Bulgaria',	NULL)

INSERT INTO Sites([Name], LocationId, CategoryId, Establishment) VALUES
('Ustra fortress', 90, 7, 'X'),
('Karlanovo Pyramids', 65, 7, NULL),
('The Tomb of Tsar Sevt', 63, 8, 'V BC'),
('Sinite Kamani Natural Park', 17, 1, NULL),
('St. Petka of Bulgaria – Rupite', 92, 6, '1994')

UPDATE Sites SET Establishment = '(not defined)' WHERE Establishment IS NULL

SELECT [Name], Age, PhoneNumber, Nationality
FROM Tourists 
ORDER BY Nationality ASC, Age DESC, [Name] ASC


SELECT 
	s.[Name] AS [Site],
	l.[Name] AS [Location],	
	s.Establishment,
	c.[Name] AS [Category]
FROM Sites AS s
JOIN Locations AS l ON s.LocationId = l.Id
JOIN Categories AS c ON s.CategoryId = c.Id
ORDER BY c.[Name] DESC, l.[Name] ASC, s.[Name] ASC

SELECT
	 l.Province,
	 l.Municipality,
	 l.[Name] AS [Location],
	COUNT(s.Id) AS [CountOfSites] 
FROM Sites AS s
INNER JOIN Locations AS l ON s.LocationId = l.Id 
GROUP BY l.Province, l.Municipality, l.[Name]
HAVING l.Province = 'Sofia'
ORDER BY COUNT(s.Id) DESC, l.[Name]

SELECT
	 s.[Name] AS [Site],
	 l.[Name] AS [Location],
	 l.Municipality,
	 l.Province,
	 s.Establishment
FROM Sites AS s
INNER JOIN Locations AS l ON s.LocationId = l.Id
WHERE LEFT(l.[Name], 1) NOT IN ('B', 'M', 'D') AND s.Establishment LIKE '%BC'
ORDER BY s.[Name] ASC

SELECT
	t.[Name],
	Age,
	PhoneNumber,
	Nationality,
	ISNULL(bp.[Name], '(no bonus prize)') AS [BonusPrize]
FROM Tourists AS t
LEFT JOIN TouristsBonusPrizes AS tbp ON t.Id = tbp.TouristId
LEFT JOIN BonusPrizes AS bp ON bp.Id = tbp.BonusPrizeId
ORDER BY t.[Name] ASC

SELECT SUBSTRING(t.Name, CHARINDEX(' ', t.Name) + 1, LEN(t.Name)) AS 'LastName', 
	t.Nationality, t.Age, t.PhoneNumber
FROM Tourists AS t
JOIN SitesTourists AS st ON st.TouristId = t.Id
JOIN Sites AS s ON s.Id = st.SiteId
JOIN Categories AS c ON c.Id = s.CategoryId
WHERE c.Name = 'History and archaeology'
GROUP BY t.Name, t.Nationality, t.Age, t.PhoneNumber
ORDER BY LastName

GO

CREATE FUNCTION udf_GetTouristsCountOnATouristSite (@Site VARCHAR(100))
RETURNS INT
AS
BEGIN
	DECLARE @Visited INT
	SET @Visited =
	(SELECT COUNT(t.[Name]) FROM Tourists AS t 
	JOIN SitesTourists AS st ON t.Id = st.TouristId
	JOIN Sites AS s ON s.Id = st.SiteId
	GROUP BY s.[Name]
	HAVING s.Name = @Site)

	RETURN @Visited
END

GO

CREATE OR ALTER PROCEDURE usp_AnnualRewardLottery(@TouristName VARCHAR(50))
AS
BEGIN
	DECLARE @SitesOfTouristVisited INT
	SET @SitesOfTouristVisited = (SELECT COUNT(s.Id) FROM Sites AS s
			JOIN SitesTourists AS st ON s.Id = st.SiteId
			JOIN Tourists AS t ON st.TouristId = t.Id
			WHERE t.Name = @TouristName)
	
	IF @SitesOfTouristVisited >= 100
	BEGIN
	UPDATE Tourists SET Reward = 'Gold badge' WHERE [Name] = @TouristName
	END
	ELSE IF @SitesOfTouristVisited >= 50 
	BEGIN
	UPDATE Tourists SET Reward = 'Silver badge' WHERE [Name] = @TouristName
	END
	ELSE IF @SitesOfTouristVisited >= 25
	BEGIN
	UPDATE Tourists SET Reward = 'Bronze badge' WHERE [Name] = @TouristName
	END

	SELECT [Name], Reward FROM Tourists WHERE [Name] = @TouristName
END

GO

EXEC usp_AnnualRewardLottery 'Gerhild Lutgard'

GO

DELETE FROM TouristsBonusPrizes WHERE [BonusPrizeId] = 5
DELETE FROM BonusPrizes WHERE [Name] = 'Sleeping bag'

