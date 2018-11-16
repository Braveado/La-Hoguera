<%-- 
    Document   : banUser
    Created on : 29/05/2018, 05:00:04 PM
    Author     : Nelson
--%>

<%@page import="DataBase.DBreports"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    
    DBreports reports = new DBreports();
    ResultSet reportsRS = null;     
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Bloquear Usuario - La Hoguera</title>
        <script src="js/searchValidation.js"></script> 
        <script>
            function ShowDate()
            {
                var radios = document.getElementsByName("TIME");
                var date = document.getElementById("bandate");
                
                if(radios[0].checked)
                    {
                        date.style.display = "none";
                        date.disabled = true;
                        date.required = false;
                    }
                else if(radios[1].checked)
                    {
                        date.style.display = "block";
                        date.disabled = false;
                        date.required = true;
                    }
            }
        </script>
    </head>
    <%
        String user = (String)session.getAttribute("user");         
    %>
    <body>
        <section class="principal">
            <a href="main.jsp">
                <img src="css/img/LaHoguera.png" height="90" width="500">     
            </a>
        </section>        
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
        <%                  
            Integer profid = Integer.parseInt(request.getParameter("ID"));    
            String profname = request.getParameter("USERNAME");          
        %>
        <main>
            <section class="modificarusuario">
                <ul>
                    <li class="imagen" id="banhead">
                        <img src="css/img/Invasion.png" height="60">   
                    </li>
                    <li id="pregunta">
                        <div class="subidos">
                            <div id="containerSubidos">
                                <a href="profile.jsp?USERNAME=<%=profname%>">
                                    <div id="videoSubido">
                                        <div id="usr" class="ban">
                                        <h3 class="subidos"><%=profname%></h3>
                                        <img src=readUserImages?IMAGE=PROFILE&USERNAME=<%=profname%> alt="Profile" width="50" height="50" class="subidos" id="usrpic" onerror="this.src = 'css/img/Cursed.png'">
                                        </div>
                                    </div>         
                                </a>                        
                            </div>                    
                        </div>
                    </li>   
                    <form action="banUser" method="post">
                    <li>                            
                        <label>
                            <div id="checkboxban">
                            <input type="radio" name="TIME" value="perma" onclick="ShowDate()" required>
                            <span>Bloqueo Indefinido</span>
                            </div>
                        </label>
                        <label>
                            <div id="checkboxban">
                            <input type="radio" name="TIME" value="temp" onclick="ShowDate()" required>
                            <span>Bloqueo Temporal</span>
                            </div>
                        </label>
                        <input type="date" name="EXPIRES" id="bandate">
                    </li>                     
                    <li>
                        <select name="REASON" required class="ban">
                            <option value="" disabled selected hidden>Razon del Bloqueo</option>
                            <option value="Perfil Ofensivo (Hate Speech)">Perfil Ofensivo (Hate Speech)</option>
                            <option value="Abuso del Sistema de Reportes">Abuso del Sistema de Reportes</option>
                            <option value="Multiples Videos Bloqueados">Multiples Videos Bloqueados</option>               
                        </select>
                    </li>
                    <li>
                        <textarea rows="4" id="bandetails" Placeholder="Detalles" name="DETAILS"></textarea>
                    </li>  
                        <input type="text" name="ID" class="subidos" required id="banuid" value="<%=profid%>">                        
                        <input type="text" name="USERNAME" class="subidos" required id="banuname" value="<%=profname%>"> 
                    <li>
                        <input type="submit" value="Enviar Bloqueo" class="ban">
                    </li>     
                    </form>
                </ul>
            </section>
        </main>                        
    </body>    
</html>

<%     
    reports.Disconnect();
%>
