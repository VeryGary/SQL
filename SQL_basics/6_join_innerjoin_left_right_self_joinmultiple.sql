# JOINS (Inner, Left, Right, Self)

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

# Select everything from employee demographics,
# Inner join on emplyee salary based on employee id from demographics table
# To employee id in salary table
# So new table would be employee_ID, table from demographics table, then salary table. 
# Didn’t bring over all rows, only those with same employee_ID in both column we tying on.
SELECT *
FROM employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;
# Simpler with aliasing
SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

# need to specific which table for select if column exists in both
SELECT dem.employee_id, age, occupation
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

# Theres a name, the employee ID #2, Ron, is missing on demographic table thats on the salary table.

#Left join will take everything from left table, even if there's no match in the join, and only return matches from right table. 
# So everything from left, and only those that matched on the right.
# Right Join will take everything from right table, and what matches from the left table.
# need to specific which table for select if column exists in both
#Here: left= dem, right=sal
SELECT *
FROM employee_demographics as dem
LEFT JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

# Since RIGHT has Ron, but Left doesnt, will have NULLS for Ron on LEFT
SELECT *
FROM employee_demographics as dem
RIGHT JOIN employee_salary as sal
	ON dem.employee_id = sal.employee_id
;

#SELF JOIN

# Gives same table beside each other, used emp names to tell apart
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id = emp2.employee_id
;
# Test case. Want to make a secret santa list, where each person get someone else can do
# Adding +1 means employee id on left table matches id 2 on right
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id +1 = emp2.employee_id
;

#Better vesrion, so ID on left table is secret sanata for id on right
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
join employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining mutiple tables together

# This is a reference table, just has department id and department names
# the department ids at end of salary table match up to those displayed in reference table
SELECT *
FROM parks_departments;

#Note refrence table ahs no repeats so everythign on left stays and maps all ties
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;
