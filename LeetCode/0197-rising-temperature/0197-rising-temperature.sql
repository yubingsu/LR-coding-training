-- sol2) Self Join + DATEDIFF (정답 풀이)
SELECT a.id AS Id
FROM Weather a
JOIN Weather b
ON DATEDIFF(a.recordDate, b.recordDate) = 1
WHERE a.temperature > b.temperature;

-- [해설]
-- DATEDIFF = 1을 통해 정확히 "전날" 데이터만 매칭
-- 해당 전날 대비 온도가 상승한 경우만 필터링
-- 문제 의도와 정확히 일치하는 정석 풀이


-- -- [오답풀이1] 윈도우 함수 (누적 최대값 비교)
-- SELECT a.id
-- FROM  
-- (
--     SELECT 
--         id, 
--         recordDate, 
--         MAX(temperature) OVER (
--             ORDER BY recordDate 
--             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
--         ) AS high_temp
--     FROM Weather
-- ) a
-- JOIN Weather b ON a.id = b.id
-- WHERE a.high_temp = b.temperature;

-- -- [기존 풀이 오답 이유]
-- -- 이 로직은 "전날과 비교"가 아니라 "과거 전체 중 최고 온도"를 구하는 방식임
-- -- 즉, 비교 대상이 전날이 아니라 누적 최대값이라 문제 요구와 다름
-- -- 결과적으로 "최고 온도 갱신일"을 찾는 문제가 되어버림





-- -- [오답풀이3] 날짜 계산 + LEFT JOIN + IFNULL
-- SELECT a.id
-- FROM 
-- (
--     SELECT 
--         id, 
--         recordDate, 
--         temperature, 
--         DATE_FORMAT(recordDate - 1, '%Y-%m-%d') AS yest
--     FROM Weather
-- ) a 
-- LEFT JOIN Weather b ON b.recordDate = a.yest
-- WHERE a.temperature > IFNULL(b.temperature, 0);

-- -- [기존 풀이 오답 이유]
-- -- 1) recordDate - 1은 올바른 날짜 연산이 아님 (DATE_SUB 써야 함)
-- --    → MySQL에서 날짜를 숫자처럼 빼면 암묵적 형변환 발생
-- -- 2) IFNULL(b.temperature, 0) 처리로 인해 전날 데이터가 없는 경우도 포함됨
-- --    → 예: 첫 번째 날짜도 0과 비교되어 결과에 포함되는 오류 발생
-- -- 즉, "전날이 존재하는 경우만 비교"라는 조건을 깨버림