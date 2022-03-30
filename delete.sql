delete from employee where id = 2;

delete from employee
where salary IN (select max(salary) from employee);