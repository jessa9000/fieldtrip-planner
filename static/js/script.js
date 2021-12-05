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