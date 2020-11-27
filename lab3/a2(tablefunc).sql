create or replace function getsfootballer(int) returns footballers as
$$
	select *
	from footballers
	where rating = $1;
$$ language plpgsql;

select * from getleftfootballer(77); 