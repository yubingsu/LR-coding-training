# Write your MySQL query statement below
# same ranking -> dense_rank

select score, 
    dense_rank() over (order by score desc) as 'rank'
from Scores;
