-- CTE common table expressiON  vs subquiry 

with CTE_EXAPLE AS
(
select
gender ,
avg(salary) avarge_salary ,
max(salary) max_salary,
min(salary) min_salary ,
count(salary) count_salary 
from employee_demographics dem 
join employee_salary sal 
	on 	dem.employee_id = sal.employee_id 
 group by gender   
)
select  *
from CTE_EXAPLE 
;


select avg(avarge_salary)
from (
select 
gender ,
avg(salary) avarge_salary ,
max(salary) max_salary,
min(salary) min_salary ,
count(salary) count_salary 
from employee_demographics dem 
join employee_salary sal 
	on 	dem.employee_id = sal.employee_id 
 group by gender   
) as gender_salary_statue

;


-- complex cte  

with CTE_EXAPLE AS
(
select
employee_id,
gender,
birth_date
from employee_demographics
where birth_date > '1985-01-01'
),
cte_example2 As
(
select 
employee_id ,
salary 
from employee_salary
where salary > 50000 
)
select * 
from 
 CTE_EXAPLE 
 join cte_example2
	on CTE_EXAPLE.employee_id = cte_example2.employee_id 
 ;
