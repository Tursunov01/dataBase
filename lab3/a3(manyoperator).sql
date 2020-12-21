create or replace function getFootballerTable(char) returns table
(
	id int,
	name char,
	foot char,
    rating int
)
as
$$
	update footballers
	set rating = 88
	where foot = $1;
	
	select id, name, foot, rating from footballers
	where foot = $1;
$$ language sql;

--select * from getFootballerTable('left'); 
--добавить операторы