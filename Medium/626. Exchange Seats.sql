/*Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 
Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.*/

# solution
WITH cte as (
    SELECT
        id,
        student,
        LEAD(student) OVER(ORDER BY id) as next_student,
        LAG(student) OVER(ORDER BY id) as prev_student
    FROM
        Seat
)

SELECT
    id,
    CASE
        WHEN id % 2 != 0 AND next_student IS NOT NULL THEN next_student
        WHEN id % 2 = 0 AND prev_student IS NOT NULL THEN prev_student
        WHEN id % 2 != 0 AND next_student IS NULL THEN student
    END as student
FROM
    Cte;
