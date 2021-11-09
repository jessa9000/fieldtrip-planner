-- This file will hold the data manipulation queries for Ms. Frizzle's field trip planner website. 
-- A double colon :: will be used to denote variables that will be filled by user-entered data.

-- Students webpage

-- Main Students table

SELECT * FROM students;

-- "Add a Student" input form

INSERT INTO students
    (firstName, lastName, schoolYear, allergiesFlag, specialPower) 
    VALUES (::firstName, ::lastName, ::schoolYear, ::allergiesFlag, ::specialPower);

-- Need to insert for allergy info also... //in progress//
