from flask import Flask, render_template, json
import os
import database.db_connector as db
from database.db_connector import connect_to_database, execute_query

# Configuration

app = Flask(__name__)

db_connection = db.connect_to_database()

# Routes 

@app.route('/')
def root():
    return render_template("main.j2")


@app.route('/Students')
def Students():
 
    # Write the query and save it to a variable
    queryStudents = "SELECT studentID AS 'Student ID', firstName AS 'First Name', lastName AS 'Last Name', schoolYear AS 'School Year', allergiesFlag AS 'Any Allergies', specialPower AS 'Special Power' FROM Students;"
    queryEmergencyContacts = "SELECT studentID AS 'Student ID', adultID AS 'Adult ID' FROM EmergencyContacts;"
    queryAllergens = "SELECT allergenID, name FROM Allergens;"
    print("Test1")

    # The way the interface between MySQL and Flask works is by using an
    # object called a cursor. Think of it as the object that acts as the
    # person typing commands directly into the MySQL command line and
    # reading them back to you when it gets results
    cursorStudents = db.execute_query(db_connection=db_connection, query=queryStudents)
    cursorEmergencyContacts = db.execute_query(db_connection=db_connection, query=queryEmergencyContacts)
    cursorAllergens = db.execute_query(db_connection=db_connection, query=queryAllergens)
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
    print("Test3")

    # Sends the results back to the web browser.
    return render_template("Students.j2", Students=resultsStudents, Allergens=resultsAllergens, EmergencyContacts=resultsEmergencyContacts)

@app.route('/TrustedAdults')
def TrustedAdults():
 
    query = "SELECT adultID AS 'Trusted Adult ID', firstName AS 'First Name', lastName AS 'Last Name', primaryPhone AS 'Primary Phone' FROM TrustedAdults;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("TrustedAdults.j2", TrustedAdults=results)

@app.route('/Allergies')
def Allergies():
 
    queryAllergies = "SELECT Allergies.studentID AS 'Student ID', Students.firstName AS 'Student First Name', Students.lastName AS 'Student Last Name', Allergies.allergenID AS 'Allergen ID', Allergens.name AS 'Allergen' FROM Allergies JOIN Students ON Allergies.studentID = Students.studentID JOIN Allergens ON Allergies.allergenID = Allergens.allergenID;"
    queryAllergens = "SELECT allergenID AS 'Allergen ID', name AS 'Allergen Name' FROM Allergens;"
    cursorAllergies = db.execute_query(db_connection=db_connection, query=queryAllergies)
    cursorAllergens = db.execute_query(db_connection=db_connection, query=queryAllergens)
    resultsAllergies = cursorAllergies.fetchall()
    resultsAllergens = cursorAllergens.fetchall()
    return render_template("Allergies.j2", Allergies=resultsAllergies, Allergens=resultsAllergens)

@app.route('/Snacks')
def Snacks():
 
    querySnacks = "SELECT snackID AS 'Snack ID', name AS 'Snack Name' FROM Snacks;"
    queryIngredients = "SELECT Ingredients.snackID AS 'Snack ID', Snacks.name AS 'Snack Name', Ingredients.allergenID AS 'Allergen ID', Allergens.name AS 'Allergen' FROM Ingredients JOIN Snacks ON Ingredients.snackID = Snacks.snackID JOIN Allergens ON Ingredients.allergenID = Allergens.allergenID;"
    cursorSnacks = db.execute_query(db_connection=db_connection, query=querySnacks)
    cursorIngredients = db.execute_query(db_connection=db_connection, query=queryIngredients)
    resultsSnacks = cursorSnacks.fetchall()
    resultsIngredients = cursorIngredients.fetchall()
    return render_template("Snacks.j2", Snacks=resultsSnacks, Ingredients=resultsIngredients)

@app.route('/Trips')
def Trips():
 
    query = "SELECT tripID AS 'Trip ID', name as 'Name', street as 'Street', city AS 'City', state AS 'State', zipCode AS 'Zip Code', date AS 'Date', meetTime AS 'Meet Time', returnTime AS 'Return Time' FROM Trips;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("Trips.j2", Trips=results)

@app.route('/TripPlanner')
def TripPlanner():
    """
    query = "SELECT * FROM TripPlanner;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    
    return render_template("TripPlanner.j2", TripPlanner=results)
    """
    return render_template("TripPlanner.j2")

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9321)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True) 
