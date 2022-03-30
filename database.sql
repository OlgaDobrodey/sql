CREATE TABLE company_storage.company
(
    id   INT PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    date DATE NOT NULL CHECK (date > '2000-01-01' AND date <'2020-01-01')
    );

CREATE TABLE company_storage.company
(
    id   INT,
    name VARCHAR(128),
    date DATE NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name),
    CHECK (date > '2000-01-01' AND date <'2020-01-01')

    );

DROP TABLE company_storage.company;

INSERT INTO  company_storage.company(id, name, date)
VALUES (1,'Apple','2001-01-01'),
       (2,'Google','2012-01-03'),
       (3,'Facebook','2002-10-22');


CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    salary     INT,
    UNIQUE (first_name,last_name)
);

DROP TABLE employee;

insert into employee(first_name, last_name, salary)
values ('Ivan', 'Ivanov', 1000),
       ('Petr', 'Petrov', 2000),
       ('Sveta', 'Ivanov', 1500),
       ('Olga', 'Dobrodey', 1000)
;


