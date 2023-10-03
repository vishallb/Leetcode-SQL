/*Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.*/

# solution
SELECT
    (SELECT
            num
            FROM
                MyNumbers
            GROUP BY 1
            HAVING count(*) = 1
            ORDER BY num DESC
            LIMIT 1) num
