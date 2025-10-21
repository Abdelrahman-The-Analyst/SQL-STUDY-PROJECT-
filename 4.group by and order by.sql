-- group by 
select * 
from employee_demographics
;
-- group by with arguments 
select gender , avg (age)
from employee_demographics
group by gender 
;
-- examples on aruments 

select occupation , salary
from employee_salary
group by occupation , salary
;

select gender , avg(age) , max(age) , min(age) , count(age) 
from employee_demographics
group by gender
;

-- ORDER BY 
select *
from employee_demographics
order by first_name desc 
;

select *
from employee_demographics
order by gender , age desc
;