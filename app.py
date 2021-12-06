from flask import Flask, render_template, json
from flask import request
import os
import database.db_connector as db
from database.db_connector import connect_to_database, execute_query

# Configuration

app = Flask(__name__)

db_connection = db.connect_to_database()

# Trying Ed #203 again -- putting a copy here and at bottom, not sure if it matters:
# db_connection.ping(True)
# cur=db_connection.cursor()

# Routes 

@app.route('/')
def root():
    return render_template("main.j2")

# ===========================================================================

@app.route('/Students', methods=["POST", "GET"])
def Students():

    if request.method == "POST":
        # Student form stuff
        if request.form["add"] == "addStudents":
            fname = request.form['fname']
            lname = request.form.get('lname', default=None) # request.form.get() method implements default values if form entry can be left blank
            year = request.form['year'] # I couldn't get request.form.get() working for this one so let's just change it to NOT NULL :)
            power = request.form.get('power', default=None)
            allergyFlag = request.form.get('allergyFlag', default=0)
            allergies = request.form.getlist('student-allergies', type=int)

            queryInsertStudents = "INSERT INTO Students \
                (firstName, lastName, schoolYear, allergiesFlag, specialPower) VALUES (%s, %s, %s, %s, %s);"
            dataInsertStudents = (fname, lname, year, allergyFlag, power)
            execute_query(db_connection, queryInsertStudents, dataInsertStudents)

            # Implement update Allergies table from multiple select

            # Get set up to get the ID of the student we just inserted
            if allergyFlag == '1':
                # 1. Save the SQL query syntax to variable
                queryNewID = "SELECT LAST_INSERT_ID() FROM Students;"
                # 2. Execute query and save result to cursor
                cursorNewID = db.execute_query(db_connection=db_connection, query=queryNewID)
                # 3. Run fetchall and save to result variable
                resultNewID = cursorNewID.fetchall()
                # 4. Get the ID out of the fetchall array
                almostNewStudentID = resultNewID[0]
                newStudentID = almostNewStudentID['LAST_INSERT_ID()']
                print(newStudentID)
                
                for allergy in allergies:
                    queryInsertAllergies = "INSERT INTO Allergies (studentID, allergenID) VALUES (%s, %s);"
                    dataInsertAllergies = (newStudentID, allergy)
                    execute_query(db_connection, queryInsertAllergies, dataInsertAllergies)

        # Emergency Contacts form stuff
        elif request.form["add"] == "addEmergencyContacts":
            studentID = request.form['addEmergencyContactsStudents']
            adultID = request.form['addEmergencyContactsTrustedAdults']

            queryInsertEmergencyContacts = "INSERT INTO EmergencyContacts (studentID, adultID) VALUES (%s, %s);"
            dataInsertEmergencyContacts = (studentID, adultID)
            execute_query(db_connection, queryInsertEmergencyContacts, dataInsertEmergencyContacts)

    # Write the query for all relevant tables and save those queries (we don't have results yet) to variables
    queryStudents = "SELECT studentID AS 'Student ID', firstName AS 'First Name', lastName AS 'Last Name', \
        schoolYear AS 'School Year', (CASE WHEN allergiesFlag = 1 THEN 'Yes' ELSE 'No' END) AS 'Any Allergies', \
            specialPower AS 'Special Power' FROM Students;"
    queryEmergencyContacts = "SELECT studentID AS 'Student ID', adultID AS 'Adult ID' FROM EmergencyContacts;"
    queryAllergens = "SELECT allergenID, name FROM Allergens;"
    queryTrustedAdults = "SELECT adultID, firstName, lastName FROM TrustedAdults;"
    print("Test1")

    # The way the interface between MySQL and Flask works is by using an
    # object called a cursor. Think of it as the object that acts as the
    # person typing commands directly into the MySQL command line and
    # reading them back to you when it gets results
    cursorStudents = db.execute_query(db_connection=db_connection, query=queryStudents)
    cursorEmergencyContacts = db.execute_query(db_connection=db_connection, query=queryEmergencyContacts)
    cursorAllergens = db.execute_query(db_connection=db_connection, query=queryAllergens)
    cursorTrustedAdults = db.execute_query(db_connection=db_connection, query=queryTrustedAdults)
    print("Test2")

    # The cursor.fetchall() function tells the cursor object to return all
    # the results from the previously executed
    #
    # The json.dumps() function simply converts the dictionary that was
    # returned by the fetchall() call to JSON so we can display it on the
    # page.
    resultsStudents = cursorStudents.fetchall()
    resultsEmergencyContacts = cursorEmergencyContacts.fetchall()
    resultsAllergens = cursorAllergens.fetchall()
    resultsTrustedAdults = cursorTrustedAdults.fetchall()
    print("Test3")

    # Sends the results back to the web browser.
    return render_template("Students.j2", Students=resultsStudents, Allergens=resultsAllergens, \
        EmergencyContacts=resultsEmergencyContacts, TrustedAdults=resultsTrustedAdults)

