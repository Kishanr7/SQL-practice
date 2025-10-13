-- # Write your MySQL query statement below
select e1.name as name
from 
employee e1 left join employee e2 on e2.managerId = e1.id
group by e1.id
having count(e1.id) >= 5