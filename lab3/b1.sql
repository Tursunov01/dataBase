select *
into temp footballers_copy from footballers;

create or replace procedure update_rating() as
$$
	update footballers_copy
	set rating = rating * 2
	where foot = 'left'
$$ language sql;

call update_rating();

select footballers.name, footballers.foot, footballers.rating as before_update, footballers_copy.rating as after_update
from footballers_copy join footballers on footballers_copy.id = footballers.id
