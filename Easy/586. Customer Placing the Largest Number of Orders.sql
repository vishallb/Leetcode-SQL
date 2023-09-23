/*Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.

Write a solution to find the customer_number for the customer who has placed the largest number of orders.*/

# solution
WITH cte as (
    SELECT
        c.customer_number,
        COUNT(d.customer_number) as counts
    FROM
        Orders c
    INNER JOIN Orders d
    ON c.customer_number = d.customer_number
    GROUP BY 1)
SELECT
    customer_number
FROM
    cte
ORDER BY counts DESC
LIMIT 1;
