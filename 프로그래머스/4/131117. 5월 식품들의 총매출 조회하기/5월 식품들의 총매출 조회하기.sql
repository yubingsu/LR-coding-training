-- 매출 : 수량 * 가격!!
-- 주의 : 입고된 공장은 다르나, 상품명과 상품ID가 같은 상품이 존재했음 (마요네즈). 다른 입고 공장이라도, 같은 상품이므로 SUM()으로 해당 상품의 총수량을 구한 후, 매출을 구한다.  
SELECT p.PRODUCT_ID, p.PRODUCT_NAME, P.PRICE * SUM(O.AMOUNT) AS TOTAL_SALES
FROM FOOD_PRODUCT P
    JOIN FOOD_ORDER O 
    ON P.PRODUCT_ID = O.PRODUCT_ID
WHERE DATE_FORMAT(O.PRODUCE_DATE, '%Y-%m') = '2022-05'
GROUP BY P.PRODUCT_ID
ORDER BY TOTAL_SALES DESC, P.PRODUCT_ID ASC 
