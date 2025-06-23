/* Write your PL/SQL query statement below */

-- pk : sale_id, year
-- fk : product_id (Product)
-- output : product_id first_year(product_id가 가장 먼저 팔린 년도) quantity price
-- sale_id product_id year quantity price

SELECT product_id, 
       year as first_year, 
       quantity, 
       price
  FROM ( SELECT product_id, 
                year, 
                quantity,
                price, 
                RANK() OVER(PARTITION BY product_id ORDER BY year) rnk 
           FROM Sales )
 WHERE rnk = 1 ;
