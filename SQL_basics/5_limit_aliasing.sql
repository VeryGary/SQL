## Limit & Aliasing

# List the top three rows
SELECT *
FROM parks_and_recreation.employee_demographics
LIMIT 3
;

# Three oldest
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3
;

# Start from Poistion two, and take the next one after
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1
;

#Aliasing is about changing the name of the column, will also be used in JOINS

#This way have to use the aggregate function in the having clause
SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

# Instead can change the name of the column and use it throught the query
# With the aliased name
SELECT gender, AVG(age)=avg_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING avg_age > 40
;