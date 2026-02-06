-- 코드를 입력하세요
SELECT I.NAME, I.DATETIME
FROM ANIMAL_INS I LEFT JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE O.DATETIME IS NULL
ORDER BY I.DATETIME ASC LIMIT 3;

-- LIMIT : 취득하는 레코드의 개수 지정 가능 (그림으로 배우는 데이터베이스 P. 75)
-- 사용1) FROM 테이블 LIMIT 2 : 맨 앞에 있는 2개의 레코드 조회
-- 사용2) ORDER BY 컬럼 LIMIT 2 : 정렬 후 앞에있는 2개 레코드 조회
-- 사용3) FROM 테이블 LIMIT 1 OFFSET 2 : 1개 조회, 3번째 행(2숫자배열)의 값부터 = 3번째 행 조회
