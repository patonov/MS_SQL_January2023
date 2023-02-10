CREATE DATABASE CigarShop

USE CigarShop

CREATE TABLE Sizes(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Length] INT NOT NULL CHECK([Length] >= 10 AND [Length] <= 25),
	RingRange DECIMAL(18, 2) NOT NULL CHECK(RingRange >= 1.5 AND RingRange <= 7.5)
)

CREATE TABLE Tastes(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	TasteType VARCHAR(20) NOT NULL,
	TasteStrength VARCHAR(15) NOT NULL,
	ImageURL NVARCHAR(100) NOT NULL,
)

CREATE TABLE Brands(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	BrandName VARCHAR(30) NOT NULL UNIQUE,
	BrandDescription VARCHAR(MAX) NULL
)

CREATE TABLE Cigars(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	CigarName VARCHAR(80) NOT NULL,
	BrandId INT NOT NULL FOREIGN KEY REFERENCES Brands(Id),
	TastId INT NOT NULL FOREIGN KEY REFERENCES Tastes(Id),
	SizeId INT NOT NULL FOREIGN KEY REFERENCES Sizes(Id),
	PriceForSingleCigar DECIMAL(18, 2) NOT NULL,
	ImageURL NVARCHAR(100) NOT NULL
)

CREATE TABLE Addresses(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Town VARCHAR(30) NOT NULL,
	Country NVARCHAR(30) NOT NULL,
	Streat NVARCHAR(100) NOT NULL,
	ZIP VARCHAR(20) NOT NULL
)

CREATE TABLE Clients(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	AddressId INT NOT NULL FOREIGN KEY REFERENCES Addresses(Id)
)

CREATE TABLE ClientsCigars(
	ClientId INT NOT NULL FOREIGN KEY REFERENCES Clients(Id),
	CigarId INT NOT NULL FOREIGN KEY REFERENCES Cigars(Id),
	CONSTRAINT PK_ClientsCigars PRIMARY KEY(ClientId, CigarId)
)

INSERT INTO Cigars(CigarName, BrandId, TastId, SizeId, PriceForSingleCigar, ImageURL) VALUES
('COHIBA ROBUSTO', 9, 1, 5,	15.50, 'cohiba-robusto-stick_18.jpg'),
('COHIBA SIGLO I', 9, 1, 10, 410.00, 'cohiba-siglo-i-stick_12.jpg'),
('HOYO DE MONTERREY LE HOYO DU MAIRE', 14, 5, 11, 7.50, 'hoyo-du-maire-stick_17.jpg'),
('HOYO DE MONTERREY LE HOYO DE SAN JUAN', 14, 4, 15, 32.00, 'hoyo-de-san-juan-stick_20.jpg'),
('TRINIDAD COLONIALES', 2, 3, 8, 85.21, 'trinidad-coloniales-stick_30.jpg')

INSERT INTO Addresses(Town, Country, Streat, ZIP) VALUES
('Sofia', 'Bulgaria', '18 Bul. Vasil levski', '1000'),
('Athens',	'Greece', '4342 McDonald Avenue', '10435'),
('Zagreb', 'Croatia', '4333 Lauren Drive', '10000')

UPDATE Cigars SET PriceForSingleCigar = PriceForSingleCigar * 1.2 WHERE TastId = 1
UPDATE Brands SET BrandDescription = 'New description' WHERE BrandDescription IS NULL

ALTER TABLE Clients DROP constraint FK__Clients__Address__33D4B598
DELETE FROM Addresses WHERE Country LIKE 'C%'

SELECT
	CigarName,
	PriceForSingleCigar,
	ImageURL
FROM Cigars
ORDER BY PriceForSingleCigar ASC, CigarName DESC

SELECT
	c.Id,
	c.CigarName,
	c.PriceForSingleCigar,
	TasteType,
	TasteStrength
FROM Cigars AS c
JOIN Tastes AS t ON c.TastId = t.Id
WHERE t.TasteType IN ('Earthy', 'Woody')
ORDER BY PriceForSingleCigar DESC

