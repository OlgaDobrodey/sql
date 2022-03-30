SELECT avg(empl.salary)
FROM (SELECT *
      FROM employee
      ORDER BY salary LIMIT 2) empl;

SELECT *
FROM employee
ORDER BY salary LIMIT 2;

select *,
       (select avg(salary) from employee) avgg,
       (select max(salary) from employee) maxim,
       (select max(salary) from employee)-salary diff
from employee;

SELECT *
FROM employee
WHERE company_id IN (Select company.id from company where date > '2002-10-22');