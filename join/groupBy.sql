select c.name, count(e.id)
from company c
         left join employee e on c.id = e.company_id
group by c.id;

-- Amazon,0
-- Google,2
-- Apple,2
-- Facebook,1

select c.name, c.date, count(e.id)
from company c
         left join employee e on c.id = e.company_id
group by c.id
HAVING count(e.id)>1;  --фильтр на агрегатные функции-т.е условие на группы

-- Google,2012-01-03,2
-- Apple,2001-01-01,2

