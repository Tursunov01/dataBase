alter table footballers
add primary key(id);

alter table footballers
alter column id
set not null;

alter table footballers
alter column name
set not null;

alter table footballers
add check (age >= 15 and age <= 31);

alter table footballers
add check (rating >= 0 and rating <= 99);

-----------------------------------------------------------------

alter table clubs
add primary key(id);

alter table clubs
alter column id
set not null;

alter table clubs
alter column name
set not null;

alter table clubs
add check (rating >= 50 and rating <= 99);

alter table clubs
add check (trophiesNum >= 0 and trophiesNum <= 20);

alter table clubs
add check (uniorsNum >= 0 and uniorsNum <= 50);

-------------------------------------------------------------------------------

alter table agents
add primary key(id);

alter table agents
alter column id
set not null;

alter table agents
alter column name
set not null;

alter table agents
add check (age >= 30 and age <= 80);

alter table agents
add check (rating >= 30 and rating <= 99);

alter table agents
add check (clientsNum >= 0 and clientsNum <= 40);

alter table agents
add check (cost >= 100 and cost <= 5000);

----------------------------------------------------------------------

alter table transfers
alter column footballer
set not null;

alter table transfers
alter column club
set not null;

alter table transfers
alter column agent
set not null;

alter table transfers
alter column position
set default 'GK';

alter table transfers
add foreign key(footballer) references footballers(id);

alter table transfers
add foreign key(club) references clubs(id);

alter table transfers
add foreign key(agent) references agents(id);



