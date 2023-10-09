/*Table: Queue

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.
 

There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
The test cases are generated such that the first person does not exceed the weight limit.*/

# SOLUTION
WITH running_sum as (
    SELECT
        turn
        ,person_id
        ,person_name
        ,weight
        ,SUM(weight) OVER(ORDER BY turn ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total_weight 
    FROM
        Queue
),
last_person as (
    SELECT
        person_name,
        ROW_NUMBER() OVER(ORDER BY turn) as rn
    FROM
        running_sum
    WHERE total_weight <= 1000
)

SELECT 
    person_name
FROM
    last_person
ORDER BY rn DESC
LIMIT 1;
