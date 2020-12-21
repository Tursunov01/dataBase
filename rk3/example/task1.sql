create table if not exists visits (
    emp_id int not null,
	date_visit date not null,
	day_week varchar(20) not null,
	time_visit time not null,
	visit_type int not null,
	primary key (emp_id, date_visit, time_visit)
);

create table if not exists employees (
    id int not null primary key,
	name varchar(100) not null,
	birth_date date not null,
	department varchar(50)
);

set datestyle to 'iso, mdy';

insert into visits values
		(1, '12-14-2018', 'Saturday', '9:00', 1),                                                           
		(1, '12-14-2018', 'Saturday', '9:20', 2),
        (1, '12-14-2018', 'Saturday', '9:25', 1),
        (2, '12-14-2018', 'Saturday', '9:05', 1);
insert into employees values
	(1,'Иванов Иван Иванович','09-25-1990','ИТ'),
	(2,'Петров Петр ПЕтрович','11-12-1987','Бухгалтерия');

create or replace function getWorker(date) returns int as
$$
    begin
	return(
	select count(*)
	from(select distinct id from employees 
	where extract(year from age(current_date,birth_date)) between 18 and 40
	and id in (select emp_id from (select emp_id, date_visit, visit_type, count(*)
	from visits
		where date_visit = $1
		group by emp_id, date_visit, visit_type
		having visit_type = 2 and count(*) > 3) as tmp0
		))as tmp1
	);
	end;
$$ language plpgsql;

select getWorker('12-14-2018');