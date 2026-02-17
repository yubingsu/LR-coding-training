-- 코드를 입력하세요
SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_INS I 
    JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
ORDER BY (O.DATETIME - I.DATETIME) DESC 
    LIMIT 2;


# SELECT P.ANIMAL_ID, P.NAME
# FROM (
#   SELECT O.ANIMAL_ID, O.NAME, (O.DATETIME - I.DATETIME) AS PERIOD
#   FROM ANIMAL_INS I
#   JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
# ) P
# ORDER BY P.PERIOD DESC
# LIMIT 2;

-- 
-- '입양을 간 동물중' = 입양기록O (INNER JOIN ㄱㄴ. 자동으로 필터링 되니까)
-- 서브쿼리 안 ORDER BY는 의미가 불안정/DB에 따라 제한 :  정렬 + LIMIT은 같은 레벨에서 같이 쓰는 게 정석.
-- PREIOD로 alias를 만들었는데, 이걸 ORDER BY에 쓸 때 DB에 따라 alias 인식이 다를 수 있어. 안전하게는 ORDER BY (O.DATETIME - I.DATETIME) 또는 바깥에서 정렬