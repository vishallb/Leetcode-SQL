/*Table: Views

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
 
Write a solution to find all the authors that viewed at least one of their own articles.*/

# solution
SELECT
    author_id as id
FROM
    views
GROUP BY 1
HAVING SUM(CASE WHEN author_id = viewer_id THEN 1 ELSE 0 END) >= 1
ORDER BY 1;