# ======================================================================

@app.route('/TrustedAdults', methods=["POST", "GET"])
def TrustedAdults():

    # Form stuff
    if request.method == "POST":
        fname = request.form['fname']
        lname = request.form['lname']
        phone = request.form['phone']

        queryInsertAdults = "INSERT INTO TrustedAdults (firstName, lastName, primaryPhone) VALUES (%s, %s, %s);"
        dataInsertAdults = (fname, lname, phone)
        execute_query(db_connection, queryInsertAdults, dataInsertAdults)

    # Retrieve table data
    query = "SELECT adultID AS 'Trusted Adult ID', firstName AS 'First Name', lastName AS 'Last Name', primaryPhone AS 'Primary Phone' FROM TrustedAdults;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("TrustedAdults.j2", TrustedAdults=results)

@app.route('/Allergies', methods=["POST", "GET"])
def Allergies():
 
    # Form stuff
    if request.method == "POST":
        # Student-Allergy form stuff
        if request.form["add"] == "addStudentsAllergies":
            studentID = request.form['addAllergyStudents']
            allergenID = request.form['addAllergyAllergens']
            allergiesFlag = 1

            queryInsertStudentsAllergies = "INSERT INTO Allergies (studentID, allergenID) VALUES (%s, %s);"
            dataInsertStudentsAllergies = (studentID, allergenID)
            queryUpdateAllergyFlag = "UPDATE Students SET allergiesFlag = (%s) WHERE studentID = (%s);"
            dataUpdateAllergyFlag = (allergiesFlag, studentID)
            execute_query(db_connection, queryInsertStudentsAllergies, dataInsertStudentsAllergies)
            execute_query(db_connection, queryUpdateAllergyFlag, dataUpdateAllergyFlag)

        # Allergen form stuff
        elif request.form["add"] == "addAllergens":
            allergenName = request.form['allergenName']

            queryInsertAllergen = "INSERT INTO Allergens (name) VALUES (%s);"
            dataInsertAllergen = (allergenName,) # PROTIP this needs to be a tuple, so the comma has to be there even for a list of one
            execute_query(db_connection, queryInsertAllergen, dataInsertAllergen)

    # Retrieve table data
    queryAllergies = "SELECT Allergies.studentID AS 'Student ID', Students.firstName AS 'Student First Name', Students.lastName AS 'Student Last Name', Allergies.allergenID AS 'Allergen ID ^', Allergens.name AS 'Allergen' FROM Allergies JOIN Students ON Allergies.studentID = Students.studentID JOIN Allergens ON Allergies.allergenID = Allergens.allergenID;"
    queryAllergens = "SELECT allergenID AS 'Allergen ID', name AS 'Allergen Name' FROM Allergens;"
    queryStudents = "SELECT studentID, firstName, lastName FROM Students;"
    cursorAllergies = db.execute_query(db_connection=db_connection, query=queryAllergies)
    cursorAllergens = db.execute_query(db_connection=db_connection, query=queryAllergens)
    cursorStudents = db.execute_query(db_connection=db_connection, query=queryStudents)
    resultsAllergies = cursorAllergies.fetchall()
    resultsAllergens = cursorAllergens.fetchall()
    resultsStudents = cursorStudents.fetchall()
    return render_template("Allergies.j2", Allergies=resultsAllergies, Allergens=resultsAllergens, Students=resultsStudents)

