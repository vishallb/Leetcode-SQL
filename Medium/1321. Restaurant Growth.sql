/*Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 
You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). 
average_amount should be rounded to two decimal places.*/

-- solution
WITH each_day_sum AS (
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM
        Customer
    GROUP BY visited_on
),
rolling_average AS (
    SELECT
        visited_on,
        SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_sum,
        AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS rn
    FROM
        each_day_sum
)

SELECT
    visited_on,
    rolling_sum AS amount,
    ROUND(rolling_avg, 2) AS average_amount
FROM
    rolling_average
WHERE rn >= 7;
