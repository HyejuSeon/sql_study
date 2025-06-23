/* Write your PL/SQL query statement below */

-- Customer table
-- fk : product_key (Product)
-- not null : customer_id

-- Product table
-- pk : product_key

-- output : Product table에 있는 모든 products를 구매한 customer_id

-- sol1은 데이터를 최초로 읽을 때 distinct를 사용해서 정렬 후 중복 제거 -> 더 빠름
-- sol2는 customer_id 별로 정렬 후 중복 제거

-- Customer table에 pk, unique조건이 없기 때문에 distinct로 중복 제거 후 count 필요
-- sol1)
SELECT customer_id
  FROM ( SELECT DISTINCT customer_id, product_key
           FROM Customer )
GROUP BY customer_id
  HAVING COUNT(product_key) = ( SELECT COUNT(*)
                                  FROM Product ) ; 

-- sol2)
-- SELECT customer_id
--   FROM Customer
-- GROUP BY customer_id
--   HAVING COUNT(DISTINCT product_key) = ( SELECT COUNT(*)
--                                            FROM Product ) ;
