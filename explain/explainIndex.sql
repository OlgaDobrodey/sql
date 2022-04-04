select relname, reltuples, relkind, relpages
from flight_repository.pg_catalog.pg_class
where relname like 'test1%';

analyze test1;

explain
select *
from test1
where number1 = 10000
  and value = '234363';

-- Index Scan using test1_number1_idx on test1  (cost=0.29..12.73 rows=3 width=17)
--   Index Cond: (number1 = 10000)
--
-- Index Scan using test1_number1_idx on test1  (cost=0.29..12.74 rows=1 width=17)
--   Index Cond: (number1 = 10000)
--   Filter: ((value)::text = '234363'::text)

explain
select *
from test1
where number1 = 10000
   or value = '234363';

--ПОтому как OR
-- Seq Scan on test1  (cost=0.00..2136.00 rows=4 width=17)
--   Filter: ((number1 = 10000) OR ((value)::text = '234363'::text))

explain
select number1
from test1
where number1 = 10000
;

-- Index Only Scan using test1_number1_idx on test1  (cost=0.29..4.35 rows=3 width=4)
--   Index Cond: (number1 = 10000)

--index only scan --только по индескаому дереву
--index scan -- после скана дерева индексов чтение таблицы
--bitmap scan (index scan , heap scan)

explain
select *
from test1
where number1 < 1000
  and number1 > 90000
;

-- Bitmap Heap Scan on test1  (cost=13.42..647.76 rows=500 width=17)
--   Recheck Cond: ((number1 < 1000) AND (number1 > 90000))
--   ->  Bitmap Index Scan on test1_number1_idx  (cost=0.00..13.29 rows=500 width=0)
--         Index Cond: ((number1 < 1000) AND (number1 > 90000))

explain
select *
from test1
where number1 > 1000
  and number1 < 90000
;

-- Seq Scan on test1  (cost=0.00..2136.00 rows=93694 width=17)
--   Filter: ((number1 > 1000) AND (number1 < 90000))

explain
select *
from test1
where number1 < 1000
   or number2 > 90000
;

-- Bitmap Heap Scan on test1  (cost=107.48..838.96 rows=6323 width=17)
--   Recheck Cond: ((number1 < 1000) OR (number2 > 90000))
--   ->  BitmapOr  (cost=107.48..107.48 rows=6365 width=0)
--         ->  Bitmap Index Scan on test1_number1_idx  (cost=0.00..90.41 rows=5615 width=0)
--               Index Cond: (number1 < 1000)
--         ->  Bitmap Index Scan on test1_number2_idx  (cost=0.00..13.92 rows=750 width=0)
--               Index Cond: (number2 > 90000)


explain
select *
from test1
where number1 < 1000
  and number2 > 90000
;

-- Bitmap Heap Scan on test1  (cost=104.59..237.99 rows=42 width=17)
--   Recheck Cond: ((number2 > 90000) AND (number1 < 1000))
--   ->  BitmapAnd  (cost=104.59..104.59 rows=42 width=0)
--         ->  Bitmap Index Scan on test1_number2_idx  (cost=0.00..13.92 rows=750 width=0)
--               Index Cond: (number2 > 90000)
--         ->  Bitmap Index Scan on test1_number1_idx  (cost=0.00..90.41 rows=5615 width=0)
--               Index Cond: (number1 < 1000)

explain
select *
from test1
where number1 < 1000
  and number2 > 90000
  and value = '123'
;

-- Bitmap Heap Scan on test1  (cost=104.57..238.08 rows=1 width=17)
--   Recheck Cond: ((number2 > 90000) AND (number1 < 1000))
--   Filter: ((value)::text = '123'::text)
--   ->  BitmapAnd  (cost=104.57..104.57 rows=42 width=0)
--         ->  Bitmap Index Scan on test1_number2_idx  (cost=0.00..13.92 rows=750 width=0)
--               Index Cond: (number2 > 90000)
--         ->  Bitmap Index Scan on test1_number1_idx  (cost=0.00..90.41 rows=5615 width=0)
--               Index Cond: (number1 < 1000)