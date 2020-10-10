select footballer, 
	case position
		when 'GK' then 'Goalkeeper'
		when 'LS' then 'Left stricker'
		when 'RS' then 'Right stricker'
		else 'Other'
	end as position_txt
from transfers