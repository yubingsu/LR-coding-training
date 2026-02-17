-- 코드를 입력하세요
SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_INS I 
    JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
ORDER BY (O.DATETIME - I.DATETIME) DESC 
    LIMIT 2;

-- 1)
-- '입양을 간 동물중' -> 입양 기록이 존재하는 동물만 조회 : ANIMAL_OUTS가 외래키이므로 INNER JOIN으로 자동 필터링 가능

-- 2) ***
-- ORDER BY는 논리적 실행 순서상 SELECT 이후 단계이므로, SELECT에 포함되지 않은 컬럼/계산식이라도 FROM/JOIN 단계에서 존재한다면 사용 가능
-- **주의 : ORDER BY는 “출력 컬럼을 만드는 단계”가 아니라 “이미 만들어진 결과 집합을 정렬하는 단계”, SELECT에 포함된 계산식 및 컬럼 조회 / 포함x인 컬럼은 '출력 제한'

-- 3)
-- 생성한 별칭(PREIOD)을 ORDER BY에 쓸 때 DB에 따라 인식이 다를 수 있음. 안전하게는 ORDER BY (O.DATETIME - I.DATETIME) 또는 바깥에서 정렬

-- 4)
-- 서브 쿼리 내부 + 정렬 사용 비권장 (서브쿼리 내부의 ORDER BY는 의미가 불안정/DB에 따라 제한되기 때문)
-- 정렬 + TOP N 조회(ORDER BY + LIMIT)는 같은 레벨에서 함께 사용 권장 

-- 참고) 서브쿼리를 사용하고 싶다면 (비권장)
SELECT P.ANIMAL_ID, P.NAME
FROM (
  SELECT O.ANIMAL_ID, O.NAME, (O.DATETIME - I.DATETIME) AS PERIOD
  FROM ANIMAL_INS I
  JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
) P
ORDER BY P.PERIOD DESC
LIMIT 2;
