-- limit + Aliasing 

-- Limit is just going to specify how many rows you want in the output
select * 
from employee_demographics
order by age desc 
LIMIT 2 ,1
;
-- aliasing is just a way to change the name of the column (for the most part)
-- it can also be used in joins, but we will look at that in the intermediate series
select gender , avg(age ) As avg_age
from employee_demographics
group by gender
having avg_age > 40  
;
