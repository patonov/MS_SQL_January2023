create or alter function ufn_CashInUsersGames(@gameName varchar(100))
returns table
as
return
(select sum(Cash) cash from 
	(select row_number() over (order by Cash desc) [row], cash from UsersGames ug
	join Games g ON g.Id = ug.GameId
	where [Name] = @gameName) k
	where [row] % 2 != 0
)

go
select * from dbo.ufn_CashInUsersGames('Lisbon')