delete
from employee
where id = 2;

delete
from employee
where salary = (select max(salary) from employee) returning *;

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(128) NOT NULL,
    last_name  VARCHAR(128) NOT NULL,
    company_id INT,
    salary     INT,
    UNIQUE (first_name, last_name),
    FOREIGN KEY (company_id) REFERENCES company (id)
        ON DELETE CASCADE --delete cascade
    -- No Action
    --Restrict - no action
    --set default
    --set null
);