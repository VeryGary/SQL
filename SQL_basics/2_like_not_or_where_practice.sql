# WHERE,OR,NOT, LIKE AND clause practice

#Find every instance where first name corresponds to someone named Leslie
SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';

#Find all those who make 50,000 or more
SELECT *
FROM employee_salary
WHERE salary >=50000
;

#Find all those who aren't female
SELECT *
FROM parks_and_recreation.employee_demographics WHERE gender != 'female'
;

# Find all males born before 1985
SELECT *
FROM parks_and_recreation.employee_demographics 
WHERE birth_date > '1985-01-01'
AND gender = 'male'
;

# Find all those born before 1985 or are not female 
SELECT *
FROM parks_and_recreation.employee_demographics 
WHERE birth_date > '1985-01-01'
OR NOT gender = 'female'
;

#Like Statemnet, _ , and %
# Find first name that starts with Jer and anything afterwards
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%'
;

# Find first name that starts with a and is followed by any two character
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__'
;

# Find first name that starts with a, is at least 3 characters long
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%'
;
# Find all those born in 1989
SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;