CREATE TABLE Users(
	Id INT NOT NULL IDENTITY PRIMARY KEY,
	Username NVARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(900) NULL,
	LastLoginTime DATETIME2 NULL,
	IsDeleted BIT NULL
)

INSERT INTO Users VALUES
(N'���� �������', 'Tralala999', NULL, NULL, 0),
(N'���� �����', 'Tralala888', NULL, NULL, 0),
(N'����� �����', 'Tralala777', NULL, NULL, 0),
(N'������� ������', 'Tralala666', NULL, NULL, 0),
(N'����� �������������', 'Tralala555', NULL, NULL, 0)