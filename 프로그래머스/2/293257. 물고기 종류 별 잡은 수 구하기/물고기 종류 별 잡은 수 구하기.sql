SELECT COUNT(*) AS FISH_COUNT, N.FISH_NAME
FROM FISH_INFO I LEFT JOIN FISH_NAME_INFO N ON I.FISH_TYPE = N.FISH_TYPE
GROUP BY N.FISH_NAME
ORDER BY FISH_COUNT DESC;

-- [주의]'종류 별' 구하는 것인데, GROUP BY FISH_TYPE(INTEGER타입)이 오류인 이유
-- : FISH_TYPE 하나에 FISH_NAME이 정확히 하나라는 보장이 있냐?” 👉 SQL은 그걸 ‘알 수 없다’고 판단함 (!= 인간, 도메인적으로는 O)
-- SQL은 아래 데이터도 가능하다고 가정함
-- FISH_TYPE | FISH_NAME
-- ----------+----------
-- 0         | BASS
-- 0         | BLACK_BASS

-- 만약, FISH_TYPE로도 GROUP BY를 하고 싶다면?
-- GROUP BY N.FISH_TYPE, N.FISH_NAME
