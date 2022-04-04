create table test1
(
    id      SERIAL PRIMARY KEY,
    number1 int         NOT NULL,
    number2 int         NOT NULL,
    value   VARCHAR(32) NOT NULL
);

INSERT INTO test1(number1, number2, value)
select random() * generate_series,
       random() * generate_series,
       generate_series
from generate_series(1, 100000);

CREATE INDEX test1_number1_idx ON test1 (number1);
CREATE INDEX test1_number2_idx ON test1 (number2);

CREATE TABLE test2
(
    id      SERIAL PRIMARY KEY,
    test_id INT REFERENCES test1 (id) NOT NULL,
    number1 INT                       NOT NULL,
    number2 INT                       NOT NULL,
    value   VARCHAR(32)               NOT NULL
);

INSERT INTO test2(test_id,number1, number2, value)
select id,
       random() * number1,
       random() * number2,
       value
from test1;

CREATE INDEX test2_number1_idx ON test2 (number1);
CREATE INDEX test2_number2_idx ON test2 (number2);
