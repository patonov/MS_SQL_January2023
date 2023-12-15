CREATE or alter TRIGGER reminder
ON Accounts  
AFTER INSERT, UPDATE   
AS 
select * from Accounts where AccountId = (select count(*) from Accounts)
GO

insert into Accounts(AccountId, NAME, Balance) values (8, 'Urungel', 1000)

update Accounts
set Balance = 1200 where NAME = 'Urungel'

select * from Accounts

go

drop trigger reminder
go

CREATE or alter TRIGGER reminder_printer
ON Accounts  
AFTER INSERT, UPDATE, DELETE
AS 
print('R&B Records, Yeaah')
GO

insert into Accounts(AccountId, NAME, Balance) values (11, 'YoanKuKozel', 1000)

update Accounts
set Balance = 1200 where NAME = 'YoanKuKozel'

DELETE FROM Accounts WHERE NAME = 'YoanKuKozel';

drop trigger reminder_printer
go

create or alter trigger alarm_error
on Accounts
after insert, update
as
	IF exists (select 1 from inserted i join Accounts a on a.AccountId = i.AccountId where len(a.NAME) < 2)
	begin
		RAISERROR ('The name you are trying to insert is not legal in BG.', 16, 1);  
		ROLLBACK TRANSACTION;  
		RETURN
	end
PRINT('You are a master')

insert into Accounts(AccountId, NAME, Balance) values (27, 'Yo', 1000)

select * from Accounts