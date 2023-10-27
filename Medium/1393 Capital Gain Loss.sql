/*Table: Stocks

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| stock_name    | varchar |
| operation     | enum    |
| operation_day | int     |
| price         | int     |
+---------------+---------+
(stock_name, operation_day) is the primary key (combination of columns with unique values) for this table.
The operation column is an ENUM (category) of type ('Sell', 'Buy')
Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. 
It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
 
Write a solution to report the Capital gain/loss for each stock.

The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.

Return the result table in any order.*/


-- solution
WITH cte as (
    SELECT 
        *,
        LEAD(operation) OVER(PARTITION BY stock_name ORDER BY operation_day) as next_day_op,
        LEAD(price) OVER(PARTITION BY stock_name ORDER BY operation_day) as next_day_p
    FROM
        Stocks
)

SELECT
    stock_name,
    SUM(
        CASE
            WHEN operation = 'Buy' AND next_day_op = 'Sell' THEN (next_day_p - price) END
    ) as capital_gain_loss
FROM
    cte
GROUP BY 1;
