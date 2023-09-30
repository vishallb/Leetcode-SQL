/* Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.*/

# solution
WITH cte as (
    SELECT
        id,
        num,
        CASE
            WHEN (LEAD(num, 1) OVER(PARTITION BY num ORDER BY id) = num AND LEAD(id, 1) OVER(PARTITION BY num ORDER BY id) - id = 1)
                AND (LEAD(num, 2) OVER(PARTITION BY num ORDER BY id) = num AND LEAD(id, 2) OVER(PARTITION BY num ORDER BY id) - id = 2) 
                THEN 1 ELSE 0
        END AS rn
    FROM
        Logs)

SELECT
    DISTINCT num as ConsecutiveNums
FROM
    cte
WHERE rn = 1;
