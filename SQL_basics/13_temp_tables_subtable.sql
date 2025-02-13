-- Temporary Tables

#Create a temp table
# Note: doing just "CREATE TABLE", makes a table like employee_demographics in our database
CREATE TEMPORARY TABLE temp_table
(
first_name varchar(50),
last_name varchar(50),
fav_movie varchar(100)
);
#Will only show column labels
SELECT *
FROM temp_table;

#insert data
INSERT INTO temp_table
VALUES('Jeff','Maria','Inception');

SELECT *
FROM temp_table;

# Create temp subtable of those who earned more than or equal to 50000 
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary>= 50000;

SELECT *
FROM salary_over_50k
