SELECT * FROM Minions

INSERT INTO Minions(Id, [Name], Age, TownId) VALUES
(1, 'Kevin', 22, 1),
(2,	'Bob',	15,	3),
(3,	'Steward', NULL, 2)

INSERT INTO Towns (Id, [Name]) VALUES
(1,	'Sofia'),
(2,	'Plovdiv'),
(3,	'Varna')

CREATE TABLE People(
Id INT NOT NULL IDENTITY UNIQUE,
Name NVARCHAR(200) NOT NULL,
Picture VARBINARY(MAX) NULL,
Height FLOAT NULL,
Weight FLOAT NULL,
Gender CHAR(1) NOT NULL,
Birthdate DATETIME2 NOT NULL,
Biography NVARCHAR(MAX) NULL,
CONSTRAINT PK_PeopleID PRIMARY KEY(Id)
)

INSERT INTO People VALUES
(N'Пешо Ескюела', NULL, 1.61, 99.11, 'M', '1997-12-01', NULL),
(N'Гошо Шарпа', NULL, 1.71, 110.31, 'M', '1966-12-01', NULL),
(N'Митьо Голфа', NULL, 1.81, 60.12, 'M', '1988-12-01', NULL),
(N'Врангел Тъпото', NULL, 1.91, 72.20, 'M', '1993-12-01', NULL),
(N'Мутко Ебалсимайката', NULL, 1.99, 89.20, 'M', '1987-12-01', NULL)

SELECT * FROM People