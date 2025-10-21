-- temp tables
create temporary table temp_table 
(
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  favorite_movie varchar(100)
); 

select * 
from temp_table;


insert into temp_table
VALUES ('Alex','Freberg','Lord of the Rings: The Twin Towers');


-- example more complex 

create temporary table salary_more_than_50k
 select * 
from employee_salary
where salary >= 50000;

select * 
from salary_more_than_50k;
