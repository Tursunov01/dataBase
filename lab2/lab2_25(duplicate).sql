select *
from
(
	select dbl.name, row_number() over (partition by dbl.name) as counter
	from transfers join
	(
		select *
		from footballers join transfers on footballers.id = transfers.footballer
	) as dbl on transfers.footballer = dbl.footballer
) as percount
where counter = 1