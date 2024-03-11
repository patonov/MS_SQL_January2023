CREATE DATABASE JournalsIndexationDB

GO

USE JournalsIndexationDB

GO

CREATE TABLE Publishers (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(38) NOT NULL,
	Country VARCHAR(22) NOT NULL,
	Town VARCHAR(30) NOT NULL,
	[Address] VARCHAR(40)
)

CREATE TABLE Journals (
	Id INT PRIMARY KEY IDENTITY,
	Title VARCHAR(88) NOT NULL,
	Topics VARCHAR(224) NOT NULL,
	ISSN_print NCHAR(9),
	ISSN_online NCHAR(9),
	StartedOn DATE NOT NULL,
	[Language] VARCHAR(28) NOT NULL,
	HasSecondLanguage BIT NOT NULL,
	HasEditorialBoard BIT NOT NULL,
	PublisherId INT NOT NULL FOREIGN KEY REFERENCES Publishers(Id),
	AverageAssessment DECIMAL(18, 2) NOT NULL
)

CREATE TABLE Indexations (
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(33) NOT NULL
)

CREATE TABLE JournalsIndexations (
	JournalId INT NOT NULL FOREIGN KEY REFERENCES Journals(Id),
	IndexationId INT NOT NULL FOREIGN KEY REFERENCES Indexations(Id),
	CONSTRAINT PK_JournalsIndexations PRIMARY KEY (JournalId, IndexationId)
)

CREATE TABLE Issues (
	Id INT PRIMARY KEY IDENTITY,
	Number INT NOT NULL,
	[Year] CHAR(4) NOT NULL,
	JournalId INT NOT NULL UNIQUE,
	AuthorsPublished INT NOT NULL,
	ArticlesPublished INT NOT NULL,
	ExternalAuthors INT NOT NULL,
	NonNativeAuthors INT NOT NULL,
	IsSpecialIssue BIT NOT NULL,
	IndividualAssessment DECIMAL(18, 2) NOT NULL
	CONSTRAINT FK_Issues_Journals FOREIGN KEY(JournalId) REFERENCES Journals(Id)
)

