SELECT Distinct
    id,
    first_name f,
    last_name l,
    salary
from employee
-- WHERE salary != 1000
-- WHERE last_name LIKE 'Ivan%'
-- WHERE  last_name LIKE '%an%'
-- WHERE  last_name LIKE '%ov%'
-- WHERE first_name ILIKE 'ivan'
WHERE salary IN (1000, 500) or first_name LIKE 'Iv%'
ORDER BY salary,first_name DESC;