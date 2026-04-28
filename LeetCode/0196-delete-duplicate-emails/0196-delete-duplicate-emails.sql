# Write your MySQL query statement below

-- SELECT email
-- FROM Person
-- GROUP BY email

DELETE P1
FROM person P1, person P2
where P1.email = P2.email AND P1.id > P2.id;