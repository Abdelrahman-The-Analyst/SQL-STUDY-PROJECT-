-- stro procedours in sql 
create procedure large_salaries ()
select * 
from employee_salary
where salary  >= 50000;

-- calling prosedure 
call large_salaries ();

-- more complex procedure 
delimiter $$
create procedure large_salaries3()
begin
	select * 
	from employee_salary
	where salary  >= 50000;
	select * 
	from employee_salary
	where salary  >= 10000;
 end $$  
 delimiter ;

-- calling prosedure 
call new_procedure();

-- prameter 

 delimiter $$
create procedure large_salaries4(b2loz int)
begin
	select salary
	from employee_salary
	where employee_id = b2loz
    
    ;
 end $$  
 delimiter ;
 
 call large_salaries4(1);
