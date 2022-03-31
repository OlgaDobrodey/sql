CREATE TABLE company
(
    id   INT,
    name VARCHAR(128),
    date DATE NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
 );

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id INT,
    salary     INT,
    FOREIGN KEY (company_id) REFERENCES company (id)
    );

CREATE TABLE contact(
    id SERIAL PRIMARY KEY,
    number VARCHAR(128) NOT NULL,
    type VARCHAR(128)
);

CREATE TABLE employee_contact(
    employee_id INT REFERENCES employee(id),
    contact_id INT REFERENCES contact(id),
    PRIMARY KEY (employee_id, contact_id)
);


