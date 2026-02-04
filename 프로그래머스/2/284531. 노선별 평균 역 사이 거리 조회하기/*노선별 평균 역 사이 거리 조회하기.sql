SELECT ROUTE, 
    CONCAT(ROUND(SUM(D_BETWEEN_DIST), 1),'km') AS TOTAL_DISTANCE, 
    CONCAT(ROUND(AVG(D_BETWEEN_DIST), 2),'km') AS AVERAGE_DISTANCE 
FROM SUBWAY_DISTANCE 
GROUP BY ROUTE
ORDER BY ROUND(SUM(D_BETWEEN_DIST), 1) DESC


# 1. CONCAT : 여러 값을 문자열로 이어 붙이는 함수 
# 입력 : SELECT CONCAT(10, 'km'), 출력 : '10km'
# 2. 문자열 정렬 vs 숫자 정렬 주의
# ORDER BY TOTAL_DISTANCE DESC에서 TAL_DISTANC은 문자열이므로 문자열 기준 정렬됨. 숫자원본 사용
# 3. 소수 둘째자리**에서**반올림 = 소수 첫째자리**까지** 반올림
# ROUND(x, 1) : 소수 첫째자리까지 반올림 = 소수 둘째자리에서 반올림
