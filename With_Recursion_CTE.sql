  declare @n int = 1;
  with recurseee 
  as (
	select @n as num
	union all
	select num + 1
	from recurseee
	where num < 10
  )

  select * from recurseee