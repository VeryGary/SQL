# Practicing Select

SELECT *
FROM parks_and_recreation.employee_demographics;

# Showing SELECT works on diffrent lines and can appened new columns, using math, following PEMDAS
SELECT first_name, 
last_name, 
age,
(age+1)*10 #PEMDAS,
FROM parks_and_recreation.employee_demographics;

# Show all distinct entries in gender column
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

# Show all distinct combination of entries from gender and first name column
SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;