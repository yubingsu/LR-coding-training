# Write your MySQL query statement below

SELECT a.name as Employee
FROM Employee a -- employee 기준
LEFT JOIN Employee b -- manager 기준 
on b.id = a.managerID
WHERE b.salary < a.salary;
