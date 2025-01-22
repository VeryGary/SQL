# Having vs Where
# Having is also a filter

# Show a table for genders average age, for those having a average age least over 40
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

# Group manager jobs and show there average salary, show only those whos
# average salary is over 50000
SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 50000
;