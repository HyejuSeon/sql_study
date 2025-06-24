/* Write your PL/SQL query statement below */

-- uk : person_id
-- output : 마지막에 탑승한 사람 이름
-- person_id person_name weight turn

-- 807ms
-- SUM() OVER(), rownum
SELECT person_name
  FROM (
        SELECT turn, 
               person_name, 
               weight, 
               SUM(weight) OVER (ORDER BY turn) AS total_weight
          FROM Queue
        ORDER BY turn DESC
        )
WHERE total_weight <= 1000
  AND rownum = 1 ;

-- 867ms
-- SUM() OVER(), FIRST_VALUE()
-- DISTINCT 떄문에 정렬 2번 동작해서 더 비효율적
-- SELECT DISTINCT FIRST_VALUE(person_name) OVER (ORDER BY turn DESC) AS person_name
--   FROM (
--         SELECT turn, 
--                person_name, 
--                weight, 
--                SUM(weight) OVER (ORDER BY turn) AS total_weight
--           FROM Queue
--         )
-- WHERE total_weight <= 1000 ;
