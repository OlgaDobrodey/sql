explain
select *
from ticket;

--Seq Scan on ticket --full scan
-- (cost=0.00..1.55 - стоимость
-- rows=55
-- width=60) - count byte fot line

--синтаксический (rule -base) оптимизатор базы -- не испоьзуется сейчас
--стоимостной оптимизатор базы --(cost - base):
-- page_cost(input-output) == 1.0
-- cpu_cost == 0.01 (количество операций)

-- Seq Scan on ticket  (cost=0.00..1.55 rows=55 width=60)
--55*0.01 = 0.55 (cpu_cost)
--1 * 1.00 = 1.00 (page_cost)

select reltuples, relkind, relpages
from flight_repository.pg_catalog.pg_class
where relname = 'ticket';

-- 55,r,1

select avg(bit_length(passenger_no) / 8),
       avg(bit_length(passenger_name) / 8),
       avg(bit_length(seat_no) / 8)
from ticket;

explain
select *
from ticket
where passenger_name like 'Иван%'
  and seat_no = 'B1';

explain
select flight_id, count(*), sum(cost)
from ticket
group by flight_id;

-- HashAggregate  (cost=1.96..2.08 rows=9 width=48)
--                Group Key: flight_id
--   ->  Seq Scan on ticket  (cost=0.00..1.55 rows=55 width=13)

explain
select *
from ticket
where flight_id = 1
  and seat_no = 'A1';

-- Seq Scan on ticket  (cost=0.00..1.82 rows=1 width=60)
--   Filter: ((flight_id = 1) AND ((seat_no)::text = 'A1'::text))


explain
select *
from ticket
where id = 25;

-- Seq Scan on ticket  (cost=0.00..1.69 rows=1 width=60)
--   Filter: (id = 25)


