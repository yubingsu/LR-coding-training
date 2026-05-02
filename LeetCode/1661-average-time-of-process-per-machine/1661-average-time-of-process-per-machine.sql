# Write your MySQL query statement below

-- 1. 테이블 구조를 새롭게 바꾼다. start_timestamp와 end_timestamp 행을 만든 후 소요시간 계산
with lt as
(
select machine_id, process_id, max(end_timestamp) - max(start_timestamp) as time_taken
from(
select machine_id, process_id, 
    case when activity_type = 'start' then timestamp end as 'start_timestamp',
    case when activity_type = 'end' then timestamp end as 'end_timestamp'
    from Activity) a
group by machine_id, process_id
) 
-- 2. 평균 계산
select machine_id, round(avg(time_taken), 3) as processing_time
from lt 
group by machine_id



-- [권장풀이]
-- SELECT 
--     a.machine_id,
--     ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time
-- FROM Activity a
-- JOIN Activity b
--     ON a.machine_id = b.machine_id
--     AND a.process_id = b.process_id
-- WHERE a.activity_type = 'start'
--   AND b.activity_type = 'end'
-- GROUP BY a.machine_id;