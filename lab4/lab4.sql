-- Скалярная функция 
-- Получение имени футболиста по рейтингу
create or replace function get_name_by_rating(rate int) returns char
as $$
ppl = plpy.execute("select * from footballers")
for footballer in ppl:
	if footballer['rating'] == rate:
		return footballer['name']
return 'None'
$$ language plpython3u;

select * from get_name_by_rating(78);
---------------------------------------------------------------------------------------------------------------------------------------------------
-- Агрегатная функция
-- Сколько клубов у которых n-ное количество трофеев
create or replace function get_club(n int) returns int
as $$
ppl = plpy.execute("select * from clubs")
summ = 0
for club in ppl:
	if club['trophiesnum'] == n:
		summ += 1
return summ
$$ language plpython3u;

select * from get_club(0);
---------------------------------------------------------------------------------------------------------------------------------------------------
-- табличная функция
-- Возвращает все клубы у которых указанный рейтинг
create or replace function get_club_by_rating(rate int) returns table 
(
    id int, 
    name char, 
    rating int, 
    trophiesnum int, 
    uniorsnum int
)
as $$
ppl = plpy.execute("select * from clubs")
res = []
for club in ppl:
	if club['rating'] == rate:
		res.append(club)
return res
$$ language plpython3u;

select * from get_club_by_rating(90);
---------------------------------------------------------------------------------------------------------------------------------------------------
-- Процедура
-- Добавляет нового футболиста в таблицу
create or replace procedure add_club(name varchar, rating int, trophiesnum int, uniorsnum int) 
as $$
ppl = plpy.prepare("insert into clubs(name, rating, trophiesnum, uniorsnum) values($1, $2, $3, $4);", ["varchar", "int", "int", "int"])
plpy.execute(ppl, [name, rating, trophiesnum, uniorsnum])
$$ language plpython3u;

call add_club('Sunshine FC', 77, 10, 20);

select * from clubs order by id desc;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- При удалении клуба, данные копируются в таблицу duplicate
create or replace function default_delete() returns trigger 
as $$
plan = plpy.prepare("insert into duplicate(name, rating, trophiesnum, uniorsnum) values($1, $2, $3, $4);", ["varchar", "int", "int", "int"])
lostable = TD['old']
ppl = plpy.execute(plan, [lostable["name"], lostable["rating"], lostable["trophiesnum"], lostable["uniorsnum"]])
return TD['new']
$$ language  plpython3u;

--drop trigger default_delete on clubs; 
create table if not exists duplicate(
	name varchar,
    rating int,
    trophiesNum int,
    uniorsNum int 
);
--drop trigger default_delete on clubs;

create trigger default_delete
before delete on clubs for each row
execute procedure default_delete();

delete from clubs
where name = 'New Alexander FC';

select * from duplicate;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Тип параметров агента
create type info as (
  rating int,
  cost int,
  clientsnum int
);

-- Вывод параметров агентов по имени
create or replace function get_agent(ism varchar) returns info 
as $$
plan = plpy.prepare("select rating, cost, clientsnum from agents where name = $1", ["varchar"])
ppl = plpy.execute(plan, [ism])
return (ppl[0]['rating'], ppl[0]['cost'], ppl[0]['clientsnum'])
$$ language plpython3u;

select * from get_agent('David Davis');

---------------------------------------------------------------------------------------------------------------------------------------------------
create table if not exists local_agents(
    name varchar,
    main info
);

insert into local_agents(name, info) values("Jasur", [77, 2000, 10]);

create or replace function get_agent(rate int) returns varchar 
as $$
plan = plpy.prepare("name from local_agents where (local_agent.more).rating = $1", ["int"])
ppl = plpy.execute(plan, [rate])
return (ppl)
$$ language plpython3u;

select name from local_agents where (local_agent.more).rating = 77

select * from local_agents;

