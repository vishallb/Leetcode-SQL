/*Table: Trips

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| client_id   | int      |
| driver_id   | int      |
| city_id     | int      |
| status      | enum     |
| request_at  | date     |     
+-------------+----------+
id is the primary key (column with unique values) for this table.
The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').
 

Table: Users

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| users_id    | int      |
| banned      | enum     |
| role        | enum     |
+-------------+----------+
users_id is the primary key (column with unique values) for this table.
The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
banned is an ENUM (category) type of ('Yes', 'No').
 

The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of 
requests with unbanned users on that day.

Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day
between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.*/

-- solution
SELECT
    t.request_at as Day,
    ROUND(
        (COUNT(CASE WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client') THEN 1 ELSE NULL END)) / IFNULL(COUNT(t.status), 0),2) as 'Cancellation Rate'
FROM
    trips t
INNER JOIN users u
ON t.client_id = u.users_id
INNER JOIN users v
ON t.driver_id = v.users_id
WHERE u.banned = 'No' AND v.banned = 'No' AND (t.request_at BETWEEN '2013-10-01' AND '2013-10-03')
GROUP BY 1;
