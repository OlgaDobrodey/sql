CREATE
    DATABASE flight_repository;

CREATE TABLE IF NOT EXISTS airport
(
    code    CHAR(3) PRIMARY KEY,
    country VARCHAR(128) NOT NULL,
    city    VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS aircraft
(
    id    SERIAL PRIMARY KEY,
    model VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS seat
(
    aircraft_id INT REFERENCES aircraft (id),
    seat_no     VARCHAR(4) NOT NULL,
    PRIMARY KEY (aircraft_id, seat_no)
);

CREATE TABLE IF NOT EXISTS flight
(
    id                     BIGSERIAL PRIMARY KEY,
    flight_no              VARCHAR(16)                       NOT NULL,
    departure_date         TIMESTAMP                         NOT NULL,
    departure_airport_code CHAR(3) REFERENCES airport (code) NOT NULL,
    arrival_date           TIMESTAMP                         NOT NULL,
    arrival_airport_code   CHAR(3) REFERENCES airport (code) NOT NULL,
    aircraft_id            INT REFERENCES aircraft (id)      NOT NULL,
    status                 VARCHAR(32)                       NOT NULL
);

CREATE TABLE IF NOT EXISTS ticket
(
    id             BIGSERIAL PRIMARY KEY,
    passenger_no   VARCHAR(32)                   NOT NULL,
    passenger_name VARCHAR(128)                  NOT NULL,
    flight_id      BIGINT REFERENCES flight (id) NOT NULL,
    seat_no        VARCHAR(4) NOT NULL ,
    cost           NUMERIC(8,2)
);