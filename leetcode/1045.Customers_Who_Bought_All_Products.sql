/* Write your PL/SQL query statement below */

-- Customer table
-- fk : product_key (Product)
-- not null : customer_id

-- Product table
-- pk : product_key

-- output : Product table에 있는 모든 products를 구매한 customer_id
-- Customer table에 pk, unique조건이 없기 때문에 distinct로 중복 제거 후 count 필요
SELECT customer_id
  FROM ( SELECT DISTINCT customer_id, 
                         product_key
           FROM Customer )
GROUP BY customer_id
  HAVING COUNT(product_key) = ( SELECT COUNT(*)
                                  FROM Product )
