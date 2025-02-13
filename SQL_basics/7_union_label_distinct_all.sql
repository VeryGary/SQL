-- Unions
# Unions combine rows together

# Stacke table 2 under table 1, keeps all of table 1s  columns and its label
# table 2s department ID column will now be stacked under the birthdate column, losing its label,
# And table 2 will lose its last column since table 1 # of columns < table 2 # of columns
SELECT *
FROM employee_demographics
UNION
SELECT *
from employee_salary;

# Stack first name and last name columns under age and gender
SELECT age, gender
FROM employee_demographics
UNION
SELECT first_name, last_name
from employee_salary;

#The past two were bad data, better to combine likewise data

# Stack first name and last name columns under age and gender
# List of all name, no repeats
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
from employee_salary;

# Without removigng duplicates
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
from employee_salary;

# Make table to find those who are either too old or paid too much
# For label column, say old or if high paid
SELECT first_name, last_name, 'Old' as Label
FROM employee_demographics
WHERE age >50
UNION
SELECT first_name, last_name, 'High Paid Employee' as Label
FROM employee_salary
WHERE salary > 70000
;