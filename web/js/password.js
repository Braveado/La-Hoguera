/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function ValidateAnswer(answer)
{
    var respuesta = document.getElementById("resp").value;
    if(respuesta !== answer)
    {
        alert("Respuesta incorrecta"); 
    }
    else
    {
        document.getElementById("rc1").style.display = "none";
        document.getElementById("rc2").style.display = "block";
    }
}

function AntiAdmin(form)
{
    var u = document.getElementById('user').value;
    if(u === "admin")
        {
            alert("No se puede cambiar la contraseña del administrador");            
            return false;
        }
    else
        {
            return true;
        }
    
}

function ValidatePassword(form)
{
    var p = document.getElementById('pass').value;
    var rp = document.getElementById('repass').value;
    if(p !== rp)
        {
            alert("Contraseñas diferentes");            
            return false;
        }
    else
        {
            return true;
        }
    
}


