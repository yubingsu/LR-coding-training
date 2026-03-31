-- 코드를 입력하세요
-- [관건] 성별 정보가 없는 경우 결과에서 제외?? 어떻게?? -> 서브쿼리 -> 원하는대로 안걸러짐
-- [힌트1] 집계 전에 걸러라 (GPT) -> WHERE
-- [힌트2] 여기서 뭔가를 추가해야함! 거의 다 왔음..

SELECT 
    YEAR(O.SALES_DATE) AS YEAR, 
    MONTH(O.SALES_DATE) AS MONTH, 
    U.GENDER, 
    COUNT(DISTINCT U.USER_ID) AS USERS
FROM USER_INFO U
JOIN ONLINE_SALE O
    ON U.USER_ID = O.USER_ID -- O 레벨(M)
WHERE U.GENDER IS NOT NULL
GROUP BY 
    YEAR(O.SALES_DATE), 
    MONTH(O.SALES_DATE), 
    U.GENDER
ORDER BY 1,2,3;




-- 아래 코드의 경우, GENDER IS NOT NULL AS GENDER로 걸러지지 않았음.
# SELECT 
#     YEAR(O.SALES_DATE) AS YEAR, 
#     MONTH(O.SALES_DATE) AS MONTH, 
#     U.GENDER, 
#     COUNT(O.USER_ID) AS USERS
# FROM 
#     (SELECT USER_ID, GENDER IS NOT NULL AS GENDER 
#      FROM USER_INFO) U
# JOIN ONLINE_SALE O
#     ON U.USER_ID = O.USER_ID -- O 레벨(M)
# GROUP BY 
#     YEAR(O.SALES_DATE), 
#     MONTH(O.SALES_DATE), 
#     U.GENDER
# ORDER BY 1,2,3