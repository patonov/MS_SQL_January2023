create or alter procedure usp_SendMoney(@senderAccountId int, @receiverAccountId int, @amount money)
as
begin transaction

	declare @senderAccount int = (select AccountId from Accounts where AccountId = @senderAccountId)
	declare @receiverAccount int = (select AccountId from Accounts where AccountId = @receiverAccountId)
	
	if (@senderAccount is null or @receiverAccount is null)
	begin
		rollback
		raiserror('Account doesn''t exist!', 16, 1)
		return
	end
	
	declare @availability money = (select Balance from Accounts where AccountId = @senderAccountId)

	if (@availability - @amount < 0)
	begin
		rollback
		raiserror('Insufficient funds!', 16, 2)
		return
	end

	update Accounts set Balance = Balance - @amount where AccountId = @senderAccountId
	update Accounts set Balance = Balance + @amount where AccountId = @receiverAccountId

commit

select * from Accounts
EXECUTE usp_SendMoney 2, 1, 40