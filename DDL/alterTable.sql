ALTER TABLE IF EXISTS employee
ADD COLUMN general INT;

update employee
set general = 0
where id IN (1,2,5,6,7);

update employee
set general = 1
where id IN (3,4);

ALTER TABLE employee
ALTER COLUMN general set Not NUll;

ALTER TABLE employee
DROP COLUMN general;

ALTER TABLE employee
RENAME COLUMN general TO gender;