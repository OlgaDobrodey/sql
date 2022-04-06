-- List the models of any type having the highest price of all products present in the database.
-- https://www.sql-ex.ru/learn_exercises.php#answer_ref
WITH ALL_PRODUCTS
         AS
         (SELECT MODEL, PRICE
          FROM PC
          UNION
          SELECT MODEL, PRICE
          FROM LAPTOP
          UNION
          SELECT MODEL, PRICE
          FROM PRINTER)
SELECT MODEL
FROM ALL_PRODUCTS
WHERE PRICE = (SELECT MAX(PRICE) FROM ALL_PRODUCTS);

--     Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя

WITH ALL_PRODUCTS
         As
         (SELECT MODEL, PRICE
          FROM PC
          UNION All
          SELECT MODEL, PRICE
          FROM LAPTOP
         )
select avg(price) as AVG_price
From all_products a
         join product p on p.model = a.model
where maker = 'A';


--     Задание: 28 (Serge I: 2012-05-04)
-- Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

select count(qty)
from (
         Select distinct maker as qty
         from product
         group by maker
         having count(model) = 1) as q;


--     https://www.sql-ex.ru/learn_exercises.php#answer_ref
SELECT X.POINT, X.DATE, SUM(OUT), SUM(INC)
FROM (
         SELECT I.POINT, I.DATE, Null AS OUT, SUM(I.INC) AS INC
         FROM INCOME I
         GROUP BY I.POINT, I.DATE
         UNION All
         SELECT O.POINT, O.DATE, SUM(O.OUT) AS OUT, null AS INC
         FROM OUTCOME O
         GROUP BY O.POINT, O.DATE) AS X
GROUP BY POINT, DATE

explain analyze
select passenger_no
from ticket
where passenger_no SIMILAR TO '[0-9]*'
order by passenger_no asc


