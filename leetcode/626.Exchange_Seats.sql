/* Write your PL/SQL query statement below */

-- pk : id (increments 1~)
-- output : 
-- id student

-- 429ms 
-- LEAD(), LAG() 함수
-- SELECT NVL(B.new_id, A.id) AS id, 
--        A.student
--   FROM Seat A
-- LEFT OUTER JOIN (
--     SELECT id, 
--            CASE MOD(id, 2) WHEN 0 THEN LAG(id) OVER (ORDER BY id)
--                            WHEN 1 THEN LEAD(id) OVER (ORDER BY id)
--            END AS new_id
--       FROM Seat
-- ) B ON A.id = B.id 
-- ORDER BY id ;


-- 548ms
-- LEAD(), LAG() 함수
-- SELECT id,
--        NVL( CASE MOD(id, 2) WHEN 0 THEN LAG(student) OVER (ORDER BY id)
--                             WHEN 1 THEN LEAD(student) OVER (ORDER BY id)
--             END, student ) student
--   FROM Seat 
-- ORDER BY id ;

-- 422ms
-- LEAD(), LAG() 함수
SELECT CASE MOD(id, 2) WHEN 0 THEN LAG(id) OVER (ORDER BY id)
                       WHEN 1 THEN LEAD(id, 1, id) OVER (ORDER BY id)
       END id,
       student
  FROM Seat 
ORDER BY id ;
