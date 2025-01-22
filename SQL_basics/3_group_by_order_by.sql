# GROUP BY and ORDER practice
SELECT *
FROM employee_demographics
;

# Group up
# While it looks like same output as DISTINCT 
# Actually rolls up all these values into these rows, so late later when using average or min
# it will be done based off of these rows
SELECT gender
FROM employee_demographics
GROUP BY gender
;

# Do an aggregate functions on the grouped rows of gender
SELECT gender, AVG(age),MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

#ORDER BY
# Sort table alphabetically for first name
SELECT *
FROM employee_demographics
ORDER BY first_name
;
# Sort table by gender, and in gender sort by age
# Important to group by age firsst as there would be no unqiue values on same row
SELECT *
FROM employee_demographics
ORDER BY gender, age
;

# Can also order my column index and use DESC or ASC to sort by descending
SELECT *
FROM employee_demographics
ORDER BY 5, 4 DESC
;