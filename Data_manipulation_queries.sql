-- This file will hold the data manipulation queries for Ms. Frizzle's field trip planner website. 
-- A double colon :: will be used to denote variables that will be filled by user-entered data.

---------------------------------------------------------------------------------------
-- Students webpage
---------------------------------------------------------------------------------------

-- Students table

SELECT * FROM students;

-- "Add a Student" input form will kick off up to two separate INSERT statements:

INSERT INTO students
    (firstName, lastName, schoolYear, allergiesFlag, specialPower) 
    VALUES (::firstName, ::lastName, ::schoolYear, ::allergiesFlag, ::specialPower);

INSERT INTO allergies 
    (studentID, allergenID)
    VALUES (::studentID-of-newly-created-student, ::allergenID-of-selected-allergen);

-- Emergency Contacts table

SELECT * FROM emergencyContacts;

-- "Add an Emergency Contact" input form

INSERT INTO emergencyContacts 
    (studentID, adultID)
    VALUES (::studentID, ::adultID);


---------------------------------------------------------------------------------------
-- Trusted Adults webpage
---------------------------------------------------------------------------------------

-- Trusted Adults table

SELECT * FROM trustedAdults;

-- "Add a Trusted Adult" input form

INSERT INTO trustedAdults 
    (firstName, lastName, primaryPhone)
    VALUES (::firstName, ::lastName, ::primaryPhone);

---------------------------------------------------------------------------------------
-- Allergies webpage
---------------------------------------------------------------------------------------

-- Allergies table with two joins

SELECT allergies.studentID, students.firstName, students.lastName, allergies.allergenID, allergens.name 
    FROM allergies
    JOIN students ON allergies.studentID = students.studentID
    JOIN allergens ON allergies.allergenID = allergens.allergenID;

-- Possible allergens

SELECT * FROM allergens;

-- "Add an Allergy" input form

INSERT INTO allergies
    (studentID, allergenID)
    VALUES (::studentID, ::allergenID);

-- "Add an Allergen" input form

INSERT INTO allergens 
    (name)
    VALUES (::name);


---------------------------------------------------------------------------------------
-- Snacks webpage
---------------------------------------------------------------------------------------

-- Snacks table

SELECT * FROM snacks;

-- "Add a Snack" input form

INSERT INTO snacks  
    (name)
    VALUES (::name);

-- "Remove a Snack" input form

DELETE FROM snacks
    WHERE name = ::name;

-- Ingredients table with two joins

SELECT ingredients.snackID, snacks.name, ingredients.allergenID, allergens.name
    FROM ingredients
    JOIN snacks ON ingredients.snackID = snacks.snackID
    JOIN allergens ON ingredients.allergenID = allergens.allergenID;

-- "Add Labeled Ingredients" input form

INSERT INTO ingredients
    (snackID, allergenID)
    VALUES (::snackID, ::allergenID);

---------------------------------------------------------------------------------------
-- Trips webpage
---------------------------------------------------------------------------------------

-- Trips table

SELECT * FROM trips;

-- "Add a Trip" input form

INSERT INTO trips
    (name, street, city, state, zipCode, date, meetTime, returnTime)
    VALUES (::name, ::street, ::city, ::zipCode, ::date, ::meetTime, ::returnTime);

-- "Modify a Trip" input form

UPDATE trips
    SET name = ::name, 
        street = ::street, 
        city = ::city, 
        zipCode = ::zipCode, 
        date = ::date, 
        meetTime = ::meetTime, 
        returnTime = ::returnTime
    WHERE tripID = ::tripID;

---------------------------------------------------------------------------------------
-- Trip Planner webpage
---------------------------------------------------------------------------------------

-- in progress...