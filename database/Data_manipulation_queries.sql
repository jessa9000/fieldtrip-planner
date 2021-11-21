-- This file will hold the data manipulation queries for Ms. Frizzle's field trip planner website. 
-- A double colon :: will be used to denote variables that will be filled by user-entered data.

---------------------------------------------------------------------------------------
-- Students webpage
---------------------------------------------------------------------------------------

-- Students table

SELECT studentID AS 'Student ID', firstName AS 'First Name', lastName AS 'Last Name', schoolYear AS 'School Year',
    allergiesFlag AS 'Any Allergies', specialPower AS 'Special Power' 
    FROM Students;

-- "Add a Student" input form will kick off up to two separate INSERT statements:

INSERT INTO Students
    (firstName, lastName, schoolYear, allergiesFlag, specialPower) 
    VALUES (::firstName, ::lastName, ::schoolYear, ::allergiesFlag, ::specialPower);

INSERT INTO Allergies 
    (studentID, allergenID)
    VALUES (::studentID-of-newly-created-student, ::allergenID-of-selected-allergen);

-- Emergency Contacts table

SELECT studentID AS 'Student ID', adultID AS 'Adult ID' 
    FROM EmergencyContacts;

-- "Add an Emergency Contact" input form

INSERT INTO EmergencyContacts 
    (studentID, adultID)
    VALUES (::studentID, ::adultID);


---------------------------------------------------------------------------------------
-- Trusted Adults webpage
---------------------------------------------------------------------------------------

-- Trusted Adults table

SELECT adultID AS 'Trusted Adult ID', firstName AS 'First Name', lastName AS 'Last Name', 
    primaryPhone AS 'Primary Phone' 
    FROM TrustedAdults;

-- "Add a Trusted Adult" input form

INSERT INTO TrustedAdults 
    (firstName, lastName, primaryPhone)
    VALUES (::firstName, ::lastName, ::primaryPhone);

---------------------------------------------------------------------------------------
-- Allergies webpage
---------------------------------------------------------------------------------------

-- Allergies table with two joins

SELECT Allergies.studentID AS 'Student ID', Students.firstName AS 'Student First Name', 
    Students.lastName AS 'Student Last Name', Allergies.allergenID AS 'Allergen ID', Allergens.name AS 'Allergen'
    FROM Allergies
    JOIN Students ON Allergies.studentID = Students.studentID
    JOIN Allergens ON Allergies.allergenID = Allergens.allergenID;

-- Possible allergens

SELECT allergenID AS 'Allergen ID', name AS 'Allergen Name' 
    FROM Allergens;

-- "Add an Allergy" input form

INSERT INTO Allergies
    (studentID, allergenID)
    VALUES (::studentID, ::allergenID);

-- "Add an Allergen" input form

INSERT INTO Allergens 
    (name)
    VALUES (::name);


---------------------------------------------------------------------------------------
-- Snacks webpage
---------------------------------------------------------------------------------------

-- Snacks table

SELECT snackID AS 'Snack ID', name AS 'Snack Name' 
    FROM Snacks;

-- "Add a Snack" input form

INSERT INTO Snacks  
    (name)
    VALUES (::name);

-- "Remove a Snack" input form

DELETE FROM Snacks
    WHERE name = ::name;

-- Ingredients table with two joins

SELECT Ingredients.snackID AS 'Snack ID', Snacks.name AS 'Snack Name', 
    Ingredients.allergenID AS 'Allergen ID', Allergens.name AS 'Allergen'
    FROM Ingredients
    JOIN Snacks ON Ingredients.snackID = Snacks.snackID
    JOIN Allergens ON Ingredients.allergenID = Allergens.allergenID;

-- "Add Labeled Ingredients" input form

INSERT INTO Ingredients
    (snackID, allergenID)
    VALUES (::snackID, ::allergenID);

---------------------------------------------------------------------------------------
-- Trips webpage
---------------------------------------------------------------------------------------

-- Trips table

SELECT tripID AS 'Trip ID', name as 'Name', street as 'Street', city AS 'City', state AS 'State',
    zipCode AS 'Zip Code', date AS 'Date', meetTime AS 'Meet Time', returnTime AS 'Return Time' 
    FROM Trips;

-- "Add a Trip" input form

INSERT INTO Trips
    (name, street, city, state, zipCode, date, meetTime, returnTime)
    VALUES (::name, ::street, ::city, ::zipCode, ::date, ::meetTime, ::returnTime);

-- "Modify a Trip" input form

UPDATE Trips
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
    FROM Trips 
    WHERE tripID = ::tripID OR name LIKE %::keyword%;

-- Attendees table

SELECT Attendees.tripID AS 'Trip ID', Attendees.studentID AS 'Student ID', 
    Students.firstName AS 'Student First Name', Students.lastName AS 'Student Last Name', 
    Attendees.adultID AS 'Responsible Chaperone ID', 
    TrustedAdults.firstName AS 'Responsible Chaperone FName', TrustedAdults.lastName AS 'Responsible Chaperone LName'
    FROM Attendees
    JOIN Students ON Attendees.studentID = Students.studentID
    JOIN TrustedAdults ON Attendees.adultID = TrustedAdults.adultID
    WHERE tripID = ::trip-from-above-filter;

-- Planned Snacks table

SELECT PlannedSnacks.plannedSnackID AS 'Planned Snack ID', PlannedSnacks.tripID AS 'Trip ID', 
    PlannedSnacks.snackID AS 'Snack ID', snacks.name AS 'Snack Name', 
    PlannedSnacks.adultID AS 'Snack Bringer ID', 
    TrustedAdults.firstName AS 'Snack Bringer FName',  TrustedAdults.lastName AS 'Snack Bringer LName'
    FROM PlannedSnacks
    JOIN Snacks ON PlannedSnacks.snackID = Snacks.snackID
    JOIN TrustedAdults ON PlannedSnacks.adultID = TrustedAdults.adultID
    WHERE tripID = ::trip-from-above-filter;

-- "Add an Attendee" input form

INSERT INTO Attendees
    (tripID, studentID, adultID)
    VALUES (::tripID, ::studentID, ::adultID);

-- "Add a Planned Snack" input form

INSERT INTO PlannedSnacks
    (tripID, snackID, adultID)
    VALUES (::tripID, ::studentID, ::adultID);

-- "Modify a Planned Snack" input form

UPDATE PlannedSnacks
    SET snackID = ::snackID, 
        tripID = ::tripID, 
        adultID = ::adultID, 
    WHERE plannedSnackID = ::plannedSnackID;
