create table if not exists trigger_table
(
	id int not null,
	ddate text not null
);

create or replace function trigger_func() returns trigger as
$$
   begin
      insert into trigger_table(id, ddate) values (new.id, current_timestamp);
      return new;
   end;
$$ language plpgsql;


create trigger starts
	after update of name on footballers
	for each row
	execute procedure trigger_func();

--Тестирование
update footballers
set name = 'Jasur Tursunov'
where name = 'Jacob Grant';

select * from trigger_table;