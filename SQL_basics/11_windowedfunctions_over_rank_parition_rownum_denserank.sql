-- Windows Functions

# For reference, adds info on salary to that in demo if ids match
SELECT *
FROM employee_demographics
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

#For reference, For above, shows avg salary for men and women
SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

# WINDOW FUNCTION
# Looking at the average salary over everything, hence empty ()
# Will Output the same number for all since avg over everything
SELECT gender, AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

#AVG by gender    
# will still show female for every female and avg for female beside it, and vice versa
SELECT dem.first_name,dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
 
 # Create a Rolling total
SELECT dem.employee_id, dem.first_name,dem.last_name, gender, SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;   

# Create a Table has names, salaries, and rankings salaries 1,2,3 etc for largest salary
#thes a 1 for men and women so ROW_NUMBER() will counts indexes for two sets   
# Row number give current index of row   
SELECT dem.employee_id, dem.first_name,dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id; 
    
# Same but using RANK
# Rank will consider if two salary match, so both with rank the same, rownumber just moves index up even if same value of salary
# so row number would stil go 1,2,3
# Rank would go 1, 2, 2, 4
# Dense rank would go 1, 2, 2, 3
SELECT dem.employee_id, dem.first_name,dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) as row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) as des_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id; 