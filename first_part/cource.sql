CREATE
DATABASE company_repository;

CREATE SCHEMA company_storage;
DROP SCHEMA company_storage;

CREATE TABLE company_storage.company
(
    id   INT,
    name VARCHAR(128),
    date DATE
);

-- DROP TABLE public.company;

INSERT INTO company_storage.company(id, name, date)
VALUES (1, 'Apple', '2001-01-01');