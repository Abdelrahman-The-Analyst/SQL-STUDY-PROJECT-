-- Having vs Where

-- Both were created to filter rows of data, but they filter 2 separate things
-- Where is going to filters rows based off columns of data
-- Having is going to filter rows based off aggregated columns when grouped

 select gender , avg(age)  
 from employee_demographics
 group by gender
 having avg(age)  > 40
 ;

-- more example 
SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%Manager%'
GROUP BY occupation
having  AVG(salary) > 75000 ;