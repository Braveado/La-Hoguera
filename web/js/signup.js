/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function UpdateAvatar()
{
    document.getElementById('avatarlabel').textContent = document.getElementById('avatarfile').value.split('\\').pop().split('/').pop();
}

function UpdateCover()
{
    document.getElementById('coverlabel').textContent = document.getElementById('coverfile').value.split('\\').pop().split('/').pop();
}

function ValidateForm(form)
{
    /* paswwords */
    var p = document.getElementById('pass').value;
    var rp = document.getElementById('repass').value;
    if(p!=rp)
        {
            alert("Contraseñas diferentes")
            return false;
        }
    else
        {
            /* empty strings */
            var controls = form.elements;
            for (var i=0; i<controls.length; i++) 
            {
                controls[i].disabled = controls[i].value == "";
            }
            return true;
        }    
}

function ValidateFormModify(form, user)
{
    /* prevent admin credentials change */
    var name = document.getElementById('nombre').value;
    var email = document.getElementById('correo').value;
    if(user === "admin" && (name !== "" || email !== ""))
    {
        alert("Prohibido cambiar nombre y/o correo del administrador");
        return false;
    }
    /* paswwords */
    var p = document.getElementById('pass').value;
    var rp = document.getElementById('repass').value;
    if(p!==rp)
        {
            alert("Contraseñas diferentes");
            return false;
        }
    else
        {
            /* empty strings */
            var controls = form.elements;
            for (var i=0; i<controls.length; i++) 
            {
                controls[i].disabled = controls[i].value === "";
            }
            return true;
        }    
}

function SetRequired()
{
    document.getElementById('nombre').required = true;
    document.getElementById('correo').required = true;
    document.getElementById('pass').required = true;
    document.getElementById('repass').required = true;
    document.getElementById('selectimportant').required = true;
    document.getElementById('resp').required = true;
}

function UnsetRequired()
{
    document.getElementById('nombre').required = false;
    document.getElementById('correo').required = false;
    document.getElementById('pass').required = false;
    document.getElementById('repass').required = false;
    document.getElementById('selectimportant').required = false;
    document.getElementById('resp').required = false;
}

function UndoChanges()
{
    document.getElementById('avatarlabel').textContent = "Perfil";
    document.getElementById('coverlabel').textContent = "Portada";
    
    var ciudades = document.getElementById('cities'); 
    while (ciudades.options.length)
        {
            ciudades.remove(0);
        }
    var ph = new Option("Ciudad", "");
    ph.setAttribute("disabled", true);
    ph.setAttribute("selected", true);
    ph.setAttribute("hidden", true);
    ciudades.options.add(ph);
}

