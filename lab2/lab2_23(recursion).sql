with recursive r(footballer, agent) as(
    select footballer, agent from transfers where agent = 777
  union
    select transfers.footballer, transfers.agent
    from transfers
    join r on r.agent = transfers.agent
)
select * from r;