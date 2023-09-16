/*Table: Employee

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
 

Table: Department

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
 
A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.*/

# solution
WITH highest_salary as (
    SELECT
        e.name,
        e.departmentId,
        d.name as Department,
        e.salary,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.salary DESC) as rnk
    FROM
        Employee e
    INNER JOIN Department d
    ON e.departmentID = d.id)

SELECT
    Department,
    name as Employee,
    salary
FROM
    highest_salary
WHERE rnk IN (1, 2, 3);
