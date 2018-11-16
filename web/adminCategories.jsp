<%-- 
    Document   : adminCategories
    Created on : 23/05/2018, 07:58:03 AM
    Author     : Nelson
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBcategories"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Administrar Categorias - La Hoguera</title>
        <script src="js/searchValidation.js"></script>
        <script>
            function SetCatsInfo(c1color, c1pos, c2color, c2pos, c3color, c3pos, c4color, c4pos, c5color, c5pos)
            {                                
                document.getElementById("c1color").value = c1color;
                document.getElementById("c1order").value = c1pos;
                
                document.getElementById("c2color").value = c2color;
                document.getElementById("c2order").value = c2pos;
                
                document.getElementById("c3color").value = c3color;
                document.getElementById("c3order").value = c3pos;
                
                document.getElementById("c4color").value = c4color;
                document.getElementById("c4order").value = c4pos;
                
                document.getElementById("c5color").value = c5color;
                document.getElementById("c5order").value = c5pos;
            }
            function ValidatePositions(form)
            {
                var c1o = document.getElementById("c1order").value;
                var c2o = document.getElementById("c2order").value;
                var c3o = document.getElementById("c3order").value;
                var c4o = document.getElementById("c4order").value;
                var c5o = document.getElementById("c5order").value;
                
                if((c1o !== c2o) && (c1o !== c3o) && (c1o !== c4o) && (c1o !== c5o) &&
                    (c2o !== c3o) && (c2o !== c4o) && (c2o !== c5o) &&
                    (c3o !== c4o) && (c3o !== c5o) &&
                    (c4o !== c5o))
                {
                    return true;
                }
                else
                {
                    alert("Hay posiciones repetidas");
                    return false;
                }                
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
            String[] colors = new String[5];
            Integer[] positions = new Integer[5];            
            DBcategories categories = new DBcategories();
            ResultSet res = categories.GetCategoriesMod(); 
            for(int i = 0; i < 5; i++)
            {                  
                res.next();
                colors[i] = res.getString("COLOR");
                positions[i] = res.getInt("POS");
            }
            categories.Disconnect();
        %>
        <main>    
            <section class="modificarusuario">
                <form method="post" action="adminCategories" onsubmit="return ValidatePositions(this)"> 
                    <ul>
                        <li class="imagen">
                            <h2>
                                Modificar Categorias
                            </h2>
                        </li> 
                        <li id="pregunta">
                            <h3>Dark Souls 1</h3>
                        </li>                        
                        <li>
                            <input type="color" name="C1COLOR" id="c1color" required><select name="C1ORDER" required id="c1order">
                                <option value="" disabled selected hidden>Posicion</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>                            
                        </li>
                        <li id="pregunta">
                            <h3>Dark Souls 2</h3>
                        </li>                        
                        <li>
                            <input type="color" name="C2COLOR" id="c2color" required><select name="C2ORDER" required id="c2order">
                                <option value="" disabled selected hidden>Posicion</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>                            
                        </li>
                        <li id="pregunta">
                            <h3>Dark Souls 3</h3>
                        </li>                        
                        <li>
                            <input type="color" name="C3COLOR" id="c3color" required><select name="C3ORDER" required id="c3order">
                                <option value="" disabled selected hidden>Posicion</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>                            
                        </li>
                        <li id="pregunta">
                            <h3>PVP</h3>
                        </li>                        
                        <li>
                            <input type="color" name="C4COLOR" id="c4color" required><select name="C4ORDER" required id="c4order">
                                <option value="" disabled selected hidden>Posicion</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>                            
                        </li>
                        <li id="pregunta">
                            <h3>PVE</h3>
                        </li>                        
                        <li>
                            <input type="color" name="C5COLOR" id="c5color" required><select name="C5ORDER" required id="c5order">
                                <option value="" disabled selected hidden>Posicion</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>                            
                        </li>
                        <li>
                            <input type="submit" value="Modificar">
                        </li> 
                    </ul>
                </form>
            </section> 
            <section class="modificarusuario">
                <ul>
                    <li class="imagen">
                        <img src="css/img/Tools.png" height="60">
                    </li>
                    <li>
                        <input type="button" value="Reiniciar Campos" onclick="SetCatsInfo('<%=colors[0]%>', <%=positions[0]%>, '<%=colors[1]%>', <%=positions[1]%>, '<%=colors[2]%>', <%=positions[2]%>, '<%=colors[3]%>', <%=positions[3]%>, '<%=colors[4]%>', <%=positions[4]%>)">
                    </li> 
                </ul>
            </section>
        </main>
        <script>SetCatsInfo('<%=colors[0]%>', <%=positions[0]%>, '<%=colors[1]%>', <%=positions[1]%>, '<%=colors[2]%>', <%=positions[2]%>, '<%=colors[3]%>', <%=positions[3]%>, '<%=colors[4]%>', <%=positions[4]%>);</script>
    </body>    
</html>
