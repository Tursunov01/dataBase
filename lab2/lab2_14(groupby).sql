select name, foot
from footballers
where  rating > 75
group by name, foot