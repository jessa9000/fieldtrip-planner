// This is the file where we will keep client-side scripts. //

//Validates that a telephone number is at least 10 digits long.// 
function checkTelNo(){
    let telephone = document.getElementById('phone');
    let telValue = telephone.value;
    console.log(telValue);
    if(telValue.length != 10 ) {
        event.preventDefault(); 
        alert("Telephone numbers must be exactly 10 digits long.");
        return false;
    }
    else if(isNaN(telValue) === true || telValue < 0) {
        event.preventDefault();
        alert("Entry must not contain letters, symbols, or negative values.");
        return false;
    }
    return true;
}

function checkDropdownStudents(){

    // Students page; Add Emergency Contact selection checker
    let addEmergencyContactsStudents = document.getElementById('addEmergencyContactsStudents');
    let addEmergencyContactsTrustedAdults = document.getElementById('addEmergencyContactsTrustedAdults');
    if(addEmergencyContactsStudents.value == "" || addEmergencyContactsTrustedAdults.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;
}

function checkDropdownAllergies(){
    
    // Allergies page; Add an Allergy selection checker
    let addAllergyStudents = document.getElementById('addAllergyStudents');
    let addAllergyAllergens = document.getElementById('addAllergyAllergens');
    if(addAllergyStudents.value == "" || addAllergyAllergens.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;
}

function checkDropdownRemoveSnacks(){

    // Snacks page; Remove a Snack selection checker
    let snackSelect = document.getElementById('snackSelect');
    if(snackSelect.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;   
}

function checkDropdownAddIngredients(){

    // Snacks page; Add Labeled Ingredients selection checker
    let addAllergenSnack = document.getElementById('addAllergenSnack');
    let addSnackAllergen = document.getElementById('addSnackAllergen');
    if(addAllergenSnack.value == "" || addSnackAllergen.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;   
}

function checkDropdownTrips(){

    // Trips page; Modify a Trip selection checker
    let selectUpdateTrip = document.getElementById('selectUpdateTrip');
    if(selectUpdateTrip.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;
}

function checkDropdownAddAttendee(){

    // TripPlanner page; Add an Attendee selection checker
    let attendeeTrip = document.getElementById('attendeeTrip');
    let attendeeStudent = document.getElementById('attendeeStudent');
    let attendeeChaperone = document.getElementById('attendeeChaperone');
    if(attendeeTrip.value == "" || attendeeStudent.value == "" || attendeeChaperone.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;
}

function checkDropdownAddPlannedSnack(){

    // TripPlanner page; Add a Planned Snack selection checker
    let plannedSnackTrip = document.getElementById('plannedSnackTrip');
    let plannedSnackName = document.getElementById('plannedSnackName');
    let plannedSnackBringer = document.getElementById('plannedSnackBringer');
    if(plannedSnackTrip.value == "" || plannedSnackName.value == "" || plannedSnackBringer.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;
}

function checkDropdownModifyPlannedSnack(){

    // TripPlanner page; Modify a Planned Snack selection checker
    let selectUpdatePlannedSnack = document.getElementById('selectUpdatePlannedSnack');
    if(selectUpdatePlannedSnack.value == "") {
        event.preventDefault();
        alert("Please make a selection.");
        return false;
    }
    return true;
}

//Citation: the following sort functions are adapted from starter code at:
// https://www.w3schools.com/howto/howto_js_sort_table.asp//

function sortNumColumn(array, table){
    headerRowCells = table.rows[0].cells;
    for (let num of array){
        headerRowCells[num].onclick = function() {
            let headerValue = headerRowCells[num].innerHTML;
            headerRowCells[num].innerHTML = headerValue.slice(0, -1) + "▲";
            let switching = true;
            let switchCount = 0;
            var shouldSwitch;
            var dir = "asc";
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i=1; i < (rows.length - 1); i++){
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[num];
                    y = rows[i + 1].getElementsByTagName("TD")[num];
                    if (dir == "asc"){
                        if (Number(x.innerHTML) > Number(y.innerHTML)){
                            shouldSwitch = true;
                            break;
                        } 
                    } else if (dir == "desc") {
                        if (Number(x.innerHTML) < Number(y.innerHTML)){
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchCount ++;
                } else {
                    if (switchCount == 0 && dir == "asc") {     //Only true if col was already sorted ascending
                        dir = "desc";
                        switching = true;
                        headerRowCells[num].innerHTML = headerValue.slice(0, -1) + "▼";
                    }
                }
            }
        }          
    }
}

function sortWordColumn(array, table){
    headerRowCells = table.rows[0].cells;
    for (let num of array){
        headerRowCells[num].onclick = function() {
            let headerValue = headerRowCells[num].innerHTML;
            headerRowCells[num].innerHTML = headerValue.slice(0, -1) + "▲";
            let switching = true;
            let switchCount = 0;
            var shouldSwitch;
            var dir = "asc";
            while (switching) {
                switching = false;
                rows = table.rows;
                for (i=1; i < (rows.length - 1); i++){
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[num];
                    y = rows[i + 1].getElementsByTagName("TD")[num];
                    if (dir == "asc"){
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()){
                            shouldSwitch = true;
                            break;
                        } 
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()){
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchCount ++;
                } else {
                    if (switchCount == 0 && dir == "asc") {     //Only true if col was already sorted ascending
                        dir = "desc";
                        switching = true;
                        headerRowCells[num].innerHTML = headerValue.slice(0, -1) + "▼";
                    }
                }
            }
        }          
    }
}