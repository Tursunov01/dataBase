select name, 
	case
		when rating < 30 then 'Low'
		when rating < 70  and rating > 30 then 'Normal'
		when rating < 99 and rating > 70 then 'High'
		else '?'
	end as rating_check
from footballers