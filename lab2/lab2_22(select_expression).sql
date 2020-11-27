select agent, count(*) as n_of_agent
from transfers
group by agent
order by n_of_agent desc