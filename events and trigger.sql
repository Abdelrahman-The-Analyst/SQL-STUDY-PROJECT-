-- TRIGGER & Events 
DELIMITER $$
CREATE trigger employee_insert3
	after insert on employee_salary 
    for each row 
begin
 end $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(14, 'ali', 'ahmed', 'marketing', 11000000, NULL);

select * 
from employee_demographics;

-- events  automated tasks that the database runs by itself at a specific time or interval
-- example you're going to create event table that delet the employee aftre reaching specific age 
select  * 
from employee_demographics;
delimiter $$
create event delete_retirees
on schedule every 30 second
do 
begin
	delete 
    from employee_demographics
    where age >= 60;
end $$
delimiter ;

show variables like 'event%';
