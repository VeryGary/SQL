-- String Functions

# Output length of string, this case returns 6
SELECT LENGTH('Iphone');

# Table of all first names and their length, order by second column
SELECT first_name, LENGTH(first_name)
From employee_demographics
ORDER BY 2;

# Upper and Lower, to chance to all upper case or all lowercase
SELECT UPPER('one');
SELECT LOWER('ONE');

# Table of all first names and it in all caps
SELECT first_name, UPPER(first_name)
From employee_demographics;

# TRIM
# Gets rid of whitespace, theres trim, left trim, and right trim
SELECT TRIM('        word      '), RTRIM('        word      ');

# Substrings

# For LEFT(string, how many characters from the left to select
# Right follows suit
# Substring(string, start from, consder length of)
SELECT first_name, 
LEFT(first_name, 4), 
RIGHT(first_name, 4),
SUBSTRING(first_name,2,4)
FROM employee_demographics;

# REPLACE
# REPLACE(string, char to replace, replace with this char)
SELECT first_name, REPLACE(first_name,'e','z')
FROM employee_demographics;

# LOCATE
# Returns position of x in string
SELECT LOCATE('x','Alexander');

# List where An first appear in name, otherwise returns 0
SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics;

# Concat
SELECT first_name, last_name,
CONCAT(first_name,' ',last_name)
FROM employee_demographics;

