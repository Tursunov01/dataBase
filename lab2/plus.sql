drop table if exists t1;
drop table if exists t2;

create table if not exists t1 
(
	id int,
	var1 char,
	d_from date,
	d_to date
);

create table if not exists t2 
(
	id int,
	var2 char,
	d_from date,
	d_to date
);

insert into t1 (id, var1, d_from, d_to) values (1, 'A', '20180901', '20180915');
insert into t1 (id, var1, d_from, d_to) values (1, 'B', '20180916', '59991231');

insert into t2 (id, var2, d_from, d_to) values (1, 'A', '20180901', '20180902');
insert into t2 (id, var2, d_from, d_to) values (1, 'B', '20180903', '59991231');

if t2 exists
	select t1.id, t1.var1, t2.var2, 
		case 
		when t1.d_from<t2.d_from then t2.d_from
			else t1.d_from
		end as time1, 
		case when t1.d_to>t2.d_to then t2.d_to
			else t1.d_to 
		end as time2
	from t1 join t2 on 
		t1.id = t2.id and 
		t1.d_from<t2.d_to and 
		t2.d_from<t1.d_to
else
	select t1.id, t1.var1, t1.d_from as time1, t1.d_to as time
	from t1

-- select t1.id, t1.var1, t2.var2, 
-- 	case 
-- 	when t1.d_from<t2.d_from then t2.d_from
-- 		else t1.d_from
-- 	end as time1, 
-- 	case when t1.d_to>t2.d_to then t2.d_to
-- 		else t1.d_to 
-- 	end as time2
-- from t1 join t2 on 
-- 	t1.id = t2.id and 
-- 	t1.d_from<t2.d_to and 
-- 	t2.d_from<t1.d_to