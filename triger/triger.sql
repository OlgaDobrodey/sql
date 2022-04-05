--- before

insert into aircraft (model)
values ('new boeing');

--- after


create table audit
(
    id         INT,
    table_name TEXT,
    date       TIMESTAMP
);

create or replace function audit_function() returns trigger
    language plpgsql
AS
$$
begin
    insert into audit (id, table_name, date)
    values (new.id, tg_table_name, now());
    return null;
end;
$$;

create trigger audit_aircraft_trigger
    AFTER UPDATE OR INSERT OR DELETE
    ON aircraft
    FOR EACH ROW
EXECUTE FUNCTION audit_function();

insert into aircraft (model)
values ('новый боинг');

select *
from audit;