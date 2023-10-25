/*Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) of this table.
This table has the info of the users of an online shopping website where users can sell and buy items.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the primary key (column with unique values) of this table.
item_id is a foreign key (reference column) to the Items table.
buyer_id and seller_id are foreign keys to the Users table.
 

Table: Items

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| item_id       | int     |
| item_brand    | varchar |
+---------------+---------+
item_id is the primary key (column with unique values) of this table.
 

Write a solution to find for each user, the join date and the number of orders they made as a buyer in 2019.*/

--solution
SELECT
    u.user_id as buyer_id,
    u.join_date,
    SUM(
        CASE
            WHEN EXTRACT(YEAR FROM o.order_date) = 2019 THEN 1 ELSE 0 END
    ) AS orders_in_2019
FROM
    Users u
LEFT JOIN Orders o
ON u.user_id = o.buyer_id
GROUP BY 1
ORDER BY 1;
