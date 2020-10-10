select footballers.name, legioners.name
from footballers join 
(
	transfers join agents
	on agents.id = transfers.agent
)as legioners on legioners.footballer = footballers.id 
order by footballers.name