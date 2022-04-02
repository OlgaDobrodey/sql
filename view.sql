Create view  employee_view As
select c.name,
       e.salary,
       max(e.salary) OVER (partition by c.name),
        rank() OVER (ORDER BY e.salary nulls first ),
        lag(e.salary) OVER (ORDER BY e.salary)

from company c
         left join employee e on c.id = e.company_id
order by c.name;

select *
from employee_view alias
where alias.name ILIKE 'google';

--если хотим закэшировать запрос

create materialized view materializ_view AS
select c.name,
       e.salary,
       max(e.salary) OVER (partition by c.name),
       rank() OVER (ORDER BY e.salary nulls first ),
       lag(e.salary) OVER (ORDER BY e.salary)

from company c
         left join employee e on c.id = e.company_id
order by c.name;

select *
from materializ_view m2
where m2.salary = 2000;

-- Google,2000,2000,6,1500

select *
from materializ_view m2
where m2.max = 2000;

-- Google,2000,2000,6,1500
-- Google,null,2000,1,2000

--обновить вью
refresh materialized view materializ_view;

