-- CTE
# Allows you to define a subquery block that we can reference within the main query

WITH CTE_Example AS
(
#For reference, gives a table that shows salary characteristics by gender and how many
#employees considers for each gender grouping
SELECT gender, AVG(salary) avg_sal,MAX(salary),MIN(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id = sal.employee_id
GROUP BY gender
)
# Now get average of both men and female
SELECT AVG(avg_sal)
FROM CTE_Example
;
#Calling CTE_Example onyl works before that ;

#Create a table from two tables, employees that earn over 50000 in one table
# and are younger than a date, list them
WITH CTE_1 AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics
WHERE birth_date >'1985-01-01'
),
CTE_2 AS
(
SELECT employee_id,salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_1 
JOIN CTE_2 
	ON CTE_1.employee_id = CTE_2.employee_id
;

# Can Use Alliases too in decleration for column names
# will overwrite column names in cte expression
WITH CTE_Example(Gender, Avg_sal,mMx_sal,Min_sal,Count_salary) AS
(
#For reference, gives a table that shows salary characteristics by gender and how many
#employees considers for each gender grouping
SELECT gender, AVG(salary) avg_sal,MAX(salary),MIN(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	on dem.employee_id = sal.employee_id
GROUP BY gender
)
# Now get average of both men and female
SELECT AVG(avg_sal)
FROM CTE_Example
;