go

SELECT
	c.Id,
	CONCAT(c.[FirstName], ' ', c.[LastName]) AS ClientName,
	c.Email
FROM Clients AS c
LEFT OUTER JOIN ClientsCigars AS cc ON cc.ClientId = c.Id
WHERE cc.CigarId IS NULL
ORDER BY ClientName ASC

SELECT top 5
CigarName, PriceForSingleCigar, ImageURL 
FROM Cigars AS ci
JOIN Sizes AS sz ON ci.SizeId = sz.Id
WHERE sz.[Length] >= 12 AND (ci.CigarName LIKE '%ci%' OR ci.PriceForSingleCigar > 50) AND sz.RingRange > 2.55
ORDER BY ci.CigarName, ci.PriceForSingleCigar DESC


SELECT ehe.ClientName, ehe.Country, ehe.ZIP, CONCAT('$', ehe.PriceForSingleCigar) AS CigarPrice
FROM
	(SELECT
		CONCAT(cl.[FirstName], ' ', cl.[LastName]) AS ClientName,
		Country,
		a.ZIP,
		ci.PriceForSingleCigar,
		RANK() OVER (PARTITION BY CONCAT(cl.[FirstName], ' ', cl.[LastName]) ORDER BY ci.PriceForSingleCigar DESC) AS [rankkk]
	FROM Clients AS cl
	JOIN ClientsCigars AS cc ON cl.Id = cc.ClientId
	JOIN Addresses as a ON cl.AddressId = a.Id
	JOIN Cigars AS ci ON cc.CigarId = ci.Id
	GROUP BY CONCAT(cl.[FirstName], ' ', cl.[LastName]), a.Country, a.ZIP, ci.PriceForSingleCigar
	HAVING a.ZIP NOT LIKE '%[A-Z]%') AS ehe 
WHERE [rankkk] = 1


SELECT
	cl.LastName,
	AVG(sz.[Length]) AS CiagrLength,
	CEILING(avg(sz.RingRange)) AS CiagrRingRange
FROM Clients AS cl
JOIN ClientsCigars AS cc ON cl.Id = cc.ClientId
JOIN Cigars AS c ON cc.CigarId = c.Id
JOIN Sizes AS sz ON c.SizeId = sz.Id
GROUP BY cl.LastName
ORDER BY CiagrLength DESC

GO

CREATE or alter FUNCTION udf_ClientWithCigars(@name NVARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @NameLookedFor NVARCHAR(30) = @name
	DECLARE @Count INT
	
	set @Count = (SELECT count(cc.CigarId) 
	FROM Clients AS cl JOIN ClientsCigars AS cc ON cl.Id = cc.ClientId	
	GROUP BY cl.FirstName having FirstName = @NameLookedFor)

	IF @Count IS NULL
	BEGIN
	SET @Count = 0
	END

	return @Count
END

GO

SELECT dbo.udf_ClientWithCigars('Betty')

GO

CREATE PROCEDURE usp_SearchByTaste(@taste VARCHAR(20))
AS
BEGIN
	SELECT 
		ci.CigarName, 
		CONCAT('$', ci.PriceForSingleCigar) AS Price, 
		ta.TasteType, 
		br.BrandName, 
		CONCAT(sz.[Length], 'cm') AS CigarLength, 
		CONCAT(sz.RingRange, 'cm') AS CigarRingRange
	FROM Cigars AS ci
	JOIN Tastes AS ta ON ci.TastId = ta.Id
	JOIN Brands AS br ON ci.BrandId = br.Id
	JOIN Sizes AS sz ON ci.SizeId = sz.Id
	GROUP BY ta.TasteType, ci.CigarName, ci.PriceForSingleCigar, br.BrandName, sz.[Length], sz.RingRange
	HAVING ta.TasteType = @taste
	ORDER BY CigarLength asc, CigarRingRange desc
END

GO

EXEC usp_SearchByTaste 'Woody'