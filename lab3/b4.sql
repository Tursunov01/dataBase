create or replace procedure table_size() as
$$
declare rec record;
begin	
	for rec in
	select table_name,
	pg_relation_size(cast(table_name as varchar)) as size
	from information_schema.tables
	where table_schema not in ('information_schema','pg_catalog')
	 
	loop
		raise notice '{table name: %} {size : %}', rec.table_name, rec.size;
	end loop;
end
$$ language plpgsql;
--переписать процеду