@app.route('/Snacks', methods=["POST", "GET"])
def Snacks():

    # Form stuff
    if request.method == "POST":
        # Add Snack form stuff
        if request.form["add"] == "addSnacks":
            snackName = request.form['snackAdd']

            queryInsertSnacks = "INSERT INTO Snacks (name) VALUES (%s);"
            dataInsertSnacks = (snackName,)
            execute_query(db_connection, queryInsertSnacks, dataInsertSnacks)

        # Remove Snack form stuff
        elif request.form["add"] == "removeSnacks":
            snackID = request.form['snackSelect']

            queryDeleteSnack = "DELETE FROM Snacks WHERE snackID = %s;"
            dataDeleteSnack = (snackID,)
            execute_query(db_connection, queryDeleteSnack, dataDeleteSnack)

         # Add Ingredients form stuff
        elif request.form["add"] == "addIngredients":
            snackID = request.form['addAllergenSnack']
            allergenID = request.form['addSnackAllergen']

            queryInsertIngredients = "INSERT INTO Ingredients (snackID, allergenID) VALUES (%s, %s);"
            dataInsertIngredients = (snackID, allergenID)
            execute_query(db_connection, queryInsertIngredients, dataInsertIngredients)

    # Retrieve table data
    querySnacks = "SELECT snackID AS 'Snack ID', name AS 'Snack Name' FROM Snacks;"
    queryIngredients = "SELECT Ingredients.snackID AS 'Snack ID', Snacks.name AS 'Snack Name', Ingredients.allergenID AS 'Allergen ID', Allergens.name AS 'Allergen' FROM Ingredients JOIN Snacks ON Ingredients.snackID = Snacks.snackID JOIN Allergens ON Ingredients.allergenID = Allergens.allergenID;"
    queryAllergens = "SELECT * FROM Allergens;"
    cursorSnacks = db.execute_query(db_connection=db_connection, query=querySnacks)
    cursorIngredients = db.execute_query(db_connection=db_connection, query=queryIngredients)
    cursorAllergens = db.execute_query(db_connection=db_connection, query=queryAllergens)
    resultsSnacks = cursorSnacks.fetchall()
    resultsIngredients = cursorIngredients.fetchall()
    resultsAllergens = cursorAllergens.fetchall()
    return render_template("Snacks.j2", Snacks=resultsSnacks, Ingredients=resultsIngredients, Allergens=resultsAllergens)

@app.route('/Trips', methods=["POST", "GET"])
def Trips():

    # Form stuff
    if request.method == "POST":

        tripName = request.form['tripName']
        street = request.form['street']
        city = request.form['city']
        state = request.form['state']
        zipCode = request.form['zipCode']
        date = request.form['date']
        meetTime = request.form.get('meetTime', default=None)
        returnTime = request.form.get('returnTime', default=None)

        # Add Trip form stuff
        if request.form["add"] == "addTrips":
            queryInsertTrips = "INSERT INTO Trips (name, street, city, state, zipCode, date, meetTime, returnTime) VALUES (%s, %s, %s, %s, %s, %s, %s, %s);"
            dataInsertTrips = (tripName, street, city, state, zipCode, date, meetTime, returnTime)
            execute_query(db_connection, queryInsertTrips, dataInsertTrips)

        # Select Trip to UPDATE, loads TripsUpdate page with prefilled form
        elif request.form["add"] == "selectTrips":
            tripID = request.form['selectUpdateTrip']
            return render_template("TripsUpdate.j2")

        # Incoming form data from TripsUpdate page submission
        elif request.form["add"] == "updateTrips":
            tripID = request.form['tripID']
            queryUpdateTrip = "UPDATE Trips SET name = (%s), street = (%s), city = (%s), state = (%s), zipCode = (%s), date = (%s), meetTime = (%s), returnTime = (%s) WHERE tripID = (%s);"
            dataUpdateTrip = (tripName, street, city, state, zipCode, date, meetTime, returnTime, tripID)
            execute_query(db_connection, queryUpdateTrip, dataUpdateTrip)

    # Retrieve table data
    query = "SELECT tripID AS 'Trip ID', name as 'Name', street as 'Street', city AS 'City', state AS 'State', zipCode AS 'Zip Code', date AS 'Date', meetTime AS 'Meet Time', returnTime AS 'Return Time' FROM Trips;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("Trips.j2", Trips=results)

@app.route('/TripsUpdate', methods=["POST", "GET"])
def TripsUpdate():

    # Load prefilled form
    tripID = request.args.get("selectUpdateTrip")
    queryPrefill = "SELECT * FROM Trips WHERE tripID = %s;" % (tripID,)
    cursorPrefill = db.execute_query(db_connection=db_connection, query=queryPrefill)
    resultsPrefill = cursorPrefill.fetchall()
    return render_template("TripsUpdate.j2", prefill=resultsPrefill)

