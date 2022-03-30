SELECT sum(salary) from employee;
SELECT avg(salary) from employee;
SELECT max(salary) from employee;
SELECT min(salary) from employee;
SELECT count(*) from employee; --if position equals null - it do not go to count
SELECT upper(first_name) from employee;
SELECT lower(first_name) from employee;
SELECT concat(first_name,' ',last_name) fio from employee;
SELECT first_name ||' '||last_name  fio from employee;
SELECT now(), 2*4 equals;