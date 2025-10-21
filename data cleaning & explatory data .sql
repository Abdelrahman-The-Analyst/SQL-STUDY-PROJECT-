-- EDA

-- Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers

-- normally when you start the EDA process you have some idea of what you're looking for

-- with this info we are just going to look around and see what we find!

SELECT * 
FROM layoffs_staging2;

-- EASIER QUERIES

SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- Looking at Percentage to see how big these layoffs were
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE  percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1;
-- these are mostly startups it looks like who all went out of business during this time
-- if we order by funcs_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- BritishVolt looks like an EV company, Quibi! I recognize that company - wow raised like 2 billion dollars and went under - ouch

-- SOMEWHAT TOUGHER AND MOSTLY USING GROUP BY--------------------------------------------------------------------------------------------------

-- Companies with the biggest single Layoff

SELECT company, total_laid_off
FROM layoffs_staging
ORDER BY 2 DESC
LIMIT 5;
-- now that's just on a single day
-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- by location

SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

-- this it total in the past 3 years or in the dataset

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 ASC;

-- sum of total_laid_off groping by industry 
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- sum of total_laid_off groping by stage
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- TOUGHER QUERIES------------------------------------------------------------------------------------------------------------------------------------

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.
-- I want to look at 

WITH Company_Year AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

-- Rolling Total of Layoffs Per Month
SELECT SUBSTRING(`date`,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;
-- --------------------------------------------- Data Cleanig --------------------------------------------------------------------------
/*
data cleaning project  
1 remove duplicate 
steps to remove duplicate 
1- make copy of row data 
2- insert data into  the copy data 
3- ad row number 
*/
-- first thing we want to do is create a staging table. This is the one we will work in and clean the data. We want a table with the raw data in case something happens
CREATE TABLE layoffs_staging 
LIKE layoffs;

INSERT layoffs_staging 
SELECT * FROM layoffs;

select * 
from layoffs_staging; 


SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, industry, total_laid_off,`date`) AS row_num
	FROM 
		layoffs_staging;
with duplicate_cte  as
(
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company,location, industry, total_laid_off,`date`,stage, country,funds_raised_millions) AS row_num
	FROM 
		layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1;


select * 
from layoffs_staging
where company ='casper';

-- remove duplicate but cant be updated as delete  is update statement and cte is not physical 
with duplicate_cte  as
(
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company,location, industry, total_laid_off,`date`,stage, country,funds_raised_millions) AS row_num
	FROM 
		layoffs_staging
)
delete  
from duplicate_cte
where row_num > 1; 

-- another way for remove duplicate 
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  row_num int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2
where row_num > 1;



insert into  layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company,location, industry, total_laid_off,`date`,stage, country,funds_raised_millions) AS row_num
FROM layoffs_staging ;

-- removing  duplicate 
-- setting safe_update value 
SET SQL_SAFE_UPDATES = 0;
-- deleting stage 
DELETE FROM layoffs_staging2
WHERE row_num > 1;
-- returning save_update to value 1 
SET SQL_SAFE_UPDATES = 1;  -- (optional) turn it back on after
-- making sure duplicate removed 
select * 
from layoffs_staging2 
where row_num > 1;


-- stndrize data 
select company,trim(company)
from layoffs_staging2
;
-- updating  compan colum 
update layoffs_staging2
set company = trim(company);

-- updating industry 
select distinct industry
from layoffs_staging2

;
update layoffs_staging2
set industry ='crypto'
where industry like 'crypto%';

-- updating location 
select distinct location
from layoffs_staging2
order by 1 
;
-- updating country  
select distinct country , trim( trailing '.' from country)
from layoffs_staging2
order by 1 ;

update layoffs_staging2
set country = trim( trailing '.' from country)
where  country like 'united states%';

--  update the date 
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%Y-%m-%d');
-- now we can convert the data type properly
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

select `date` 
from layoffs_staging2;

 -- deals witn nulls and blancks 
-- find nulls in total_laid_off & percentage_laid_off 
  select *
 from layoffs_staging2
 where total_laid_off is null 
 and percentage_laid_off is null;
 
-- remove duplucate in industry  
 select * 
 from layoffs_staging2 
 where industry is null 
 or industry = '';
 
 update layoffs_staging2
 set industry = null 
 where industry = '';
 -- check industry 
 select * 
 from layoffs_staging2
 where company like  'Bally%';
 -- joining tables to prepare to remove nulls and blank 
 select t1.industry , t2.industry
 from layoffs_staging2 t1 
 join layoffs_staging2	t2
	on t1.company = t2.company
 where (t1.industry is null or 
		t1.industry = 	'')	
 and t2.industry is not null ;
 
-- update statement to remove nulls and blanks 

update layoffs_staging2 t1 
 join layoffs_staging2	t2
	on t1.company = t2.company
 set t1.industry = t2.industry    
 where t1.industry is null  
 and t2.industry is not null  ;
-- check nulls and blanks  
 select * 
 from layoffs_staging2;
 
 -- check total_laid_off & precentage_laid_off
 select *
 from layoffs_staging2
 where total_laid_off is null 
 and percentage_laid_off is null;
 
 -- delete  un important rows and colums 
 delete
 from layoffs_staging2
 where total_laid_off is null 
 and percentage_laid_off is null;

 
-- making sure that data is deleted
 select * 
 from layoffs_staging2;
 -- drop colum from table 
 alter table layoffs_staging2
 drop column row_num; 