insert into transfers(footballer, club, agent)
select footballers.id, 777, 777
from footballers
where footballers.rating > 88