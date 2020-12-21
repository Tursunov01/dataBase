drop table footballers_copy;
select *
into temp footballers_copy from footballers;

create or replace procedure update_foot(a int, b int) as
$$
begin
	if a <= b then
		update footballers
		set foot = 'left'
		where foot = 'right';
		call update_foot(a + 1, b);
	end if;
end $$ language plpgsql;

call update_foot(1,100);

select footballers.name, footballers.foot as before_update, footballers_copy.foot as after_update
from footballers_copy join footballers on footballers_copy.id = footballers.id
order by footballers.id; 