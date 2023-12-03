create or alter function ufn_CalculateFutureValue(@sum decimal(18, 2), @int_rate float, @years int)
returns decimal(18, 4)
as
begin
	declare @fv decimal(18, 4);
	set @fv = @sum * power(1 + @int_rate, @years)
	return @fv
end
go

select dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
go

create or alter proc usp_CalculateFutureValueForAccount(@AccountId int, @ir float)
as
	select a.Id [Account Id], 
	ah.FirstName [First Name], 
	ah.LastName [Last Name], 
	a.Balance [Current Balance], 
	dbo.ufn_CalculateFutureValue(a.Balance, @ir, 5) as [Balance in 5 years] 
	from Accounts a join AccountHolders ah on a.AccountHolderId = ah.Id and a.Id = @AccountId
go

exec usp_CalculateFutureValueForAccount 1, 0.1