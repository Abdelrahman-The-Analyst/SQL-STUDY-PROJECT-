-- where case 
select * 
from employee_salary
where first_name = 'leslie'
;
-- greaterthan or equall 
select * 
from employee_salary
where salary >= 50000
;
--  less than or equall 
select * 
from employee_salary
where salary <= 50000
;
-- females 
select * 
from employee_demographics
 where gender ='female'
;
-- males 
select * 
from employee_demographics
 where gender ='male'
 ;
 -- not equal females 
 select * 
from employee_demographics
 where gender !='female'
;
 -- not equal males  

-- defult date formate year -month - day 
select * 
from employee_demographics
where birth_date > '1985-01-01'
;
-- logical operators  (AND NOT OR)
-- and so the w=two condition must be found 
select * 
from employee_demographics
where birth_date > '1985-01-01'
and gender	= 'male'
;
-- OR so the one  condition must be found 
select * 
from employee_demographics
where birth_date > '1985-01-01'
or  gender	= 'male'
;
-- not  so the one  condition not  be found  and used with and or or not found alone 
select * 
from employee_demographics
where birth_date > '1985-01-01'
 or not  gender	= 'male'
;

-- prctice 1
select * 
from employee_demographics
where (first_name='leslie' and age=44) or 	age > 55 
;

--  like statement  comes with 2 signs (% means any thing )  and( _ means spesific thing ) 
--  like statement  comes with 2 signs (% means any thing )
select * 
from employee_demographics
where first_name like 'a%' 
;
--  like statement  comes with 2 signs   and( _ means spesific thing )
select * 
from employee_demographics
where first_name like 'a__%'
; 