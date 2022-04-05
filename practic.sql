-- List the models of any type having the highest price of all products present in the database.

WITH ALL_PRODUCTS
         AS
         (SELECT MODEL,PRICE FROM PC
          UNION
          SELECT MODEL,PRICE FROM LAPTOP
          UNION
          SELECT MODEL,PRICE FROM PRINTER)
SELECT
    MODEL FROM ALL_PRODUCTS
WHERE PRICE = (SELECT MAX(PRICE) FROM ALL_PRODUCTS)
