-- Window functions 
select gender , avg(salary) As Avarage_salary
from employee_demographics dem 
join employee_salary sal 
	on dem.employee_id = sal.employee_id
    group by gender ;
    
    
 
select 
dem.first_name,
dem.last_name,
concat(dem.first_name , ' ' , dem.last_name) AS full_name,
gender ,
 avg(salary) over(partition by gender) As avarage_salary
from employee_demographics dem 
join employee_salary sal 
	on dem.employee_id = sal.employee_id;   