/*Table: Tweets

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key (column with unique values) for this table.
This table contains all the tweets in a social media app.
 

Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.*/

-- solution
SELECT
    *
FROM
    (SELECT
        CASE
            WHEN LENGTH(content) > 15 THEN tweet_id ELSE NULL
        END AS tweet_id
    FROM
        Tweets) a
WHERE a.tweet_id IS NOT NULL;
