select c.name,
       e.last_name,
       e.salary,
       count(e.id) OVER (),
        max(e.salary) OVER (),
        rank() OVER (ORDER BY e.salary nulls first )

from company c
         left join employee e on c.id = e.company_id
order by c.name
;
-- name, last_name, salary, count,max, rank
-- Amazon,,,5,2000,1
-- Apple,Ivanov,1000,5,2000,3
-- Apple,Dobrodey,1000,5,2000,3
-- Facebook,Ivanov,1500,5,2000,5
-- Google,Paramonov,,5,2000,1
-- Google,Petrov,2000,5,2000,6

select c.name,
       e.last_name,
       e.salary,
       count(e.id) OVER (),
        max(e.salary) OVER (),
        rank() OVER (ORDER BY e.salary nulls first ),
        dense_rank() OVER (partition by c.name ORDER BY e.salary nulls first )
from company c
         left join employee e on c.id = e.company_id
order by c.name;

-- Amazon,,,5,2000,1,1
-- Apple,Ivanov,1000,5,2000,3,1
-- Apple,Dobrodey,1000,5,2000,3,1
-- Facebook,Ivanov,1500,5,2000,5,1
-- Google,Paramonov,,5,2000,1,1
-- Google,Petrov,2000,5,2000,6,2

--partition by   -для разбивки окна
--перед OVER стоит или агрегирующая или оконная функция

select c.name,
       e.salary,
       max(e.salary) OVER (partition by c.name),
        rank() OVER (ORDER BY e.salary nulls first )

from company c
         left join employee e on c.id = e.company_id
order by c.name;

-- Amazon,,,1
-- Apple,1000,1100,3
-- Apple,1100,1100,4
-- Facebook,1500,1500,5
-- Google,,2000,1
-- Google,2000,2000,6

select c.name, e.salary, lag(e.salary) OVER (ORDER BY e.salary)
from company c
         left join employee e on c.id = e.company_id
order by c.name;

-- Amazon,NUll,NUll
-- Apple,1000,NUll
-- Apple,1100,1000
-- Facebook,1500,1100
-- Google,2000,1500
-- Google,NUll,2000