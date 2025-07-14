/* Write your PL/SQL query statement below */

-- Movies pk: movie_id
-- Users pk: user_id
-- Users uk: name
-- MoveRating pk: movie_id, user_id
-- output: user name who has rated the greatest number
--         movie name with highest average rating in Feb 2020
--         return the lexicographically smaller their name

-- union all, order by
-- SELECT name AS results
--   FROM (
--     SELECT COUNT(A.user_id) AS cnt, 
--            B.name
--       FROM MovieRating A
--       JOIN Users B ON B.user_id = A.user_id
--     GROUP BY B.name
--     ORDER BY cnt DESC, name
--   )
--  WHERE rownum = 1
-- UNION ALL
-- SELECT title AS results
--   FROM (
--     SELECT AVG(A.rating) AS avg,
--            B.title
--       FROM MovieRating A
--       JOIN Movies B ON B.movie_id = A.movie_id
--      WHERE created_at BETWEEN TO_DATE('2020-02-01', 'YYYY-MM-DD') 
--                           AND TO_DATE('2020-02-28', 'YYYY-MM-DD')
--     GROUP BY B.title
--     ORDER BY avg DESC, title
--   )
--  WHERE rownum = 1
-- ;

-- union all, row_number()
SELECT name AS results
  FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY COUNT(A.movie_id) DESC, B.name) rnk,
           B.name
      FROM MovieRating A
      JOIN Users B ON B.user_id = A.user_id
    GROUP BY B.name
  )
 WHERE rnk = 1
UNION ALL
SELECT title AS results
  FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY AVG(A.rating) DESC, B.title) rnk,
           B.title
      FROM MovieRating A
      JOIN Movies B ON B.movie_id = A.movie_id
     WHERE A.created_at BETWEEN TO_DATE('2020-02-01', 'YYYY-MM-DD')
                            AND TO_DATE('2020-02-28', 'YYYY-MM-DD')
    GROUP BY B.title
  )
 WHERE rnk = 1
;
