-- length  
select length('skyfall');
-- length 
select first_name , length(first_name)
from employee_demographics
order by 2  ;
-- upper & lower 
select first_name , upper (first_name), last_name  ,lower(last_name)  
from employee_demographics
order by 2  ;

-- left & right trim 
select ltrim('           abdo');
select  rtrim('Ali       ' );
-- left , right & substring 
select 
first_name , left(first_name , 5 ), 
last_name  ,right(last_name, 3 ) ,
birth_date,
substring( birth_date , 6 ,2) As birth_month
from employee_demographics ; 

-- replace 
select first_name, REPLACE(first_name ,'a','z')
from employee_demographics ; 


-- locate
select first_name, last_name,
concat(first_name, '  ' ,last_name) As full_name
from employee_demographics ; 

-- Date 
SELECT CURRENT_DATE;   -- PostgreSQL, MySQL
SELECT YEAR('2025-09-25');  -- 2025
SELECT dayofyear('2030-09-25');  -- 5 (Thursday in MySQL)
SELECT DATE_ADD('2025-09-26', INTERVAL 10 DAY);


