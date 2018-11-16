/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function ChangeQuest()
{                
    var opt = document.getElementById("filtro").selectedIndex;
    var texto = document.getElementById("busqueda");
    var cat = document.getElementById("busquedacat");
    var feini = document.getElementById("busquedafeini");
    var fefin = document.getElementById("busquedafefin");

    if(opt == 2) 
        {
            texto.disabled = true;
            texto.style.display = "none";

            cat.disabled = false;
            cat.style.display = "inline";

            feini.disabled = true;
            feini.style.display = "none";
            fefin.disabled = true;
            fefin.style.display = "none";      
        }
    else if(opt == 3)
        {
            texto.disabled = true;
            texto.style.display = "none";

            cat.disabled = true;
            cat.style.display = "none";

            feini.disabled = false;
            feini.style.display = "inline";
            fefin.disabled = false;
            fefin.style.display = "inline";
        }
    else
        {
            texto.disabled = false;
            texto.style.display = "inline";

            cat.disabled = true;
            cat.style.display = "none";

            feini.disabled = true;
            feini.style.display = "none";
            fefin.disabled = true;
            fefin.style.display = "none";
        }
}
function ValidateDates(form)
{
    var opt = document.getElementById("filtro").selectedIndex;
    if(opt == 3)
        {
            var feini = document.getElementById("busquedafeini").value;
            var fefin = document.getElementById("busquedafefin").value;

            var feiniarr = feini.split("-");
            var fefinarr = fefin.split("-");


            var dini = new Date(feiniarr[0], feiniarr[1], feiniarr[2])
            var dfin = new Date(fefinarr[0], fefinarr[1], fefinarr[2])

            if(dini <= dfin)
                return true;
            else
            {
                alert("La fecha inicial es mayor que la final");
                return false;
            }
        }
    else
        return true;
}
