explain analyze
select *
from test1
where number1 <1000;

-- Bitmap Heap Scan on test1  (cost=91.81..798.00 rows=5615 width=17) (actual time=0.304..1.935 rows=5624 loops=1)
--   Recheck Cond: (number1 < 1000)
--   Heap Blocks: exact=598
--   ->  Bitmap Index Scan on test1_number1_idx  (cost=0.00..90.41 rows=5615 width=0) (actual time=0.243..0.243 rows=5624 loops=1)
--         Index Cond: (number1 < 1000)
-- Planning Time: 0.304 ms
-- Execution Time: 2.253 ms

explain analyze
select *
from test1
where value < '1000';

--nested loop  -не очень много записей
--hash join -много записей
--merge join -для мерж джойна обязаны использовать отсортированную последовательность

explain analyze
select *
from test1
join test2 t on test1.id = t.test_id
limit 100;
-- Limit  (cost=0.29..36.58 rows=100 width=38) (actual time=0.015..0.220 rows=100 loops=1)
--   ->  Nested Loop  (cost=0.29..36284.95 rows=100000 width=38) (actual time=0.014..0.207 rows=100 loops=1)
--         ->  Seq Scan on test2 t  (cost=0.00..1637.00 rows=100000 width=21) (actual time=0.006..0.016 rows=100 loops=1)
--         ->  Index Scan using test1_pkey on test1  (cost=0.29..0.35 rows=1 width=17) (actual time=0.001..0.001 rows=1 loops=100)
--               Index Cond: (id = t.test_id)
-- Planning Time: 0.144 ms
-- Execution Time: 0.253 ms

explain analyze
select *
from test1 t1
         join test2 t2 on t1.id = t2.test_id
;
-- Hash Join  (cost=3472.00..7129.51 rows=100000 width=38) (actual time=27.811..97.177 rows=100000 loops=1)
--   Hash Cond: (t2.test_id = t1.id)
--   ->  Seq Scan on test2 t2  (cost=0.00..1637.00 rows=100000 width=21) (actual time=0.007..7.607 rows=100000 loops=1)
--   ->  Hash  (cost=1636.00..1636.00 rows=100000 width=17) (actual time=27.570..27.571 rows=100000 loops=1)
--         Buckets: 65536  Batches: 2  Memory Usage: 2947kB
--         ->  Seq Scan on test1 t1  (cost=0.00..1636.00 rows=100000 width=17) (actual time=0.004..7.635 rows=100000 loops=1)
-- Planning Time: 0.134 ms
-- Execution Time: 101.476 ms

explain analyze
select *
from test1 t1
    join (select * from test2 order by test_id) t2 on t1.id = t2.test_id
;

-- Merge Join  (cost=11993.26..17985.96 rows=100000 width=38) (actual time=26.893..96.425 rows=100000 loops=1)
--   Merge Cond: (test2.test_id = t1.id)
--   ->  Sort  (cost=11992.82..12242.82 rows=100000 width=21) (actual time=26.871..39.782 rows=100000 loops=1)
--         Sort Key: test2.test_id
--         Sort Method: external merge  Disk: 3136kB
--         ->  Seq Scan on test2  (cost=0.00..1637.00 rows=100000 width=21) (actual time=0.005..7.212 rows=100000 loops=1)
--   ->  Index Scan using test1_pkey on test1 t1  (cost=0.29..3243.29 rows=100000 width=17) (actual time=0.016..16.482 rows=100000 loops=1)
-- Planning Time: 0.146 ms
-- Execution Time: 101.314 ms

create index test2_test1_id_idx on test2 (test_id);
explain analyze
select *
from test1 t1
         join test2 t2 on t1.id = t2.test_id
;

-- Hash Join  (cost=3472.00..7129.51 rows=100000 width=38) (actual time=26.409..94.291 rows=100000 loops=1)
--   Hash Cond: (t2.test_id = t1.id)
--   ->  Seq Scan on test2 t2  (cost=0.00..1637.00 rows=100000 width=21) (actual time=0.006..7.537 rows=100000 loops=1)
--   ->  Hash  (cost=1636.00..1636.00 rows=100000 width=17) (actual time=26.235..26.236 rows=100000 loops=1)
--         Buckets: 65536  Batches: 2  Memory Usage: 2947kB
--         ->  Seq Scan on test1 t1  (cost=0.00..1636.00 rows=100000 width=17) (actual time=0.003..7.309 rows=100000 loops=1)
-- Planning Time: 0.351 ms
-- Execution Time: 98.390 ms

