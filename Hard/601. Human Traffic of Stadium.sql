/*Table: Stadium

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
 

Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.*/

--- solution
WITH cte AS (
    SELECT *,
           id - ROW_NUMBER() OVER (ORDER BY id ASC) AS rnk
    FROM stadium
    WHERE people >= 100
)
SELECT 
    id, 
    visit_date, 
    people
FROM cte
WHERE rnk IN (
    SELECT rnk
    FROM cte
    GROUP BY rnk
    HAVING COUNT(*) >= 3
);
