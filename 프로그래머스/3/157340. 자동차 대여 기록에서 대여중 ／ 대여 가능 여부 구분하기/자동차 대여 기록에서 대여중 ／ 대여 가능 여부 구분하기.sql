# [학습 : CASE 사용]
# (1) 값 비교 : CASE 기준값 WHEN 값1 THEN 결과1 -> 기준값 = '값' ? (= 만 ㄱㄴ)
# (2) 조건 비교 : CASE WHEN 조건1 THEN 결과1 -> 조건1이 참? (<, >, BETWEEN, IS NULL ㄱㄴ)

-- 주의!
-- 오류 코드
-- CASE END_DATE : **차이지점 : CASE옆에 컬럼명 작성
--    WHEN END_DATE < '2022-10-16' THEN '대여 가능'
--    ELSE '대여중' END AS AVAILABILITY
-- 설명 : CASE 옆에 컬럼명 작성할 경우 -> 단순 CASE문법으로 WHEN 뒤를 값(조건 만족 0,1)로 반환

SELECT 
    CAR_ID,
    CASE 
        WHEN MAX(
            START_DATE <= '2022-10-16' 
            AND END_DATE >= '2022-10-16'
        ) = 1 THEN '대여중'
        ELSE '대여 가능'
    END AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC;


-- [온갖풀이 다해봄;;]
-- <시도1>
-- 코드를 입력하세요
# SELECT CAR_ID, 
# CASE 
#     WHEN DATE_FORMAT(START_DATE, '%Y-%m-%d') < '2022-10-16' 
#         AND DATE_FORMAT(END_DATE, '%Y-%m-%d') > '2022-10-16' THEN '대여 가능'
#         ELSE '대여중' END AS AVAILABILITY
# FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
# GROUP BY CAR_ID
# ORDER BY CAR_ID DESC;



-- <시도2>
# WITH RT AS
# (SELECT *, RANK() OVER (PARTITION BY CAR_ID ORDER BY HISTORY_ID DESC) AS RNK
# FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
# ORDER BY HISTORY_ID)

# SELECT CAR_ID,
# CASE WHEN DATE_FORMAT(START_DATE, '%Y-%m-%d') <= '2022-10-16' 
#     AND DATE_FORMAT(END_DATE, '%Y-%m-%d') >= '2022-10-16' THEN '대여중'
#     ELSE '대여 가능' END AS AVAILABILITY
# FROM RT
# WHERE RNK = 1
# ORDER BY CAR_ID DESC;

-- [수차례 시행 착오 후 데이터 해석 시 어려웠던 점 발견]
-- 예시에서, HISTORY_ID가 후자인 것이 최신값, 즉, car_id 2는 마지막행이 최신 -> 대여중
-- > RNK 를 떠올렸다 !