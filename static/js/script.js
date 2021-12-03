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