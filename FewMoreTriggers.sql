create table Logs (
	LogId int identity primary key, 
	AccountId int, 
	OldSum decimal(18, 2), 
	NewSum decimal(18, 2)
)

go

create or alter trigger tr_enter_new_logs
on Accounts for update
as
begin
		INSERT INTO Logs(AccountId, OldSum, NewSum)
        SELECT i.id, d.Balance AS OldSum, i.Balance AS NewSum
        FROM inserted AS i
        JOIN deleted AS d ON i.Id = d.Id

		select * from Logs where LogId = (select COUNT(*) from Logs)
end

update Accounts set Balance = 3333 where id = 22
select * from Logs

go

create table NotificationEmails(
	Id int identity primary key, 
	Recipient int, 
	[Subject] varchar(100), 
	Body varchar(100)
)
go

create or alter trigger tr_emailing_after_insert
on Logs for insert
as
begin
	insert into NotificationEmails(Recipient, [Subject], Body)
	select
		i.AccountId,
		concat_ws(' ', 'Balance change for account:', i.AccountId) as [Subject],
		concat('On ', cast(GETDATE() as date), ' your balance was changed from ', i.OldSum, ' to ', i.NewSum, '.')
	from inserted as i
end

update Accounts set Balance = 3333 where id = 20

select * from NotificationEmails