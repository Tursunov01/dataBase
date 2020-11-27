drop table agents_copy;
select *
into temp agents_copy from agents;

create or replace procedure update_rating(min_clients int, max_clients int) as
$$
declare cur cursor
	for select * from agents
	where clientsnum between min_clients and max_clients;
	row record;
begin
	open cur;
	loop
		fetch cur into row;
		exit when not found;
		update agents_copy
		set rating = rating + 10
		where agents_copy.id = row.id;
	end loop;
	close cur;		
end
$$ language plpgsql;

call update_rating(30,32);

select agents.name, agents.clientsnum, agents.rating as before_update, agents_copy.rating as after_update
from agents_copy join agents on agents_copy.id = agents.id
order by agents.clientsnum desc;