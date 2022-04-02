CREATE
    DATABASE flight_repository;

CREATE TABLE IF NOT EXISTS airport
(
    code    INT PRIMARY KEY,
    country VARCHAR(128),
    city    VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS aircraft
(
    id    INT PRIMARY KEY,
    model VARCHAR(128) UNIQUE
);

CREATE TABLE seat
(
    aircraft_id INT PRIMARY KEY,
    seat_no     VARCHAR UNIQUE
);

CREATE TABLE flight
(
    id                     INT PRIMARY KEY,
    flight_no              INT,
    departure_date         TIMESTAMP,
    departure_airport_code INT,
    arrival_date           TIMESTAMP,
    arrival_airport_code   INT,
    aircraft_id            INT,
    status                 VARCHAR
);

CREATE TABLE ticket
(
    id             INT PRIMARY KEY,
    passenger_name VARCHAR(128),
    flight_id      INT,
    seat_no        VARCHAR(128),
    cost           INT,
    UNIQUE (flight_id, seat_no)
);

