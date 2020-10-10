select footballer
from (transfers join footballers on transfers.footballer = footballers.id) as tmp
where position = 'GK'
	and exists(
	select footballer 
	from (transfers join footballers on transfers.footballer = footballers.id)
	where position = 'LF'
		and footballer = tmp.footballer)