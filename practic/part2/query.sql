select t.passenger_no, t.passenger_name, t.seat_no,
from flight as f
         join ticket t on f.id = t.flight_id
where departure_airport_code = 'MNK'
  AND arrival_airport_code = 'LDN'
  AND t.seat_no = 'B1'
;

select t.passenger_no, t.passenger_name, t.seat_no
from ticket t
         join flight f on f.id = t.flight_id
where seat_no = 'B1'
  And departure_airport_code = 'MNK'
  AND arrival_airport_code = 'LDN'
  and f.departure_date::date = (now() - interval '2 days')::date;

select (now() - interval '2 days')::date;
select '123'::integer;
-- 123

-- Сколько мест осталось незанятыми 2020-06-14 на рейсе MN3002?

select t2.count - t1.count result
from (select f.aircraft_id, count(t.id)
      from ticket t
               join flight f on f.id = t.flight_id
      where f.flight_no = 'MN3002'
        and f.departure_date::date = '2020-06-14'
      group by f.aircraft_id) t1
         join (select aircraft_id, count(*)
               from seat s
               group by aircraft_id) t2
              on t1.aircraft_id = t2.aircraft_id;

select f.aircraft_id, count(t.id)
from ticket t
         join flight f on f.id = t.flight_id
where f.flight_no = 'MN3002'
  and f.departure_date::date = '2020-06-14'
group by f.aircraft_id
;

select count(*)
from seat s
where aircraft_id = 1;
--2 вариант

select s.seat_no
from seat s
where aircraft_id = 1
  and not exists(
        select t.seat_no
        from ticket t
                 join flight f on f.id = t.flight_id
        where f.flight_no = 'MN3002'
          and f.departure_date::date = '2020-06-14'
          and s.seat_no = t.seat_no);


-- Какие 2 перелета были самые длительные за все время?

select flight_no, departure_date, arrival_date, arrival_date - flight.departure_date res
from flight
order by (arrival_date - flight.departure_date) DESC
LIMIT 2;

-- Какая максимальная и минимальная продолжительность перелетов между
-- Минском и Лондоном и сколько было всего таких перелетов?

select
       first_value(arrival_date- departure_date) over (order by (arrival_date- departure_date) desc ) max_value,
       first_value(arrival_date- departure_date) over (order by (arrival_date- departure_date) ) min_value,
       count(*) OVER()
from flight f
where (departure_airport_code ='MNK' and arrival_airport_code = 'LDN')
or (departure_airport_code ='LDN' and arrival_airport_code = 'MNK')
limit 1;

select max(arrival_date- departure_date), min(arrival_date- departure_date), count(*)
from flight f
where (departure_airport_code ='MNK' and arrival_airport_code = 'LDN')
   or (departure_airport_code ='LDN' and arrival_airport_code = 'MNK')

--  Какие имена встречаются чаще всего и какую долю от числа всех
--  пассажиров они составляют?

select passenger_name,
       count(id), round(count(id)*100.0/(select count(*) from ticket),2)
from ticket
group by passenger_name
order by 2 desc;

-- Иван Иванов,4,7.27
-- Петр Петров,3,5.45
-- Светлана Светикова,3,5.45
-- Андрей Андреев,2,3.64
-- Людмила Старовойтова,2,3.64
-- Дмитрий Трусцов,2,3.64

-- Вывести имена пассажиров, сколько всего каждый с таким именем купил билетов
-- , а также на сколько это количество
-- меньше от того имени пассажира, кто купил билетов больше всего

select res.passenger_no,
       res.passenger_name,
       res.count,
       max(res.count) OVER ()-res.count,
       max(res.count) OVER ()
from(
select passenger_no,
       passenger_name,
       count(id)
from ticket
group by passenger_no, passenger_name
order by passenger_name) res
order by res.count DESC

;

select res.passenger_no,
       res.passenger_name,
       res.count,
       first_value(res.count) OVER ()-res.count,
       first_value(res.count) OVER ()
from(
        select passenger_no,
               passenger_name,
               count(id)
        from ticket
        group by passenger_no, passenger_name
        order by 3 DESC ) res
order by res.count DESC;

-- Вывести стоимость всех маршрутов по убыванию. Отобразить разницу в стоимости
-- между текущим и ближайшими в отсортированном списке маршрутами
select t1.flight_id,
       t1.sum,
       max(t1.sum) OVER (),
       t1.sum-lag(t1.sum) OVER (ORDER BY t1.sum)
from(select t.flight_id, sum(cost)
     from ticket t
     group by t.flight_id
     order by 2 desc) t1
ORDER BY t1.sum desc;

-- вариант 2

select t1.flight_id,
       t1.sum,
       max(t1.sum) OVER (),
       coalesce(t1.sum-lag(t1.sum) OVER (ORDER BY t1.sum),0),
       coalesce(lead(t1.sum) OVER (ORDER BY t1.sum)- t1.sum,0) lead
from(select t.flight_id, sum(cost)
     from ticket t
     group by t.flight_id
     order by 2 desc) t1
ORDER BY t1.sum desc;







