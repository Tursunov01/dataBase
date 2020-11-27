create view footballers_view as
select * from footballers;

create or replace function trigger_delete() returns trigger as
$$
begin
	update footballers
	set rating = 77
	where id = old.id ;
	return old;
end;
$$ language plpgsql;

create trigger delete_footballer
	instead of delete on footballers_view
	for each row 
	execute procedure trigger_delete()

--Тестирование
delete from footballers_view
where id = 977;

select * from footballers_view
where id = 977;