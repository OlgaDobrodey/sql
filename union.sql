SELECT first_name
FROM employee
WHERE company_id IS NOT NULL
UNION ALL
SELECT first_name
FROM employee
WHERE salary IS NULL;

-- Olga
-- Arni
-- Petr
-- Ivan
-- Arni

SELECT first_name
FROM employee
WHERE company_id IS NOT NULL
UNION
SELECT first_name
FROM employee
WHERE salary IS NULL;

-- Olga
-- Arni
-- Petr
-- Ivan



