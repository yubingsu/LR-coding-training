
-- 서브쿼리까지 쓸 필요 없음

SELECT I.REST_ID, I.REST_NAME, I.FOOD_TYPE, I.FAVORITES, I.ADDRESS, 
ROUND(AVG(R.REVIEW_SCORE), 2) AS SCORE
FROM REST_INFO I 
JOIN REST_REVIEW R
ON I.REST_ID = R.REST_ID
WHERE I.ADDRESS LIKE '서울%'
GROUP BY I.REST_ID
ORDER BY AVG(R.REVIEW_SCORE) DESC, I.FAVORITES DESC;

-- [참고] '서울%' : (O), '%서울%' : (X)
-- [이유1] 서울 주소는 항상 문자열 맨 앞이 '서울'로 시작함. '%서울'을 허용한다면, '경기도 고양시 서울로 123'와 같은 이상치 데이터가 포함될 수 있음
-- [이유2] 와일드카드가 문자열 맨 앞에 있을 경우, 인덱스로써의 검색 효율 저하됨