-- 사원별 성과금 정보 조회
-- 평가 점수는 두 반기의 평균 점수로 구해야함*** 이걸 몰라서 몇번의 시도를 헤멨는지!!! ... ;; 

-- 1ST. 사원별 (최신) 성과금 등급 책정
WITH GT AS (
SELECT E.EMP_NO, E.EMP_NAME, E.SAL,
    CASE WHEN AVG(G.SCORE) >= 96 THEN 'S'
        WHEN AVG(G.SCORE) >= 90 AND AVG(G.SCORE) < 96 THEN 'A'
        WHEN AVG(G.SCORE) >= 80 AND AVG(G.SCORE) < 90 THEN 'B'
        ELSE 'C' END AS 'GRADE'
FROM HR_EMPLOYEES E
RIGHT JOIN HR_GRADE G ON E.EMP_NO = G.EMP_NO
GROUP BY E.EMP_NO, E.EMP_NAME, E.SAL
)
-- 2ND. 등급에 따른 성과금 계산
SELECT EMP_NO, EMP_NAME, GRADE, 
    CASE GRADE
        WHEN 'S' THEN SAL * 0.2
        WHEN 'A' THEN SAL * 0.15
        WHEN 'B' THEN SAL * 0.1
        ELSE 0 END AS 'BONUS'
FROM GT
ORDER BY 1;








-- 최신 오답 (260421)
-- 1ST. 사원별 (최신) 성과금 등급 책정
# WITH GT AS (
# SELECT E.EMP_NO, E.EMP_NAME, E.SAL,
#     CASE WHEN G.SCORE >= 96 THEN 'S'
#         WHEN G.SCORE >= 90 AND G.SCORE < 96 THEN 'A'
#         WHEN G.SCORE >= 80 AND G.SCORE < 90 THEN 'B'
#         ELSE 'C' END AS 'GRADE'
# FROM HR_EMPLOYEES E
# RIGHT JOIN HR_GRADE G ON E.EMP_NO = G.EMP_NO
# WHERE -- 최신 평가 정보 조회
#     YEAR = (SELECT MAX(YEAR) FROM HR_GRADE) AND
#     HALF_YEAR = (SELECT MAX(HALF_YEAR) FROM HR_GRADE)
# GROUP BY E.EMP_NO, E.EMP_NAME, E.SAL
# )
# -- 2ND. 등급에 따른 성과금 계산
# SELECT EMP_NO, EMP_NAME, GRADE, 
#     CASE GRADE
#         WHEN 'S' THEN SAL * 0.2
#         WHEN 'A' THEN SAL * 0.15
#         WHEN 'B' THEN SAL * 0.1
#         ELSE 0 END AS 'BONUS'
# FROM GT
# ORDER BY 1;


-- [기타 풀이]
-- 최신 정보 구하기 방법 생각(WHERE 조건) : 1) HALF_YEAR = '2', 2) GROUP BY EMP_NO, EMP_NAME한다음, MAX(날짜)
-- > 최신을 구하는데 위의 방법은 적절하지 않음. 샘플이 2로 나와있는 것이 실제로는 2022 이상의 연도 존재 -> MAX 사용
-- > 사원별로 최신평가가 다를 수 있으므로 WHERE 조건이 아닌, GROUP BY 조건 내에 사용해야함

# 오답 풀이 (최신 조건 필터링 잘못함)
-- 1ST. 사원별 (최신) 성과금 등급 책정
# WITH GT AS (
# SELECT E.EMP_NO, E.EMP_NAME, E.SAL,
#     CASE WHEN G.SCORE >= 96 THEN 'S'
#         WHEN G.SCORE >= 90 AND G.SCORE < 96 THEN 'A'
#         WHEN G.SCORE >= 80 AND G.SCORE < 90 THEN 'B'
#         ELSE 'C' END AS 'GRADE'
# FROM HR_EMPLOYEES E
# RIGHT JOIN HR_GRADE G ON E.EMP_NO = G.EMP_NO
# WHERE -- 최신 평가 정보 조회
#     YEAR = (SELECT MAX(YEAR) FROM HR_GRADE) AND
#     HALF_YEAR = (SELECT MAX(HALF_YEAR) FROM HR_GRADE)
# GROUP BY E.EMP_NO, E.EMP_NAME, E.SAL
# )
# -- 2ND. 등급에 따른 성과금 계산
# SELECT EMP_NO, EMP_NAME, GRADE, 
#     CASE GRADE
#         WHEN 'S' THEN SAL * 0.2
#         WHEN 'A' THEN SAL * 0.15
#         WHEN 'B' THEN SAL * 0.1
#         ELSE 0 END AS 'BONUS'
# FROM GT
# ORDER BY 1;




