-- Case Statements

-- A Case Statement allows you to add logic to your Select Statement, sort of like an if else statement in other programming languages or even things like Excel



SELECT * 
FROM employee_demographics;


SELECT first_name, 
last_name, 
CASE
	WHEN age <= 30 THE'N 'Young
	WHEN age  between 30 and 50  THEN 'old'
    WHEN age >= 50 then 'on death door '
END As age_bracket 
FROM employee_demographics;

-- pay icrease  and bouns 
-- if salary < 50000 then icrease = 5%
-- if salary > 50000 then increase = 7%
-- if the finance department thren bouns = 10% 

select 
first_name ,
last_name ,
salary ,
case
	WHEN salary  < 50000 THEN salary * 1.05 
    WHEN salary  > 50000 THEN salary * 1.07 
    END As New_salary ,
case 
	when dept_id = 6  then salary * .10 
end as bouns 
    from employee_salary ;