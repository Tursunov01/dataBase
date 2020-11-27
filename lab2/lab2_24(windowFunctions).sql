select name, rating, cost,  
	min(cost) over (partition by rating), max(cost) over (partition by rating),
	avg(cost) over (partition by rating)
from agents;