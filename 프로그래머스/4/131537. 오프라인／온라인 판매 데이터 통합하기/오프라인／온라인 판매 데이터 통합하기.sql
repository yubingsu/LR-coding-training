-- 코드를 입력하세요
-- 오프라인 판매 데이터는 유저아이디 NULL
-- [문제에서 전해준 핵심!] 동일한 날짜, (회원 ID), 상품 ID 조합에 대해서는 하나의 판매데이터만 존재함
-- > 원하는 것 : 온/오프 모든 행이 합쳐지면 됨. 
-- 상황 : 행을 결합하고 싶을 때. 
-- MYSQL은 FULL JOIN 지원x (힌트 : **결합**)

SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') SALES_DATE,
    PRODUCT_ID, 
    USER_ID, 
    SALES_AMOUNT 
FROM ONLINE_SALE
WHERE DATE_FORMAT(SALES_DATE, '%Y-%m') = '2022-03'
 
UNION ALL
 
SELECT DATE_FORMAT(SALES_DATE, '%Y-%m-%d') AS SALES_DATE,
    PRODUCT_ID, 
    NULL AS USER_ID, 
    SALES_AMOUNT 
FROM OFFLINE_SALE
WHERE DATE_FORMAT(SALES_DATE, '%Y-%m') = '2022-03'

ORDER BY 1,2,3; 