@app.route('/TripPlanner', methods=["POST", "GET"])
def TripPlanner():

    selectTripPlanning = ""

    # Form stuff
    if request.method == "POST":

        # Check if Trip filter is active
        if request.form["add"] == "selectPlanningTrip":
            selectTripPlanning = request.form['selectTrip']

        # Add Attendee form stuff
        if request.form["add"] == "addAttendee":
            attendeeTrip = request.form['attendeeTrip']
            attendeeStudent = request.form['attendeeStudent']
            attendeeChaperone = request.form['attendeeChaperone']

            queryInsertAttendee = "INSERT INTO Attendees (tripID, studentID, adultID) VALUES (%s, %s, %s);"
            dataInsertAttendee = (attendeeTrip, attendeeStudent, attendeeChaperone)
            execute_query(db_connection, queryInsertAttendee, dataInsertAttendee)

        # Add Planned Snack form stuff
        elif request.form["add"] == "addPlannedSnack":
            plannedSnackTrip = request.form['plannedSnackTrip']
            plannedSnackName = request.form['plannedSnackName']
            plannedSnackBringer = request.form['plannedSnackBringer']

            queryInsertPlannedSnack = "INSERT INTO PlannedSnacks (tripID, snackID, adultID) VALUES (%s, %s, %s);"
            dataInsertPlannedSnack = (plannedSnackTrip, plannedSnackName, plannedSnackBringer)
            execute_query(db_connection, queryInsertPlannedSnack, dataInsertPlannedSnack)

        # Select Planned Snack to UPDATE, loads PlannedSnackUpdate page with prefilled form
        elif request.form["add"] == "selectPlannedSnack":
            plannedSnackID = request.form['selectUpdatePlannedSnack']
            return render_template("PlannedSnackUpdate.j2")

        # Incoming form data from PlannedSnackUpdate page submission
        elif request.form["add"] == "updatePlannedSnack":
            plannedSnackID = request.form['plannedSnackID']
            plannedSnackTrip = request.form['updateTrip']
            plannedSnackSnack = request.form['updateSnack']
            if plannedSnackSnack == "none":
                plannedSnackSnack = None
            plannedSnackBringer = request.form['updateSnackBringer']
            if plannedSnackBringer == "none":
                plannedSnackBringer = None
            queryUpdatePlannedSnack = "UPDATE PlannedSnacks SET snackID = %s, tripID = %s, adultID = %s WHERE plannedSnackID = %s;"
            dataUpdatePlannedSnack = (plannedSnackSnack, plannedSnackTrip, plannedSnackBringer, plannedSnackID)
            execute_query(db_connection, queryUpdatePlannedSnack, dataUpdatePlannedSnack)

    queryTripPlanning = "SELECT tripID AS 'Trip ID', name as 'Name', street as 'Street', city AS 'City', state AS 'State', zipCode AS 'Zip Code', date AS 'Date', meetTime AS 'Meet Time', returnTime AS 'Return Time' FROM Trips;"
    queryAttendees = "SELECT Attendees.tripID AS 'Trip ID', Attendees.studentID AS 'Student ID', Students.firstName AS 'Student First Name', Students.lastName AS 'Student Last Name', Attendees.adultID AS 'Responsible Chaperone ID', TrustedAdults.firstName AS 'Responsible Chaperone FName', TrustedAdults.lastName AS 'Responsible Chaperone LName' FROM Attendees JOIN Students ON Attendees.studentID = Students.studentID JOIN TrustedAdults ON Attendees.adultID = TrustedAdults.adultID;"
    queryPlannedSnack = "SELECT PlannedSnacks.plannedSnackID AS 'Planned Snack ID', PlannedSnacks.tripID AS 'Trip ID', PlannedSnacks.snackID AS 'Snack ID', Snacks.name AS 'Snack Name', PlannedSnacks.adultID AS 'Snack Bringer ID', TrustedAdults.firstName AS 'Snack Bringer FName',  TrustedAdults.lastName AS 'Snack Bringer LName' FROM PlannedSnacks LEFT JOIN Snacks ON PlannedSnacks.snackID = Snacks.snackID LEFT JOIN TrustedAdults ON PlannedSnacks.adultID = TrustedAdults.adultID;"
    queryTrips = "SELECT tripID, name FROM Trips;"
    queryStudents = "SELECT studentID, firstName, lastName FROM Students;"
    queryAdults = "SELECT adultID, firstName, lastName FROM TrustedAdults;"
    querySnacks = "SELECT snackID, name FROM Snacks;"
    
    # Check if Trip filter is active
    if selectTripPlanning != "":
        selectQuery = " WHERE tripID = %s;" % (selectTripPlanning,)
        queryTripPlanning = queryTripPlanning[:-1] + selectQuery
        queryAttendees = queryAttendees[:-1] + selectQuery
        queryPlannedSnack = queryPlannedSnack[:-1] + selectQuery
        
        cursorTripPlanning = db.execute_query(db_connection=db_connection, query=queryTripPlanning)
        cursorAttendees = db.execute_query(db_connection=db_connection, query=queryAttendees)
        cursorPlannedSnack = db.execute_query(db_connection=db_connection, query=queryPlannedSnack)
        cursorTrips = db.execute_query(db_connection=db_connection, query=queryTrips)
        cursorStudents = db.execute_query(db_connection=db_connection, query=queryStudents)
        cursorAdults = db.execute_query(db_connection=db_connection, query=queryAdults)
        cursorSnacks = db.execute_query(db_connection=db_connection, query=querySnacks)
        resultsTripPlanning = cursorTripPlanning.fetchall()
        resultsAttendees = cursorAttendees.fetchall()
        resultsPlannedSnack = cursorPlannedSnack.fetchall()
        resultsTrips = cursorTrips.fetchall()
        resultsStudents = cursorStudents.fetchall()
        resultsAdults = cursorAdults.fetchall()
        resultsSnacks = cursorSnacks.fetchall()

        return render_template("TripPlanner.j2", TripPlanning=resultsTripPlanning, Attendees=resultsAttendees, PlannedSnack=resultsPlannedSnack, Trips=resultsTrips, Students=resultsStudents, Adults=resultsAdults, Snacks=resultsSnacks)

    cursorTripPlanning = db.execute_query(db_connection=db_connection, query=queryTripPlanning)
    cursorAttendees = db.execute_query(db_connection=db_connection, query=queryAttendees)
    cursorPlannedSnack = db.execute_query(db_connection=db_connection, query=queryPlannedSnack)
    cursorTrips = db.execute_query(db_connection=db_connection, query=queryTrips)
    cursorStudents = db.execute_query(db_connection=db_connection, query=queryStudents)
    cursorAdults = db.execute_query(db_connection=db_connection, query=queryAdults)
    cursorSnacks = db.execute_query(db_connection=db_connection, query=querySnacks)
    resultsTripPlanning = cursorTripPlanning.fetchall()
    resultsAttendees = cursorAttendees.fetchall()
    resultsPlannedSnack = cursorPlannedSnack.fetchall()
    resultsTrips = cursorTrips.fetchall()
    resultsStudents = cursorStudents.fetchall()
    resultsAdults = cursorAdults.fetchall()
    resultsSnacks = cursorSnacks.fetchall()
    return render_template("TripPlanner.j2", TripPlanning=resultsTripPlanning, Attendees=resultsAttendees, PlannedSnack=resultsPlannedSnack, Trips=resultsTrips, Students=resultsStudents, Adults=resultsAdults, Snacks=resultsSnacks)

