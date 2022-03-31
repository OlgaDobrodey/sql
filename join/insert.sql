INSERT INTO company(id, name, date)
VALUES (1, 'Apple', '2001-01-01'),
       (2, 'Google', '2012-01-03'),
       (3, 'Facebook', '2002-10-22');

insert into contact (number, type)
values ('234-56-78', 'домашний'),
       ('987-65-43', 'рабочий'),
       ('565-25-91', 'мобильный'),
       ('332-55-67', NULL),
       ('465-11-22', NULL);

insert into employee(first_name, last_name, salary, company_id)
values ('Ivan', 'Ivanov', 1000,1),
       ('Petr', 'Petrov', 2000,2),
       ('Sveta', 'Ivanov', 1500,3),
       ('Olga', 'Dobrodey', 1000,1),
       ('Arni', 'Paramonov', Null,2)
;

insert into employee_contact (employee_id, contact_id)
values (1, 1),
       (1, 2),
       (2, 2),
       (2, 3),
       (3, 4),
       (4, 5);