# Write your MySQL query statement below
-- 목적 : The confirmation rate of a user 
-- SOL1) WHERE절로 confirmed 개수를 가진 컬럼 생성
-- 1. confirmation가 있는 컬럼 만들기

-- [확정풀이]
-- confirmed 만 있는 컬럼 생성 -> 테이블화(서브 쿼리)
-- 지표 한번에 계산

SELECT user_id, IFNULL(ROUND(SUM(is_confirmed)/COUNT(action), 2),0) AS confirmation_rate
FROM (
SELECT S.user_id, C.action, CASE action WHEN 'confirmed' THEN 1 ELSE 0 END AS 'is_confirmed'
FROM Signups S 
LEFT JOIN Confirmations C ON S.user_id = C.user_id -- C 레벨
) CT
GROUP BY user_id
ORDER BY 2;