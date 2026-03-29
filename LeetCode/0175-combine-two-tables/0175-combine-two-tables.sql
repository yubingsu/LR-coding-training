# Write your MySQL query statement below

select 
    p.firstName, 
    p.lastName, 
    IFNULL(a.city, Null) as city, 
    IFNULL(a.state, Null) as state
from person p
left join address a on p.personId = a.personId -- a집합 선택