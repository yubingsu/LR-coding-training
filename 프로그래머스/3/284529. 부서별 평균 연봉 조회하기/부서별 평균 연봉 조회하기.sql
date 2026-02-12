-- 코드를 작성해주세요
SELECT D.DEPT_ID, D.DEPT_NAME_EN, ROUND(AVG(E.SAL),0) AS AVG_SAL
FROM HR_DEPARTMENT D JOIN HR_EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_NAME_EN, D.DEPT_ID
ORDER BY AVG_SAL DESC 

-- [중요1] SELECT에 집계함수(AVG 등)가 아닌 컬럼은 반드시 GROUP BY에 있어야 한다.
-- (내 기존 코드) GROUP BY D.DEPT_NAME_KR, D.DEPT_NAME_EN, D.DEPT_ID 에서, GROUP BY D.DEPT_NAME_EN, D.DEPT_ID로 수정

-- [참고] GROUP BY뒤에 넣는 컬럼의 순서는 정렬에 상관이 없음

-- [수정2]  RIGHT JOIN 대신 (inner) join 사용하기
-- HR_EMPLOYEES.DEPT_ID는 HR_DEPARTMENT.DEPT_ID를 참조하므로 매칭되지 않는 직원 데이터가 발생하지 않음 = 직원은 반드시 존재하는 부서에 속하므로 결과 동일
-- 두 조인의 결과값은 동일하므로, INNER JOIN 사용
-- cf) RIGHT JOIN 이 필요한 경우 : 직원이 없는 부서도 포함해서 ~ 
