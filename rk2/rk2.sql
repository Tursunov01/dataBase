--Вариант первый

create table if not exists director(
    id serial not null primary key,
    name varchar(30) not null,
    birth_year int,
    work_year int,
    phone_num int 
)

create table if not exists krujok(
    id serial not null primary key,
    id_director int references director(id) not null,
    name varchar(15) not null,
    birth_year int,
    opisanie varchar(60) not null
)

create table if not exists visitor(
    id serial not null primary key,
    name varchar(30) not null,
    birth_year int,
    adress varchar(30) not null,
    email varchar(30) not null
)

insert into director(name, birth_year, work_year, phone_num)
values('Jasur Tursunov', 2000, 10, 974544584);

insert into director(name, birth_year, work_year, phone_num)
values('Doni Usmanov', 1979, 20, 974106464);

insert into director(name, birth_year, work_year, phone_num)
values('Otabek', 1979, 21, 945647841);

insert into director(name, birth_year, work_year, phone_num)
values('Nargiza Tursunova', 1978, 15, 974106442);

insert into director(name, birth_year, work_year, phone_num)
values('Sherzod Kariev', 2000, 10, 977071591);

insert into director(name, birth_year, work_year, phone_num)
values('Sardor Tursunov', 1954, 45, 992214578);

insert into director(name, birth_year, work_year, phone_num)
values('Kamilla Usmanova', 1985, 10, 974544584);

insert into director(name, birth_year, work_year, phone_num)
values('Muxlisa Munaeva', 1967, 40, 979844584);

insert into director(name, birth_year, work_year, phone_num)
values('Baxtiyor Nabiev', 1989, 10, 974541284);

insert into director(name, birth_year, work_year, phone_num)
values('Maxmud Utkurov', 1975, 20, 974544584);

----------------------------------------------------------------------------
insert into krujok(id_director, name, birth_year, opisanie)
values(1, 'Sladus', 2000, 'Best in own sphere');

insert into krujok(id_director, name, birth_year, opisanie)
values(2, 'Izabella', 2003, 'Best furnitures');

insert into krujok(id_director, name, birth_year, opisanie)
values(3, 'Med light', 2004, 'First class doctors');

insert into krujok(id_director, name, birth_year, opisanie)
values(4, 'Audi', 2005, 'Classic car');

insert into krujok(id_director, name, birth_year, opisanie)
values(2, 'Chevrolet', 2006, 'Monopoly');

insert into krujok(id_director, name, birth_year, opisanie)
values(7, 'Craffers', 2007, 'not bad chocolates');

insert into krujok(id_director, name, birth_year, opisanie)
values(8, 'Mediapark', 2008, 'Best in it');

insert into krujok(id_director, name, birth_year, opisanie)
values(9, 'Ecobazar', 2000, 'You can find anything');

insert into krujok(id_director, name, birth_year, opisanie)
values(1, 'Abu Saxiy', 2009, 'Number one sale area');

insert into krujok(id_director, name, birth_year, opisanie)
values(7, 'Artel', 1999, 'Multimedia');

-------------------------------------------------------------------------------------

insert into visitor(name, birth_year, adress, email)
values('Joanna', 1999, 'Medgorodok 1', 'j.1q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Khakim', 1978, 'Medgorodok 2', 'j.2q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Abduhalik', 1945, 'Medgorodok 3', 'j.3q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Murod', 1919, 'Medgorodok 4', 'j.4q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Julia', 1959, 'Medgorodok 5', 'j.5q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Jasur', 1977, 'Medgorodok 6', 'j.6q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('karim', 1985, 'Medgorodok 7', 'j.7q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Vini', 1988, 'Medgorodok 8', 'j.8q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Liza', 1969, 'Medgorodok 9', 'j.9q@mail.ru');

insert into visitor(name, birth_year, adress, email)
values('Ahmed', 1999, 'Medgorodok 3', 'j.11q@mail.ru');

------------------------------------------------------------------------------------
create table if not exists chain(
    id_visitor int references visitor(id) not null,
    id_krujok int references krujok(id) not null
);

insert into chain(id_visitor, id_krujok)
values(1,2);

insert into chain(id_visitor, id_krujok)
values(3,1);

insert into chain(id_visitor, id_krujok)
values(9,2);

insert into chain(id_visitor, id_krujok)
values(4,2);

insert into chain(id_visitor, id_krujok)
values(1,7);

insert into chain(id_visitor, id_krujok)
values(1,5);

insert into chain(id_visitor, id_krujok)
values(3,6);

insert into chain(id_visitor, id_krujok)
values(4,7);

insert into chain(id_visitor, id_krujok)
values(4,3);

insert into chain(id_visitor, id_krujok)
values(2,8);

--Второе задание
----------------------------------------------------------------------------------
--этот запрос вставляет слово "too young" если год рождения директора == 2000, иначе вставит слово "norm"
select *,
        case when birth_year = 2000 then 'too young director'
             else 'norm'
        end
from director;

--эта оконная функция выводит имя год рождения и средний год рождения по номеру телефона, то есть считается средний год рождения у каждого номера телефона
select name, birth_year, avg(birth_year) over (partition by phone_num) from director;

-- в итоговой таблице выведутся все года рождения из таблицы поситителей. В другом столбце количество повторений этих годов рождений
select birth_year, count(*) as YearCount from visitors
group by birth_year
having count(*) >= 1;

--Третье задание
----------------------------------------------------------------------------------------------

--
--вывод всех функций и типов примимаемых им аргуметов

--выбор имен, типов и количество принимаемых аргументов всех функций, где количество аргументов больше нуля
select proname, pronargs, proargtypes from pg_proc where pronargs > 0; 

--здесь сама функция которая выводит имена функций и типы их аргументов
create or replace procedure printFunc() as
$$
declare 
	cur cursor
	for select proname, proargtypes
	from (
		select proname, pronargs, proargtypes from pg_proc where pronargs > 0
	) AS tmp;
	row record;
begin
	open cur;
	loop
		fetch cur into row;
		exit when not found;
		raise notice '{funcName : %} {arguments : %}', row.proname, row.proargtypes;
	end loop;
	close cur;
end
$$ language plpgsql;

call printFunc();

