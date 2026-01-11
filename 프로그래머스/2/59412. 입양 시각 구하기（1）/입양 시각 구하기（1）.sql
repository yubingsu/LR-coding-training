-- 코드를 입력하세요
SELECT DATE_FORMAT(DATETIME, '%H') AS HOUR, COUNT(*) AS COUNT
FROM ANIMAL_OUTS
WHERE DATE_FORMAT(DATETIME, '%H') >= 9 AND DATE_FORMAT(DATETIME, '%H') < 20
GROUP BY DATE_FORMAT(DATETIME, '%H')
ORDER BY HOUR


# 더 깔끔한 코드
## ver1 DATE_FORMAT
# WHERE DATE_FORMAT(datetime, '%H') bewteen 09 and 19 (9이상 19이하)
# %H : 24시간 기준, %h : 12시간 기준

## ver2 HOUR
# WHERE HOUR(datetime) bewteen 09 and 19
