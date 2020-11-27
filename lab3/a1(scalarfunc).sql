create or replace function getFootballer() returns char as
$$
	select name
	from footballers
	--where rating = (select max(rating) from footballers)
	order by rating desc
$$ language sql;

select getFootballer();