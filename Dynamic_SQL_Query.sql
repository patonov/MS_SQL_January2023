declare @command varchar(max);

declare @variable varchar(50);
set @variable = '10';

set @command = 'select * from WizzardDeposits where Id = ' + @variable;

print(@command);
exec(@command);

