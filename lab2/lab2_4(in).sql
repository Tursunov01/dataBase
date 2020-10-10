select footballer, name, agent
from transfers join agents on transfers.agent = agents.id
where footballer in(
    select id
    from footballers
    where sex = 'Female' and rating between 90 and 99
)