# Write your MySQL query statement below
-- each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day
-- (반대도 있음)

-- 1) oper 조건 걸기
-- 2) stock_name기준으로 그룹바이 -> sum


SELECT stock_name, sum(price_gl) AS capital_gain_loss
FROM
(
SELECT *,
CASE WHEN operation = 'Sell' THEN price
     WHEN operation = 'Buy' THEN (-1) *price 
     END AS price_gl
FROM Stocks) s
GROUP BY stock_name;

