select *
from agents
where cost < all
(
	select cost
	from agents
	where rating = 90
)