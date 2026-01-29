-- 정답
SELECT CAR_TYPE, COUNT(*) AS CARS
FROM CAR_RENTAL_COMPANY_CAR 
WHERE OPTIONS LIKE '%통풍시트%' 
    OR OPTIONS LIKE '%열선시트%' 
    OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE

# 1. 
# VARCHAR(n) 가변길이문자열, 최대 n글자까지 작성 
# CHAR(n) 고정길이문자열, n글자 미만이면 공백

# 2. 
# IN 조건 표현 연산자 : 여러 값 중 하나만 있어도 출력, **값이 하나만** 들어있을 때 사용
# - 오류 코드 WHERE OPTION IN ('통풍시트', '열선시트', '가죽시트') : 하나의 값에 '통풍시트'하나의 요소가 있으면 반환하는 것임
# LIKE 연산자 : 값이 **여러 문자열로 묶여있을 때** 사용
# - %의 의미(와일드카드 문자) : 0개 이상의 문자
