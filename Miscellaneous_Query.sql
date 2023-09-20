SELECT cast((floor(sqrt(cast(round(235.515, 1) as int))) / 3) as int) % 2

select * into new_test_table from Genres where left(GenreName, 1) = 'Á'
select * from new_test_table where Notes is not null