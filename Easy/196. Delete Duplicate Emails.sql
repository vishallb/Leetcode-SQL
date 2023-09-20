/*Table: Person

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 
Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.*/

# solution
WITH repeated_email as (
    SELECT
        MIN(id) AS id,
        email
    FROM
        Person
    GROUP BY email
)
DELETE FROM Person
WHERE id NOT IN (SELECT id FROM repeated_email)
