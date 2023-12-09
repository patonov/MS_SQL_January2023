drop database BankTransactions

go

CREATE DATABASE BankTransactions
GO

USE BankTransactions
GO

CREATE TABLE Accounts
(
    AccountId INT PRIMARY KEY, 
	[Name] VARCHAR (20),
	Balance MONEY,
	IsDeleted bit
)
GO
INSERT INTO Accounts (AccountId, [Name], Balance, IsDeleted) VALUES (1, 'Tom', 100, 0)
INSERT INTO Accounts (AccountId, [Name], Balance, IsDeleted) VALUES (2, 'Jerry', 50, 0)
GO

CREATE or alter TRIGGER tr_AccountProtect ON Accounts
INSTEAD OF DELETE
AS
UPDATE Accounts SET IsDeleted = 1
FROM Accounts AS a JOIN deleted AS d on a.AccountId = d.AccountId
WHERE a.IsDeleted = 0
SELECT * FROM deleted

go
DELETE FROM Accounts WHERE AccountId = 1
SELECT * FROM Accounts

