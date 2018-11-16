<%-- 
    Document   : profileModify
    Created on : 7/05/2018, 11:41:14 PM
    Author     : Nelson
--%>

<%@page import="DataBase.DBusers"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <script src="js/logAlert.js"></script>
        <title>Modificar Perfil - La Hoguera</title> 
        <script src="js/signup.js"></script>
        <script src="js/searchValidation.js"></script>
        <script type="text/javascript">
            function CheckUser(user)
            {
                if(user === "Anonimo")
                {
                    alert("Prohibido para usuarios anonimos");
                    location='main.jsp';
                }
            } 
            
            var Mexico = ['Monterrey', 'Guadalajara', 'Tijuana'];
            var EstadosUnidos = ['New York', 'Chicago', 'Seatle'];
            var Canada = ['Montreal', 'Edmonton', 'Waterloo'];

            function UpdateCities()
            {   
                var paises = document.getElementById('countries');
                var ciudades = document.getElementById('cities');
                switch (paises.value) 
                {
                    case 'Mexico':
                        FillCities(ciudades, Mexico);
                        break;
                    case 'Estados Unidos':
                        FillCities(ciudades, EstadosUnidos);
                        break;
                    case 'Canada':
                        FillCities(ciudades, Canada);
                        break;
                    default:
                        ciudades.options.length = 0;
                        break;
                }
            }
            function FillCities(select, options)
            {
                select.options.length = 0;
                for (i = 0; i < options.length; i++) 
                {
                    var opt = new Option(options[i], options[i]);
                    select.options.add(opt);
                }
                var ph = new Option("Ciudad", "");
                ph.setAttribute("disabled", true);
                ph.setAttribute("selected", true);
                ph.setAttribute("hidden", true);
                select.options.add(ph);
            }    
        </script>
    </head>
    <% String user = (String)session.getAttribute("user"); %>
    <body>
        <section class="principal">
            <a href="main.jsp">
                <img src="css/img/LaHoguera.png" height="90" width="500">     
            </a>
        </section>
        <script>CheckSession("<%=user%>");</script>
        <header class="cabecera">                                  
            <table>
                <tr>
                    <td id="perfillink" class="border">                        
                        <a href="login.jsp">
                            <table>
                                <tr id="perfil">
                                    <td align="left" >
                                        <img src="css/img/Exit.png" alt="SALIR" width="50" height="50" id="avatar"> 
                                    </td>
                                    <td align="left">
                                        <h3>Salir de Sesion</h3>   
                                    </td>                                    
                                </tr>
                            </table>
                        </a> 
                    </td>
                    <form action="search.jsp" onsubmit="return ValidateDates(this)">
                        <td id="buscar">
                            <select name="FILTER" class="buscacion" required onchange="ChangeQuest()" id="filtro">
                                <option value="Titulo">Titulo</option>
                                <option value="Usuario">Usuario</option>
                                <option value="Categoria">Categoria</option>
                                <option value="Rango de Fechas">Rango de Fechas</option>
                            </select>
                            
                            <input type="text" name="QUEST" placeholder="Busqueda" maxlengh="50" required id="busqueda">
                            
                            <select name="QUESTC" id="busquedacat" required disabled>
                                <option value="" disabled selected hidden>Busqueda</option>
                                <option value="Dark Souls 1">Dark Souls 1</option>
                                <option value="Dark Souls 2">Dark Souls 2</option>
                                <option value="Dark Souls 3">Dark Souls 3</option>
                                <option value="PvP">PvP</option> 
                                <option value="PvE">PvE</option> 
                            </select>
                            
                            <input type="date" name="QUESTF1" id="busquedafeini" required disabled>
                            <input type="date" name="QUESTF2" id="busquedafefin" required disabled>
                            
                            <input type="submit" value="Buscar" class="buscacion">
                        </td>
                    </form>
                    <td id="perfillink" class="border">                        
                        <a href="profile.jsp?USERNAME=<%=user%>">
                            <table>
                                <tr id="perfil">
                                    <td align="right">
                                        <h3><%=user%></h3>   
                                    </td>
                                    <td align="right" >
                                        <img src="readUserImages?IMAGE=PROFILE&USERNAME=<%=user%>" alt="Profile" width="50" height="50" id="avatar" onerror="this.src = 'css/img/Cursed.png'">
                                    </td>
                                </tr>
                            </table>
                        </a> 
                    </td>
                </tr>                
            </table>            
        </header>
        <script>CheckUser("<%=user%>");</script>
        <main>
            <form enctype="multipart/form-data" method="post" action="profileModify" onsubmit="return ValidateFormModify(this, '<%=user%>')">
                <section class="modificarusuario">
                    <ul>
                        <li class="imagen">
                            <img src="css/img/Summon.png" height="60">
                        </li>
                        <li>   
                            <p>Modificar</p>
                            <label>
                                <div id="checkbox">
                                <input type="radio" name="METHOD" value="new" checked onchange="UnsetRequired()">
                                <span>Solo campos llenos</span>
                                </div>
                            </label>
                            <label>
                                <div id="checkbox">
                                <input type="radio" name="METHOD" value="all" onchange="SetRequired()">
                                <span>Sobreescritura total</span>
                                </div>
                            </label>
                        </li>
                        <li>
                            <p>Usuario</p>
                            <input type="text" name="USERNAME" placeholder="Nombre de usuario" id="nombre"> 
                            <input type="email" name="EMAIL" placeholder="Correo Electronico" id="correo"> 
                        </li>
                        <li>
                            <p>Contraseña</p>
                            <input type="password" name="PASSWORD" placeholder="Contraseña" id="pass">
                            <input type="password" placeholder="Repetir Contraseña" id="repass">
                        </li> 
                        <li>
                            <p>Pregunta Secreta</p>
                            <select name="QUESTION" id="selectimportant">
                                <option value="" disabled selected hidden>Pregunta</option>
                                <option value="Primer Jefe que me mato?">Porque estoy en llamas?</option>
                                <option value="Que anillos tienes?">Que anillos tienes?</option>
                                <option value="La leyenda nunca muere?">La leyenda nunca muere?</option> 
                            </select>
                            <input type="text" name="ANSWER" placeholder="Respuesta" id="resp"> 
                        </li>
                        <li>    
                            <p>Imagenes</p>
                            <input type="file" id="avatarfile" name="PROFILE" accept=".jpg, .jpeg, .png" onchange="UpdateAvatar()">
                            <label class="filelabel" id="avatarlabel" for="avatarfile">
                            Perfil
                            </label>                       
                            <input type="file" id="coverfile" name="COVER" accept=".jpg, .jpeg, .png" onchange="UpdateCover()">
                            <label class="filelabel" id="coverlabel" for="coverfile">
                            Portada
                            </label>
                        </li>
                        <li>
                            <p>Fecha de Nacimiento</p>
                            <input type="date" name="BIRTHDATE">
                        </li>
                        <li>   
                            <p>Genero</p>
                            <label>
                                <div id="checkbox">
                                <input type="radio" name="GENDER" value="Hombre">
                                <span>Hombre</span>
                                </div>
                            </label>
                            <label>
                                <div id="checkbox">
                                <input type="radio" name="GENDER" value="Mujer">
                                <span>Mujer</span>
                                </div>
                            </label>
                        </li>   
                        <li class="notlast">
                            <p>Lugar de Residencia</p>
                            <select name="COUNTRY" id="countries" onchange="UpdateCities()">
                                <option value="" disabled selected hidden>Pais</option>
                                <option value="Mexico">Mexico</option>
                            <option value="Estados Unidos">Estados Unidos</option>
                            <option value="Canada">Canada</option>  
                            </select>
                            <select name="CITY" id="cities">
                                <option value="" disabled selected hidden>Ciudad</option>
                            </select>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <input type="submit" value="Modificar Perfil">
                        </li>
                    </ul>
                </section>
                <section class="modificarusuario">
                    <ul>
                        <li class="imagen">
                            <img src="css/img/Tools.png" height="60">
                        </li>
                        <li>
                            <input type="reset" value="Reiniciar Campos" onclick="UndoChanges()">
                        </li> 
                    </ul>
                </section>
            </form>
        </main>
    </body>
</html>
