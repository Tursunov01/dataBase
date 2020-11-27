update agents
set cost = 
(
	select avg(cost)
	from agents
	where rating = 77
)
where rating = 77;