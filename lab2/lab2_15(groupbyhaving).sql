select name, count(*) as ModelsCount
from footballers
group by name
having count(*) > 3;