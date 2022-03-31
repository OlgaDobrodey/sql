update employee
set company_id = 2,
    salary     = 1700
where salary is null;

update employee
set company_id = 2,
    salary     = 2000
where id = 2 returning *;
--2,Petr,Petrov,2,2000

update employee
set company_id = 2,
    salary     = 2000
where id = 2 returning first_name, last_name;

update employee
set company_id = 2,
    salary     = 2000
where id = 2 returning (first_name,' ', last_name);
--(Petr," ",Petrov)