CREATE TABLE Users(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Username NVARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(900) NULL,
	LastLoginTime DATETIME2 NULL,
	IsDeleted BIT NULL
)

INSERT INTO Users VALUES
(N'Пешо Ескюела', 'Tralala999', NULL, NULL, 0),
(N'Гошо Шарпа', 'Tralala888', NULL, NULL, 0),
(N'Митьо Голфа', 'Tralala777', NULL, NULL, 0),
(N'Врангел Тъпото', 'Tralala666', NULL, NULL, 0),
(N'Мутко Ебалсимайката', 'Tralala555', NULL, NULL, 0)