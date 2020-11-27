--Лабораторная работа 5
--1) из таблицы в json
select to_json(t) from (
  select * from footballers
) t;
--из таблицы в json файл
copy (select to_json(footballers) from footballers)
to 'C:\Jasur\projects\dataBase\lab5\save.json';
drop table ppl_import;

--2) из json в таблицу с одним столбцом
create table footballer_copy(data json);
copy footballer_copy from 'C:\Jasur\projects\dataBase\lab5\save.json';
--из json таблицы в первоначальную таблицу
create table footballers2 as
select d.* from footballer_copy, json_populate_record(null::footballers, doc) as d;
--3) создать таблицу с типом json и сделать insert
drop table orders;
create table if not exists orders
(
	id serial not null primary key,
	data jsonb not null
);
insert into orders(data) 
values  ( 
            '{ "customer": "John Doe", "items": {"product": "Screen","qty": 3}}'
        ),
        (
            '{ "customer": "Lily Bush", "items": {"product": "RAM","qty": 24}}'
        ),
        (
            '{ "customer": "Josh William", "items": {"product": "Video drive","qty": 1}}'
        ),
        (
            '{ "customer": "Mary Clark", "items": {"product": "HDD","qty": 2}}'
        ),
        (
            '{ "customer": "Lil Pip", "items": {"product": null, "qty": 2}}'
        );
select * from orders;
select data->'items'->>'product' as product from orders where data->'items'->>'product' = 'Diaper';
--4)
--4.1)вывод фрагмента items
select data->'items' from orders;
--4.2) извлечение конкретных атрибутов json документа
select data->'items'->>'product' as product from orders;
--4.3) проверка атрибута json на существование
select data->'customer' from orders where data->'items'->>'product' is not null;
--4.4) изменить json документ
update orders set data = '{ "customer": "Tupak", "items": {"product": "Iphone","qty": 1}}'::jsonb where id = 2;
insert into orders(data) values  ('{ "customer": "DaBady", "items": {"product": "Notebook","qty": 0}}');
update orders 
set data = 
    jsonb_set(data->'items', '{product}', '"mac"') 
where id = 3;
--4.5) разделение json по строкам
select * from json_populate_recordset(null::x, 
									  '[{"owner":"Dana White","product":"UFC"},
									    {"owner":"Tim Cook","product":"Apple"},
									    {"owner":"Elon Musk","product":"Tesla"}]');


