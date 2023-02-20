CREATE DATABASE Boardgames

USE Boardgames

CREATE TABLE Categories(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	StreetName NVARCHAR(100) NOT NULL,
	StreetNumber INT NOT NULL,
	Town VARCHAR(30) NOT NULL,
	Country VARCHAR(50) NOT NULL,
	ZIP INT NOT NULL
)

CREATE TABLE Publishers(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(30) NOT NULL UNIQUE,
	AddressId INT NOT NULL FOREIGN KEY REFERENCES Addresses(Id),
	Website NVARCHAR(40) NULL,
	Phone NVARCHAR(20) NULL
)

CREATE TABLE PlayersRanges(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	PlayersMin INT NOT NULL,
	PlayersMax INT NOT NULL
)

CREATE TABLE Boardgames(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	[Name] VARCHAR(30) NOT NULL,
	YearPublished INT NOT NULL,
	Rating DECIMAL(18, 2) NOT NULL,
	CategoryId INT NOT NULL FOREIGN KEY REFERENCES Categories(Id),
	PublisherId INT NOT NULL FOREIGN KEY REFERENCES Publishers(Id),
	PlayersRangeId INT NOT NULL FOREIGN KEY REFERENCES PlayersRanges(Id)
)

CREATE TABLE Creators(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Email NVARCHAR(30) NOT NULL
)

CREATE TABLE CreatorsBoardgames(
	CreatorId INT NOT NULL FOREIGN KEY REFERENCES Creators(Id),
	BoardgameId INT NOT NULL FOREIGN KEY REFERENCES Boardgames(Id),
	CONSTRAINT PK_CreatorsBoardgames PRIMARY KEY(CreatorId, BoardgameId)
)


INSERT INTO Boardgames([Name], YearPublished, Rating, CategoryId, PublisherId, PlayersRangeId) VALUES
('Deep Blue', 2019, 5.67, 1, 15, 7),
('Paris', 2016, 9.78, 7, 1, 5),
('Catan: Starfarers', 2021, 9.87, 7, 13, 6),
('Bleeding Kansas', 2020, 3.25,	3, 7, 4),
('One Small Step', 2019, 5.75, 5, 9, 2)

INSERT INTO Publishers([Name], AddressId, Website, Phone) VALUES
('Agman Games',	5,	'www.agmangames.com', '+16546135542'),
('Amethyst Games',	7,	'www.amethystgames.com', '+15558889992'),
('BattleBooks', 13,	'www.battlebooks.com', '+12345678907')


UPDATE PlayersRanges SET PlayersMax = PlayersMax + 1 WHERE Id = 1
UPDATE Boardgames SET [Name] = CONCAT([Name], 'V2') WHERE YearPublished >= 2020



--alter table Publishers WITH CHECK ADD CONSTRAINT [FK_PublishersAddresses] FOREIGN KEY([AddressId])REFERENCES Addresses([Id]) ON DELETE CASCADE
--alter table Boardgames drop CONSTRAINT [FK_Boardgames_Publishers]
--alter table Boardgames WITH CHECK ADD CONSTRAINT [FK_Boardgames_Publishers] FOREIGN KEY([PublisherId])REFERENCES Publishers([Id]) ON DELETE CASCADE
--DELETE FROM Addresses WHERE Town LIKE 'L%'
 
 

select [Name], Rating from Boardgames
order by YearPublished asc, [Name] desc

select 
b.Id, 
b.[Name], 
b.YearPublished,
c.Name as CategoryName 
from Boardgames as b
join Categories as c on b.CategoryId = c.Id
where c.Name in ('Strategy Games', 'Wargames')
order by b.YearPublished desc

select 
c.Id,	
concat(c.FirstName, ' ', c.LastName) as CreatorName,
c.Email
from Creators as c
left join CreatorsBoardgames as cb on c.Id = cb.CreatorId
left join Boardgames as b on b.Id = cb.BoardgameId
where b.[Name] is null
order by CreatorName asc

select top 5
b.[Name],
Rating,
c.[Name] as CategoryName
from Boardgames as b
join Categories as c on b.CategoryId = c.Id
where (Rating > 7.00 and b.[Name] like '%a%') or (Rating > 7.50 and PlayersRangeId = 4)
order by b.[Name] asc, Rating desc

SELECT
ehe.FullName,
ehe.Email,
ehe.Rating
FROM
(select
	c.Id,	
	concat(c.FirstName, ' ', c.LastName) as FullName,
	c.Email,
	b.Rating,
	RANK() OVER (PARTITION BY concat(c.FirstName, ' ', c.LastName) ORDER BY b.Rating DESC) AS [rankkk]
from Creators as c
join CreatorsBoardgames as cb on c.Id = cb.CreatorId
join Boardgames as b on b.Id = cb.BoardgameId
group by concat(c.FirstName, ' ', c.LastName), c.Id, c.Email, b.Rating
having c.Email like '%.com') AS ehe
WHERE [rankkk] = 1

select ehe.LastName, ceiling(ehe.AverageRating), ehe.PublisherName from (
select 
c.LastName as LastName,
avg(b.Rating) as AverageRating,
p.[Name] as PublisherName
from Creators as c
join CreatorsBoardgames as cb on c.Id = cb.CreatorId
join Boardgames as b on b.Id = cb.BoardgameId
join Publishers as p on p.Id = b.PublisherId
group by c.LastName, p.[Name]
having p.[Name] = 'Stonemaier Games') as ehe
order by ehe.AverageRating desc

GO

create function udf_CreatorWithBoardgames(@name NVARCHAR(30))
returns int
as
begin
	DECLARE @Number INT
	SET @Number = (SELECT 
					COUNT(b.Id) 
					from Creators as c
					join CreatorsBoardgames as cb on c.Id = cb.CreatorId
					join Boardgames as b on b.Id = cb.BoardgameId
					WHERE c.FirstName = @name
					)
	RETURN @Number
end

GO

SELECT dbo.udf_CreatorWithBoardgames('Bruno')

GO

CREATE PROCEDURE usp_SearchByCategory(@category VARCHAR(50))
AS
BEGIN
	SELECT 
	b.[Name], 
	b.YearPublished, 
	b.Rating, 
	c.[Name] as CategoryName, 
	p.[Name] as PublisherName, 
	CONCAT(pr.PlayersMin, ' ', 'people') as MinPlayers,
	CONCAT(pr.PlayersMax , ' ', 'people') as MaxPlayers
	FROM Boardgames AS b
	JOIN Categories AS c ON b.CategoryId = c.Id
	JOIN Publishers AS p ON b.PublisherId = p.Id
	JOIN PlayersRanges AS pr ON b.PlayersRangeId = pr.Id
	WHERE c.[Name] = @category
	ORDER BY PublisherName ASC, YearPublished DESC

END

GO

EXEC usp_SearchByCategory 'Wargames'









