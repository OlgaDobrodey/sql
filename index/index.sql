-- indexes default - primary key
-- селективность - количество уникальных элементов в столбце на все количество
-- 9/55 плохая селективность меньше ;-- хорошая когда ->1
select count(distinct flight_id) from ticket;

CREATE UNIQUE INDEX unique_flight_id_seat_no_index ON ticket (flight_id, seat_no);
-- will be search  flight_id + seat_no

select *
from ticket
where seat_no = 'C1' AND flight_id = 3; --index

-- 1 row retrieved starting from 1 in 70 ms (execution: 6 ms, fetching: 64 ms)

select *
from ticket
where flight_id = 2 AND seat_no = 'C1'; --index
-- 1 row retrieved starting from 1 in 39 ms (execution: 6 ms, fetching: 33 ms)

select *
from ticket
where flight_id = 3;
-- 8 rows retrieved starting from 1 in 54 ms (execution: 7 ms, fetching: 47 ms)

select *
from ticket
where seat_no = 'A1';  --full scan
--8 rows retrieved starting from 1 in 53 ms