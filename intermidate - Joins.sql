-- join (inner -outer - self join )
-- Inner join is join between ros only 
SELECT demo.employee_id,age,occupation
FROM employee_demographics AS demo
INNER JOIN employee_salary AS salary
	ON demo.employee_id = salary.employee_id
    ;
-- Outer Join 
-- LEFT OUTER JOIN  
SELECT demo.employee_id,age,occupation
FROM employee_demographics AS demo
LEFT JOIN employee_salary AS salary
	ON demo.employee_id = salary.employee_id
    ;
-- RIGHT JOIN 
SELECT demo.employee_id,age,occupation
FROM employee_demographics AS demo
RIGHT  JOIN employee_salary AS salary
	ON demo.employee_id = salary.employee_id ; 
-- SELF JOIN 
SELECT LSALARY.employee_id As emp_santa, 
LSALARY.first_name As first_name_santa,
LSALARY.last_name AS last_name_santa,
 RSALARY.employee_id AS emp_name ,
 RSALARY.first_name AS Last_name_emp,
 RSALARY.last_name As last_name_emp
FROM employee_salary AS LSALARY
JOIN employee_salary AS RSALARY
	ON LSALARY.employee_id +1 = RSALARY.employee_id
;
-- joining multple tables 
SELECT *
FROM employee_demographics AS demo
INNER JOIN employee_salary AS salary
	ON demo.employee_id = salary.employee_id
 INNER JOIN parks_departments AS pd 
	ON salary.dept_id=pd.department_id 
    ;