# -- 방법2
# WITH GRADE_TB AS 
# (SELECT E.EMP_NO, E.EMP_NAME, MAX(HALF_YEAR),
# CASE 
#     WHEN G.SCORE >= 96 THEN 'S'
#     WHEN G.SCORE >= 90 THEN 'A'
#     WHEN G.SCORE >= 80 THEN 'B'
#     ELSE 'C' END AS GRADE
# FROM HR_DEPARTMENT D
# JOIN HR_EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID -- > E 레벨로
# JOIN HR_GRADE G ON E.EMP_NO = G.EMP_NO
# GROUP BY E.EMP_NO, E.EMP_NAME
# )
# SELECT EMP_NO, EMP_NAME, GRADE,
# CASE 
#     WHEN GRADE = 'S' THEN SAL * 0.2
#     WHEN GRADE = 'A' THEN SAL * 0.15
#     WHEN GRADE = 'B' THEN SAL * 0.1
#     WHEN GRADE = 'C' THEN SAL * 0
#     END AS BONUS
# FROM GRADE_TB
# ORDER BY EMP_NO ASC;


-- 방법1    
# WITH GRADE_TB AS 
# (SELECT E.EMP_NO, E.EMP_NAME, E.SAL,
# CASE 
#     WHEN G.SCORE >= 96 THEN 'S'
#     WHEN G.SCORE >= 90 THEN 'A'
#     WHEN G.SCORE >= 80 THEN 'B'
#     ELSE 'C' END AS GRADE
# FROM HR_DEPARTMENT D
# JOIN HR_EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID -- > E 레벨로
# JOIN HR_GRADE G ON E.EMP_NO = G.EMP_NO
# WHERE HALF_YEAR = '2'
# )
# SELECT EMP_NO, EMP_NAME, GRADE,
# CASE 
#     WHEN GRADE = 'S' THEN SAL * 0.2
#     WHEN GRADE = 'A' THEN SAL * 0.15
#     WHEN GRADE = 'B' THEN SAL * 0.1
#     WHEN GRADE = 'C' THEN SAL * 0
#     END AS BONUS
# FROM GRADE_TB
# ORDER BY EMP_NO ASC;




# 질문 : ELSE THEN SAL * 0 END AS BONUS 은 불가능한가? 마지막 마무리는 어떻게 하는 게 좋을지
# 아래처럼 CASE를 두개 정의하는 것은 안되는 것인지? 

# WITH GRADE_TB AS 
# (SELECT E.EMP_NO, E.EMP_NAME, E.SAL,
# CASE 
#     WHEN G.SCORE >= 96 THEN 'S'
#     WHEN G.SCORE >= 90 THEN 'A'
#     WHEN G.SCORE >= 80 THEN 'B'
#     ELSE 'C' END AS GRADE,
#  CASE 
#     WHEN GRADE = 'S' THEN SAL * 0.2
#     WHEN GRADE = 'A' THEN SAL * 0.15
#     WHEN GRADE = 'B' THEN SAL * 0.1
#     WHEN GRADE = 'C' THEN SAL * 0
#     END AS BONUS
# FROM HR_DEPARTMENT D
# JOIN HR_EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID -- > E 레벨로
# JOIN HR_GRADE G ON E.EMP_NO = G.EMP_NO)

# SELECT *
# FROM GRADE_TB