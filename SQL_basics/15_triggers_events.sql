-- Triggers and Events

# TRIGGERS

# Trigger is a block of code that executes automatically when an Event takes place on a specific table

# Gonna make a trigger, when data is updated in salary, it updates in demographics for use

#Un commnet this to delete trigger: DROP TRIGGER `employee_insert`;
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
		#For each row means for every row inserted
		FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
    # Dont want every ID,name, so need to specify which, NEW checks only for new rows inserted
END
$$
DELIMITER ;


# Now to test, insert data into salary table, should add both parts of name and employee id to demo table automatically
INSERT INTO employee_salary (employee_id,first_name,last_name,occupation,salary,dept_id)
VALUES(13,'Rufus','Stevon','CEO',1000000,NULL);

#This should show the addition
SELECT *
FROM employee_salary;

#And this should have full name and salary added for Rufus
SELECT *
FROM employee_demographics;

# EVENTS

#Check that this is on for events to work
SHOW VARIABLES LIKE 'event_scheduler';

# Will create an event that checks every 30 seconds if some is 60 or older, then will delete from table as they are retiring
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

#To check if any events are active
SHOW EVENTS;
SHOW EVENTS FROM employee_demographics;

# Check to see if Jerry, age 61 is removed, hes eployee_id 5 so it should be missing
SELECT *
FROM employee_demographics;

#If this didnt work, may need ot fix. Look at varaibles related to event
# Make sure event_scheduler is ON, if not, update it
SHOW VARIABLES LIKE 'event%';

#If you dont have permission to delete things
# On the Top-Left gor: Edit>SQL Editor (scroll down)>Make sure "Safe Updates" box is unticked