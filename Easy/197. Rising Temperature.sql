/*Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.*/

# solution
WITH prev_day_weather as (
    SELECT
        id,
        recordDate,
        temperature,
        LAG(temperature) OVER(ORDER BY recordDate) as 'previous_day',
        LAG(recordDate) OVER(ORDER BY recordDate) as 'previous_date'
    FROM
        Weather
)

SELECT
    id
FROM
    prev_day_weather
WHERE temperature > previous_day AND DATE_ADD(previous_date, INTERVAL 1 DAY) = recordDate;
