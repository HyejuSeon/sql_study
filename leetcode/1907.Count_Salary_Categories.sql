/* Write your PL/SQL query statement below */

-- pk : account_id
-- output : Low Salary (< $20000), Average Salary ([$20000, $50000]), High Salary (> $50000)
-- 각 구간에 해당하는 account 개수 (없으면 0)
-- account_id income

-- 612ms
-- UNION ALL
SELECT 'Low Salary' AS category,
       COUNT(*) accounts_count
  FROM Accounts
 WHERE income < 20000
UNION ALL
SELECT 'Average Salary' AS category,
       COUNT(*) accounts_count
  FROM Accounts
 WHERE income BETWEEN 20000 AND 50000
UNION ALL
SELECT 'High Salary' AS category,
       COUNT(*) accounts_count
  FROM Accounts
 WHERE income > 50000 ;
