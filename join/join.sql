select * from employee_contact;
select * from employee;
select * from company;
select * from contact;

select first_name, last_name, (select name from company c  where company_id = c.id), company_id
from employee;

select e.first_name, e.last_name, c.name
from employee e, company c
where e.company_id = c.id;

--inner join

select e.first_name, e.last_name, c.name, concat(ct.number,' ',ct.type) number
from employee e
         join company c
              on e.company_id = c.id
         join employee_contact ec on e.id = ec.employee_id
         join contact ct on ec.contact_id = ct.id
;

-- Ivan,Ivanov,Apple,234-56-78 домашний
-- Ivan,Ivanov,Apple,987-65-43 рабочий
-- Petr,Petrov,Google,987-65-43 рабочий
-- Petr,Petrov,Google,565-25-91 мобильный
-- Sveta,Ivanov,Facebook,332-55-67
-- Olga,Dobrodey,Apple,465-11-22

-- =============================================================
--cross join --analog decardo mul

select e.first_name, e.last_name, c.name
from employee e
         cross join company c;

--  Ivan,Ivanov,Apple
-- Petr,Petrov,Apple
-- Sveta,Ivanov,Apple
-- Olga,Dobrodey,Apple
-- Arni,Paramonov,Apple
-- Ivan,Ivanov,Google
-- Petr,Petrov,Google
-- Sveta,Ivanov,Google
-- Olga,Dobrodey,Google
-- Arni,Paramonov,Google
-- Ivan,Ivanov,Facebook
-- Petr,Petrov,Facebook
-- Sveta,Ivanov,Facebook
-- Olga,Dobrodey,Facebook
-- Arni,Paramonov,Facebook
-- =============================================================
--left outer join

select e.first_name, e.last_name, c.name
from company c
         left join employee e on e.company_id = c.id;

-- Ivan,Ivanov,Apple
-- Petr,Petrov,Google
-- Sveta,Ivanov,Facebook
-- Olga,Dobrodey,Apple
-- Arni,Paramonov,Google
-- NUll,NUll,Amazon


select e.first_name, e.last_name, c.name
from employee e
         left join company c on e.company_id = c.id;

--
-- Ivan,Ivanov,Apple
-- Petr,Petrov,Google
-- Sveta,Ivanov,Facebook
-- Olga,Dobrodey,Apple
-- Arni,Paramonov,Google
-- Oleg,Vanin, null

-- =============================================================
--right outer join

select e.first_name, e.last_name, c.name
from employee e
         right join company c on e.company_id = c.id;

-- Ivan,Ivanov,Apple
-- Petr,Petrov,Google
-- Sveta,Ivanov,Facebook
-- Olga,Dobrodey,Apple
-- Arni,Paramonov,Google
-- NUll,NUll,Amazon

-- =============================================================
--full outer join

select e.first_name, e.last_name, c.name
from employee e
         full join company c on e.company_id = c.id;


-- Ivan,Ivanov,Apple
-- Petr,Petrov,Google
-- Sveta,Ivanov,Facebook
-- Olga,Dobrodey,Apple
-- Arni,Paramonov,Google
-- Oleg,Vanin,NULL
-- NULL,NULL,Amazon
