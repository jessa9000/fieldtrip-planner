-- This file will hold the data manipulation queries for Ms. Frizzle's field trip planner website. 
-- A double colon :: will be used to denote variables that will be filled by user-entered data.

---------------------------------------------------------------------------------------
-- Students webpage
---------------------------------------------------------------------------------------

-- Students table

SELECT studentID AS 'Student ID', firstName AS 'First Name', lastName AS 'Last Name', schoolYear AS 'School Year',
    allergiesFlag AS 'Any Allergies', specialPower AS 'Special Power' 
    FROM students;

-- "Add a Student" input form will kick off up to two separate INSERT statements:

INSERT INTO students
    (firstName, lastName, schoolYear, allergiesFlag, specialPower) 
    VALUES (::firstName, ::lastName, ::schoolYear, ::allergiesFlag, ::specialPower);

INSERT INTO allergies 
    (studentID, allergenID)
    VALUES (::studentID-of-newly-created-student, ::allergenID-of-selected-allergen);

-- Emergency Contacts table

SELECT studentID AS 'Student ID', adultID AS 'Adult ID' 
    FROM emergencyContacts;

-- "Add an Emergency Contact" input form

INSERT INTO emergencyContacts 
    (studentID, adultID)
    VALUES (::studentID, ::adultID);


---------------------------------------------------------------------------------------
-- Trusted Adults webpage
---------------------------------------------------------------------------------------

-- Trusted Adults table

SELECT adultID AS 'Trusted Adult ID', firstName AS 'First Name', lastName AS 'Last Name', 
    primaryPhone AS 'Primary Phone' 
    FROM trustedAdults;

-- "Add a Trusted Adult" input form

INSERT INTO trustedAdults 
    (firstName, lastName, primaryPhone)
    VALUES (::firstName, ::lastName, ::primaryPhone);

---------------------------------------------------------------------------------------
-- Allergies webpage
---------------------------------------------------------------------------------------

-- Allergies table with two joins

SELECT allergies.studentID AS 'Student ID', students.firstName AS 'Student First Name', 
    students.lastName AS 'Student Last Name', allergies.allergenID AS 'Allergen ID', allergens.name AS 'Allergen'
    FROM allergies
    JOIN students ON allergies.studentID = students.studentID
    JOIN allergens ON allergies.allergenID = allergens.allergenID;

-- Possible allergens

SELECT allergenID AS 'Allergen ID', name AS 'Allergen Name' 
    FROM allergens;

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

SELECT snackID AS 'Snack ID', name AS 'Snack Name' 
    FROM snacks;

-- "Add a Snack" input form

INSERT INTO snacks  
    (name)
    VALUES (::name);

-- "Remove a Snack" input form

DELETE FROM snacks
    WHERE name = ::name;

-- Ingredients table with two joins

SELECT ingredients.snackID AS 'Snack ID', snacks.name AS 'Snack Name', 
    ingredients.allergenID AS 'Allergen ID', allergens.name AS 'Allergen'
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

SELECT tripID AS 'Trip ID', name as 'Name', street as 'Street', city AS 'City', state AS 'State',
    zipCode AS 'Zip Code', date AS 'Date', meetTime AS 'Meet Time', returnTime AS 'Return Time' 
    FROM trips;

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

-- "Select a trip to plan" input form and resulting Trip in Planning table

SELECT tripID AS 'Trip ID', name as 'Name', street as 'Street', city AS 'City', state AS 'State',
    zipCode AS 'Zip Code', date AS 'Date', meetTime AS 'Meet Time', returnTime AS 'Return Time' 
    FROM trips 
    WHERE tripID = ::tripID OR name LIKE %::keyword%;

-- Attendees table

SELECT attendees.tripID AS 'Trip ID', attendees.studentID AS 'Student ID', 
    students.firstName AS 'Student First Name', students.lastName AS 'Student Last Name', 
    attendees.adultID AS 'Responsible Chaperone ID', 
    trustedAdults.firstName AS 'Responsible Chaperone FName', trustedAdults.lastName AS 'Responsible Chaperone LName'
    FROM attendees
    JOIN students ON attendees.studentID = students.studentID
    JOIN trustedAdults ON attendees.adultID = trustedAdults.adultID
    WHERE tripID = ::trip-from-above-filter;

-- Planned Snacks table

SELECT plannedSnacks.plannedSnackID AS 'Planned Snack ID', plannedSnacks.tripID AS 'Trip ID', 
    plannedSnacks.snackID AS 'Snack ID', snacks.name AS 'Snack Name', 
    plannedSnacks.adultID AS 'Snack Bringer ID', 
    trustedAdults.firstName AS 'Snack Bringer FName',  trustedAdults.lastName AS 'Snack Bringer LName'
    FROM plannedSnacks
    JOIN snacks ON plannedSnacks.snackID = snacks.snackID
    JOIN trustedAdults ON plannedSnacks.adultID = trustedAdults.adultID
    WHERE tripID = ::trip-from-above-filter;

-- "Add an Attendee" input form

INSERT INTO attendees
    (tripID, studentID, adultID)
    VALUES (::tripID, ::studentID, ::adultID);

-- "Add a Planned Snack" input form

INSERT INTO plannedSnacks
    (tripID, snackID, adultID)
    VALUES (::tripID, ::studentID, ::adultID);

-- "Modify a Planned Snack" input form

UPDATE plannedSnacks
    SET snackID = ::snackID, 
        tripID = ::tripID, 
        adultID = ::adultID, 
    WHERE plannedSnackID = ::plannedSnackID;
