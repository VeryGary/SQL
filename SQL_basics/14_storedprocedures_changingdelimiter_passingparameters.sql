-- Stored Procedures

# Create a stored procedure
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

# To use the stored procedure, need to call it
CALL large_salaries();

# Need to change delimiter to make large CTES with mutiples selects
# The $$ will now be the under of stored procedure and not any ;
DELIMITER $$
CREATE PROCEDURE large_salariesTwo()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;
#changed delimiter back

# Now calling the store procedure will get two tables, each for salary range specified
CALL large_salariesTwo();

# Now will create a procedure that passes a parameter
CREATE PROCEDURE get_salary(id INT)
	SELECT employee_id, first_name,last_name, salary
    FROM employee_salary
    WHERE employee_id=id
;
# return table with id, name and salary matching emplyee_id=1
CALL get_salary(1);