delete from transfers
where agent in
(
	select id
	from agents
	where cost > 2000
);