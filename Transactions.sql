USE Bank

go

CREATE PROCEDURE usp_DepositMoney(@AccountId INT, @MoneyAmount MONEY)
AS
BEGIN TRANSACTION

UPDATE Accounts
SET Balance += @MoneyAmount
WHERE Id = @AccountId

COMMIT

go

CREATE PROCEDURE usp_WithdrawMoney (@AccountId INT, @MoneyAmount MONEY)
AS
BEGIN TRANSACTION
	UPDATE Accounts
    SET Balance -= @MoneyAmount
	WHERE Id = @AccountId
	DECLARE @LeftBalance MONEY = (SELECT Balance FROM Accounts WHERE Id = @AccountId)
	IF(@LeftBalance < 0)
	  BEGIN
		  ROLLBACK
		  RAISERROR('',16,2)
		  RETURN
	  END
COMMIT

go

CREATE PROC usp_TransferMoney(@SenderId INT, @ReceiverId INT, @Amount MONEY)
AS
BEGIN TRANSACTION
	EXEC usp_DepositMoney @ReceiverId, @Amount
	EXEC usp_WithdrawMoney @SenderId, @Amount
COMMIT