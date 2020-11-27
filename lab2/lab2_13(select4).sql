select *
from footballers
where id in
(
	select distinct footballers
	from transfers join agents on transfers.agent = agents.id
	where agent in
	(
		select distinct id
		from agent
		where cost = 
		(
				select cost
				from agents
				where cost > 2000
		)
	)
)
