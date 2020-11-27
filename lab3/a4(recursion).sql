-- create or replace function multiply (a int, b int) returns table 
-- (
--     counter int, 
--     product int
-- )
-- as $$
-- begin
--     return query select a, b;
--     if a > 1 then
--         return query select * from multiply(a - 1, b * (a - 1));
--     end if;
-- end $$ language plpgsql;

-- select * from multiply(5, 5);

create or replace function r(a int, b int) returns table
(
    footballerR int,
    agentR int
)
as $$
begin
       
      return query select footballer, agent from transfers where agent = b;
      if a <= 100 then
          return query select * from r(a + 1, b);
      end if;
end $$ language plpgsql;

select * from r(1, 777);

--изменить 

