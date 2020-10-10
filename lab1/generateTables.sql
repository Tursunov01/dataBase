drop table transfers;
drop table footballers;
drop table clubs;
drop table agents;

create table if not exists footballers(
    id serial,
    name varchar(35) ,
    sex varchar(10),
    birthday date
    foot varchar(10),
    rating int
);


create table if not exists clubs(
    id serial,
    name varchar(50) ,
    rating int,
    trophiesNum int,
    uniorsNum int 
);

create table if not exists agents(
    id serial,
    name varchar(30),
    birthday date,
    rating int,
    clientsNum int,
    cost int 
);

create table if not exists transfers(
    footballer int,
    club int,
    agent int,
    position varchar(4)
);