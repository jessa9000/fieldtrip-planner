// This is the file where we will keep client-side scripts. //

function checkTelNo(){
    let telephone = document.getElementById('phone');
    let telValue = telephone.value;
    console.log(telValue);
    if(telValue.length < 10) {
        event.preventDefault(); 
        alert("Telephone numbers must be at least 10 digits long.");
        return false;
    }
    return true;
}

//Citation: the following sort function is adapted from https://www.w3schools.com/howto/howto_js_sort_table.asp//

function sortNumColumn(){
    table = document.getElementById("allergiesTable");
    headerRowCells = table.rows[0].cells;
    // for (let headerCell of headerRowCells) {
    //     headerCell.onclick = function(){        //listener on each header cell kicks off a callback function
    //         let tBody = table.tBodies[0];       //extract the body from what is aprntly an array of table bodies
    //         let rows = tBody.rows;              //focus on rows of the body
    //         for (let row of rows) {             //now we're iterating through each row
    //             let cells = row.cells;
                
    //         }
    //     }
    // }
    headerRowCells[3].onclick = function() {
        headerRowCells[3].innerHTML = "Allergen ID ▲";
        let switching = true;
        let switchCount = 0;
        var shouldSwitch;
        var dir = "asc";
        while (switching) {
            switching = false;
            rows = table.rows;
            for (i=1; i < (rows.length - 1); i++){
                shouldSwitch = false;
                x = rows[i].getElementsByTagName("TD")[3];
                y = rows[i + 1].getElementsByTagName("TD")[3];
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
                    headerRowCells[3].innerHTML = "Allergen ID ▼";
                }
            }
        }
    }
}
