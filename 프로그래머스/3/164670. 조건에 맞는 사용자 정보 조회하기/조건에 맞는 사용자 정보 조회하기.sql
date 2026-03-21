
SELECT 
    U.USER_ID, 
    U.NICKNAME, 
    CONCAT(CITY, ' ', STREET_ADDRESS1, ' ',STREET_ADDRESS2) AS '전체주소', 
    CONCAT(SUBSTR(U.TLNO, 1,3),'-',SUBSTR(U.TLNO, 4,4),'-',SUBSTR(U.TLNO, -4)) '전화번호'
FROM USED_GOODS_BOARD B
JOIN USED_GOODS_USER U 
 ON B.WRITER_ID = U.USER_ID
GROUP BY B.WRITER_ID
HAVING COUNT(B.WRITER_ID) >= 3
ORDER BY U.USER_ID DESC;


-- 1. 중고 거래 게시물을 3건 이상 등록한 사용자 구하기 
-- [의견] 이 문제는 JOIN 선행이 더 효율적임! / 결과값이 조건을 만족하는지 중간 점검은 필수!
-- 2. 요구하는 컬럼 조회
-- [주의] 3개의 컬럼을 한번에 CONCAT하지만, 띄어쓰기 삽입 부분 또한 실제 데이터 살펴보며 확인 필요.

