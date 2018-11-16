/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function CheckSession(user)
{
    if(user === "null")
    {
        alert("No hay una sesion iniciada");
        location='login.jsp';
    }
}
