CREATE TABLE book(
                     id BIGSERIAL PRIMARY KEY,
                     title VARCHAR(128) NOT NULL,
                     year SMALLINT NOT NULL,
                     count_page SMALLINT NOT NULL,
                     author_id INT REFERENCES author(id)
);

CREATE TABLE author(
                       id SERIAL PRIMARY KEY,
                       first_name VARCHAR(128) NOT NULL,
                       last_name VARCHAR(128) NOT NULL
);

INSERT INTO author(first_name, last_name)
VALUES ('Lev','Tolstoy'),
       ('Anton', 'Chehov'),
       ('Alex', 'Pushkin'),
       ('Alex', 'Bloc'),
       ('Mike', 'Bulgakov');

SELECT * from author;

INSERT INTO book(title, year, count_page, author_id)
VALUES ('War and Peace', 1867,1225,(SELECT id FROM author where last_name = 'Tolstoy')),
       ('Anna Karenina', 1878,864,(SELECT id FROM author where last_name = 'Tolstoy')),
       ('About love', 1898,60,(SELECT id FROM author where last_name = 'Chehov')),
       ('The Lady with the Dog', 1899,60,(SELECT id FROM author where last_name = 'Chehov')),
       ('Dubrovsky', 1841,35,(SELECT id FROM author where last_name = 'Pushkin')),
       ('The Queen of Spades', 1834,678,(SELECT id FROM author where last_name = 'Pushkin')),
       ('The Lady Unknown', 1907,23,(SELECT id FROM author where last_name = 'Bloc')),
       ('Roza and krest', 1913,470,(SELECT id FROM author where last_name = 'Bloc')),
       ('Heart of a dog', 1925,123,(SELECT id FROM author where last_name = 'Bulgakov')),
       ('The Master and Margarita', 1967,578,(SELECT id FROM author where last_name = 'Bulgakov'));

SELECT * FROM book;

DROP TABLE book;

-- Написать запрос, выбирающий название книги , год и имя автора

SELECT title, year, (SELECT a.last_name from author a where book.author_id = a.id)
FROM book
ORDER BY year;

SELECT title, year, (SELECT a.last_name from author a where book.author_id = a.id)
FROM book
ORDER BY year DESC;

-- Написать запрос выбирающий колличество книг у заданного автора

SELECT count(b.title)
FROM book b
WHERE author_id IN (SELECT a.id FROM author a WHERE a.last_name = 'Tolstoy');

-- Написать запрос выбирающий книги у которых количество страниц больше среднего
-- колоичество стараниц по всем книгам

SELECT title, count_page
FROM book
WHERE count_page > (SELECT avg(count_page) from book) ;

-- Написать запрос выбирающий 5 самый старых книг, Дополнить запрос
-- поститать суммарное колиество страниц среди этих книг

SELECT *
FROM book
ORDER BY year
    LIMIT 5;

SELECT sum(count_page)
FROM book
WHERE title in (SELECT title FROM book ORDER BY year LIMIT 5)
;

SELECT sum(b.count_page)
FROM (SELECT * FROM book ORDER BY year LIMIT 5) AS b
;

-- Написать запрос изменяющий количество страниц у одной из книг

UPDATE book
SET count_page = count_page + 5
WHERE id = 8
    Returning title, year, count_page;

SELECT *
FROM book;

-- Написать запрос, удаляющий автора, который написал самую большую книгу

SELECT title
FROM book
ORDER BY count_page DESC
    LIMIT 1;

SELECT max(count_page)
FROM book;

DELETE
FROM author
WHERE id = (SELECT author_id FROM book ORDER BY count_page DESC LIMIT 1);

SELECT author_id
FROM book
WHERE count_page = (SELECT max(count_page) FROM book);

DELETE FROM book
WHERE author_id = (SELECT author_id
                   FROM book
                   WHERE count_page = (SELECT max(count_page) FROM book))
    RETURNING id;

DELETE
FROM author
WHERE id = (SELECT author_id
            FROM book
            WHERE count_page = (SELECT max(count_page) FROM book));

DELETE
FROM author
WHERE id = (4);