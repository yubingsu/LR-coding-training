# Write your MySQL query statement below

SELECT a.id AS Id
FROM Weather a
JOIN  Weather b
ON DATEDIFF(a.recordDate, b.recordDate)=1
WHERE a.temperature> b.temperature


-- SELECT a.id
-- FROM 
--     (SELECT 
--         id, 
--         recordDate, 
--         temperature, 
--         DATE_FORMAT(recordDate-1, '%Y-%m-%d') as yest
--     FROM Weather) a 
-- LEFT JOIN Weather b on b.recordDate = a.yest
-- WHERE a.temperature > IFNULL(b.temperature,0)



-- SELECT 
--     id, 
--     temperature,
--     MAX(temperature) OVER (ORDER BY recordDate ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS result
--     CASE 
--     WHEN (temperature )
-- FROM Weather