@app.route('/PlannedSnackUpdate', methods=["POST", "GET"])
def PlannedSnackUpdate():
 
    # Load prefilled form
    plannedSnackID = request.args.get("selectUpdatePlannedSnack")
    queryPrefill = "SELECT * FROM PlannedSnacks WHERE plannedSnackID = %s;" % (plannedSnackID,)
    queryTrips = "SELECT tripID, name FROM Trips;"
    querySnacks = "SELECT snackID, name FROM Snacks;"
    queryAdults = "SELECT adultID, firstName, lastName FROM TrustedAdults;"
    cursorPrefill = db.execute_query(db_connection=db_connection, query=queryPrefill)
    cursorTrips = db.execute_query(db_connection=db_connection, query=queryTrips)
    cursorSnacks = db.execute_query(db_connection=db_connection, query=querySnacks)
    cursorAdults = db.execute_query(db_connection=db_connection, query=queryAdults)
    resultsPrefill = cursorPrefill.fetchall()
    resultsTrips = cursorTrips.fetchall()
    resultsSnacks = cursorSnacks.fetchall()
    resultsAdults = cursorAdults.fetchall()
    return render_template("PlannedSnackUpdate.j2", prefill=resultsPrefill, Trips=resultsTrips, Snacks=resultsSnacks, Adults=resultsAdults)

# Listener
# Specifying the host explicitly as suggested by classmate in Ed #167 

if __name__ == "__main__":

    # Turn on for local dev
    # port = int(os.environ.get('PORT', 9321))

    # app.run(port=port, debug=True) 


    app.run(host="flip3.engr.oregonstate.edu", port=9321, debug=True) 

# The following code used to maintain a connection to the db provided per Ed #203 by: 
# http://www.neotitans.com/resources/python/mysql-python-connection-error-2006.html


db_connection.ping(True)
cur=db_connection.cursor()
