CREATE TABLE company_storage.company
(
    id   INT,
    name VARCHAR(128),
    date DATE NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name),
    CHECK (date > '2000-01-01' AND date < '2020-01-01')

    );

DROP TABLE company_storage.company;

INSERT INTO company_storage.company(id, name, date)
VALUES (1, 'Apple', '2001-01-01'),
       (2, 'Google', '2012-01-03'),
       (3, 'Facebook', '2002-10-22');

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id INT REFERENCES company_storage.company(id),
    salary     INT,
    UNIQUE (first_name, last_name)

);

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id INT,
    salary     INT,
    UNIQUE (first_name, last_name),
    FOREIGN KEY (company_id) REFERENCES company(id)
);

DROP TABLE employee;

insert into employee(first_name, last_name, salary, company_id)
values ('Ivan', 'Ivanov', 1000,1),
       ('Petr', 'Petrov', 2000,2),
       ('Sveta', 'Ivanov', 1500,3),
       ('Olga', 'Dobrodey', 1000,1),
       ('Arni', 'Paramonov', Null,2)
;