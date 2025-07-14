/* Write your PL/SQL query statement below */

-- pk: requester_id, accepter_id
-- output: id, num
--         who have the most friends

-- SELECT id,
--        num
--   FROM (
--     SELECT id, 
--            count(*) num
--       FROM (
--         SELECT requester_id AS id,
--                accepter_id AS id2
--           FROM RequestAccepted
--         UNION
--         SELECT accepter_id AS id,
--                requester_id AS id2
--           FROM RequestAccepted
--       )
--     GROUP BY id
--     ORDER BY num DESC
--   )
-- WHERE rownum = 1
-- ;


SELECT id,
       num
  FROM (
    SELECT id, 
           FIRST_VALUE(COUNT(*)) OVER(ORDER BY COUNT(*) DESC) num
      FROM (
        SELECT requester_id AS id
          FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS id
          FROM RequestAccepted
      )
    GROUP BY id
  )
WHERE rownum = 1
;
