/* Write your PL/SQL query statement below */

-- pk : product_id, change_date
-- 모든 물건의 초기값은 10
-- output : 2019-08-16 시점에서 각 product_id와 price

-- 555ms
-- RANK 함수와 UNION ALL
-- SELECT product_id, new_price price
--   FROM (
--         SELECT  product_id,
--                 new_price,
--                 change_date,
--                 RANK() OVER (PARTITION BY product_id ORDER BY change_date) rnk
--           FROM (
--                 SELECT  product_id,
--                         new_price,
--                         change_date,
--                         RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) rnk
--                   FROM  Products
--                  WHERE  change_date <= '2019-08-16'
--                 UNION ALL
--                 SELECT  product_id,
--                         10,
--                         change_date,
--                         1
--                   FROM  Products
--                  WHERE  change_date > '2019-08-16'
--                )
--          WHERE rnk = 1 
--         )
--  WHERE rnk = 1 ;

-- 529ms
-- FIRST_VALUE 함수, UNION
-- FIRST_VALUE는 각 로우의 첫 번째 값이 리턴됨 -> UNION으로 중복 제거된 것
-- DISTINCT + DISTINCT + UNION ALL 보다 UNION 이 더 빠름
SELECT product_id,
       FIRST_VALUE(new_price) OVER (PARTITION BY product_id ORDER BY change_date DESC) price
  FROM Products
 WHERE change_date <= '2019-08-16'
UNION
SELECT product_id,
       10 price
  FROM Products
 WHERE product_id NOT IN (
                            SELECT product_id
                            FROM Products
                            WHERE change_date <= '2019-08-16'
                        ) ;

-- 550ms
-- SELECT product_id,
--        10 AS price
--   FROM Products
-- GROUP BY product_id
-- HAVING MIN(change_date) > '2019-08-16'
-- UNION ALL
-- SELECT product_id, 
--        new_price AS price
--   FROM Products
--  WHERE (product_id, change_date) IN ( SELECT product_id, MAX(change_date)
--                                         FROM Products
--                                        WHERE change_date <= '2019-08-16'
--                                       GROUP BY product_id )


-- 607ms
-- UNION 보다 UNION ALL + DISTINCT 가 더 빠름
-- SELECT product_id,
--        10 AS price
--   FROM Products
-- GROUP BY product_id
--   HAVING MIN(change_date) > '2019-08-16'
-- UNION ALL
-- SELECT DISTINCT product_id,
--        FIRST_VALUE(new_price) OVER (PARTITION BY product_id ORDER BY change_date DESC) AS price
--   FROM Products
--  WHERE change_date <= '2019-08-16' ;

