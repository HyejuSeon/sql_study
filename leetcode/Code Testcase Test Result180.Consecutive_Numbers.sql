/* Write your PL/SQL query statement below */

-- pk : id (autoincrement 1~)
-- id num
-- output : 연속적으로 최소 3번 발생한 num

-- 787ms
-- LEAD 함수
-- SELECT DISTINCT num ConsecutiveNums
--   FROM (
--         SELECT id,
--                num,
--                LEAD(num, 1) OVER (ORDER BY id) num2,
--                LEAD(num, 2) OVER (ORDER BY id) num3
--         FROM Logs
--         )
--  WHERE num = num2
--    AND num = num3

-- 945ms
-- LEAD 함수 offset
-- SELECT DISTINCT num ConsecutiveNums
--   FROM (
--         SELECT num,
--                id,
--                LEAD(id, 1) OVER(PARTITION BY num ORDER BY id) id2,
--                LEAD(id, 2) OVER(PARTITION BY num ORDER BY id) id3 
--           FROM Logs
--         )
--  WHERE id3 = id2 + 1
--    AND id2 = id + 1

-- 614ms
-- JOIN 2번
SELECT DISTINCT A.num ConsecutiveNums
  FROM Logs A
  JOIN Logs B ON A.num = B.num AND A.id = B.id - 1
  JOIN Logs C ON A.num = C.num AND A.id = C.id - 2

-- 765ms
-- JOIN 2번
-- SELECT DISTINCT A.num ConsecutiveNums
--   FROM Logs A
--   JOIN Logs B ON A.num = B.num AND A.id = B.id - 1
--   JOIN Logs C ON B.num = C.num AND B.id = C.id - 1

-- 758ms 
-- LEAD 함수 2번 사용, 테이블 스캔 1번
-- SELECT DISTINCT num ConsecutiveNums
--   FROM (
--         SELECT num,
--                id,
--                id2,
--                LEAD(id2) OVER(PARTITION BY num ORDER BY id, id2) id3
--           FROM ( SELECT num,
--                         id,
--                         LEAD(id) OVER(PARTITION BY num ORDER BY id) id2
--                    FROM Logs )
--         )
--  WHERE id3 = id2 + 1
--    AND id2 = id + 1 ;
