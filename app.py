from flask import Flask, render_template, json
import os
import database.db_connector as db
from database.db_connector import connect_to_database, execute_query

# Configuration

app = Flask(__name__)

db_connection = db.connect_to_database()

# Routes 

@app.route('/hello')
def hello():
    return "Hello"

@app.route('/')
def root():
    return render_template("main.j2")


@app.route('/Students')
def Students():
 
    # Write the query and save it to a variable
    query = "SELECT * FROM Students;"

    # The way the interface between MySQL and Flask works is by using an
    # object called a cursor. Think of it as the object that acts as the
    # person typing commands directly into the MySQL command line and
    # reading them back to you when it gets results
    cursor = db.execute_query(db_connection=db_connection, query=query)

    # The cursor.fetchall() function tells the cursor object to return all
    # the results from the previously executed
    #
    # The json.dumps() function simply converts the dictionary that was
    # returned by the fetchall() call to JSON so we can display it on the
    # page.
    results = cursor.fetchall()

    # Sends the results back to the web browser.
    return render_template("Students.j2", Students=results)

@app.route('/TrustedAdults')
def TrustedAdults():
 
    query = "SELECT * FROM TrustedAdults;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("TrustedAdults.j2", TrustedAdults=results)

@app.route('/Allergies')
def Allergies():
 
    query = "SELECT * FROM Allergies;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("Allergies.j2", Allergies=results)

@app.route('/Snacks')
def Snacks():
 
    query = "SELECT * FROM Snacks;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("Snacks.j2", Snacks=results)

@app.route('/Trips')
def Trips():
 
    query = "SELECT * FROM Trips;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("Trips.j2", Trips=results)

"""
@app.route('/TripPlanner')
def TripPlanner():
 
    query = "SELECT * FROM TripPlanner;"
    cursor = db.execute_query(db_connection=db_connection, query=query)
    results = cursor.fetchall()
    return render_template("TripPlanner.j2", TripPlanner=results)
"""

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9321)) 
    #                                 ^^^^
    #              You can replace this number with any valid port
    
    app.run(port=port, debug=True) 
