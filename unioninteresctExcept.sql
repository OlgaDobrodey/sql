values (1,2),(3,4),(5,6),(7,8)
union
values (1,2),(3,4),(5,6),(7,8), (5,4);
-- 7,8
-- 5,6
-- 1,2
-- 3,4
-- 5,4


values (1,2),(3,4),(5,6),(7,8)
union All
values (1,2),(3,4),(5,6),(7,8);

-- 1,2
-- 3,4
-- 5,6
-- 7,8
-- 1,2
-- 3,4
-- 5,6
-- 7,8

values (1,2),(3,4),(5,6),(7,8)
intersect
values (1,2),(5,6),(7,8);

--пересечение
-- 7,8
-- 5,6
-- 1,2


values (1,2),(5,4),(5,8),(7,8)
intersect
values (1,2),(3,4),(5,6),(7,8);

-- 1,2
-- 7,8

values (1,2),(3,4),(5,6),(7,8)
except
values (1,2),(3,4),(5,6),(7,8);
--вычитает из одного в другого
--empty


