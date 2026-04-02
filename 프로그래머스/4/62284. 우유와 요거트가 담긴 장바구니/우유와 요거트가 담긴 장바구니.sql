-- 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지

-- sol1) 장바구니로 그룹핑한 후에 우유/요거트 찾기

-- sol2) 요거트/밀크끼리 가져온 다음에, 각각 장바구니 둘다 있는지 찾기
SELECT Y.CART_ID
FROM 
(SELECT CART_ID, NAME
FROM CART_PRODUCTS
WHERE NAME = 'Yogurt') Y
JOIN 
(SELECT CART_ID, NAME
FROM CART_PRODUCTS
WHERE NAME = 'Milk') M
ON Y.CART_ID = M.CART_ID
GROUP BY Y.CART_ID
ORDER BY CART_ID ASC;

-- 아래 쿼리 오답 이유 : Milk가 2개 들어간 경우 존재함
# SELECT CART_ID
# FROM CART_PRODUCTS
# WHERE NAME IN ('Yogurt', 'Milk')
# GROUP BY CART_ID
# HAVING COUNT(CART_ID) >=2 
# ORDER BY CART_ID ASC;

-- 갑자기 헷갈림 : WHERE이 행단위였지? 

