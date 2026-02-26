-- 코드를 입력하세요
-- SOL1) CTE(WITH) 사용

with junbeom as
(select max(views) as k
from USED_GOODS_BOARD )

select CONCAT('/
from USED_GOODS_BOARD a join USED_GOODS_FILE b on a.BOARD_ID= b.BOARD_ID
where a.views in(select k from junbeom) ;
    
-- SOL2) 
SELECT 
    CONCAT('/home/grep/src/', F.BOARD_ID, '/', F.FILE_ID, F.FILE_NAME, F.FILE_EXT) AS FILE_PATH
FROM 
    (SELECT *
    FROM USED_GOODS_BOARD
    WHERE VIEWS = (SELECT max(VIEWS) FROM USED_GOODS_BOARD)
    ) T
JOIN USED_GOODS_FILE F 
ON F.BOARD_ID = T.BOARD_ID
ORDER BY F.FILE_ID DESC;

-- [CONCAT]
-- 1) CONCAT은 문자열을 순서대로 이어 붙이는 함수다.
-- 2) NULL이 하나라도 있으면 결과는 NULL이다.
-- 예시1  CONCAT('A', COALESCE(col, ''), 'B')
-- 예시2  CONCAT('/home/', BOARD_ID, '/', FILE_NAME)

-- CF) 구분자 붙이기 귀찮을 때 : CONCAT_WS
-- CONCAT_WS('/', 'home', 'grep', 'src') 
-- 결과 home/grep/src
