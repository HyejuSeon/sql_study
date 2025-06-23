/* Write your PL/SQL query statement below */

-- output : 첫 로그인 후 바로 다시 로그인 한 플레이어의 비율 (소수점 2자리까지)
-- pk : player_id, event_date
-- player_id, device_id, event_date, games_played

-- 558ms
-- event_date2 : LEAD 함수로 각 player_id 별로 event_date를 기준으로 정렬하고 다음 행의 event_date 값을 구함
-- rnk : 첫 로그인만 걸러내기 위해 RANK 함수 사용
SELECT ROUND(AVG(CASE (event_date2 - event_date) WHEN 1 THEN 1
                                                        ELSE 0
                  END), 2) fraction
  FROM ( SELECT player_id,
                event_date,
                LEAD(event_date) OVER(PARTITION BY player_id ORDER BY event_date) event_date2,
                RANK() OVER(PARTITION BY player_id ORDER BY event_date) rnk
           FROM Activity )
 WHERE rnk = 1

-- 810ms
-- SELECT ROUND(COUNT(B.event_date) / COUNT(A.event_date), 2) fraction
--   FROM Activity A
-- LEFT OUTER JOIN Activity B ON B.player_id = A.player_id AND B.event_date = A.event_date + 1
-- WHERE (A.player_id, A.event_date) IN ( SELECT player_id, MIN(event_date)
--                                          FROM Activity
--                                        GROUP BY player_id
--                                      )
