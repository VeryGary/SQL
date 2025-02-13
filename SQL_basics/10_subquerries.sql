-- Subqueries

# Gonna pull from another table
# Subquery will those who has an ID in demo that matches that in salary
SELECT *
FROM employee_demographics
WHERE employee_id IN 
	(SELECT employee_id
		FROM employee_salary
        WHERE dept_id = 1)
;
# Table with names and avg salary column
SELECT first_name, salary,(SELECT AVG(salary) FROM employee_salary )
FROM employee_salary;

# If you pull from a subquerries table, need to name or error
SELECT *
FROM 
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age) 
FROM employee_demographics 
GROUP BY gender
) AS Agg_table
;

# To preform aggregations on a subquerry
SELECT gender, AVG(min_age)
FROM 
	(SELECT gender, 
	AVG(age) as avg_age, 
    MAX(age) as max_age, 
    MIN(age) as min_age, 
    COUNT(age) 
FROM employee_demographics 
GROUP BY gender) 
AS Agg_table
GROUP BY gender
;
