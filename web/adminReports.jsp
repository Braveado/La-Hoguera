<%-- 
    Document   : adminReports
    Created on : 27/05/2018, 03:09:30 AM
    Author     : Nelson
--%>

<%@page import="DataBase.DBreports"%>
<%@page import="DataBase.DBfavorites"%>
<%@page import="DataBase.DBusers"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBsharedContent"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    
    DBreports reports = new DBreports();
    ResultSet reportsRS = null; 
    
    DBsharedContent sharedContent = new DBsharedContent();
    ResultSet sharedContentRS = null;
    
    DBusers users = new DBusers();
    ResultSet usersRS = null;    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Administrar Reportes - La Hoguera</title>
        <script src="js/searchValidation.js"></script>          
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
        <main>
            <section class="subidos"> 
                <ul>
                    <li class="imagen">
                        <img src="css/img/Report.png" height="60">   
                    </li>
                    <li id="preguntaban">
                        <div class="subidos">
                            <div id="containerSubidos"> 
                                <%
                                    reportsRS = reports.GetReports();
                                    while(reportsRS.next())
                                    {
                                        Integer vid = reportsRS.getInt("VIDEOID");
                                        sharedContentRS = sharedContent.GetVideoInfo(vid);
                                        if(sharedContentRS.next())
                                        {        
                                            usersRS = users.GetName(reportsRS.getInt("REPORTERID"));
                                            usersRS.next();
                                            String repname =  usersRS.getString("USERNAME");
                                            
                                            out.print("<div id=\"videoSubido\">");
                                            out.print("<a href=\"profile.jsp?USERNAME="+repname+"\">");
                                            out.print("<div id=\"usr\">");
                                            out.print("<h3 class=\"subidos\">"+repname+"</h3>");
                                            out.print("<img src=readUserImages?IMAGE=PROFILE&USERNAME="+repname+" alt=\"Profile\" width=\"50\" height=\"50\" class=\"subidos\" id=\"usrpic\" onerror=\"this.src = 'css/img/Cursed.png'\">");                                            
                                            out.print("<h3 class=\"subidos\">"+reportsRS.getString("REASON")+"</h3>");
                                            out.print("</div>");
                                            out.print("</a>");
                                            
                                            Integer profid = sharedContentRS.getInt("USERID");
                                            String title = sharedContentRS.getString("TITLE");
                                            String cat = sharedContentRS.getString("CATEGORY1");
                                            Integer reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                            Integer likes = sharedContentRS.getInt("LIKES");
                                            Integer favs = sharedContentRS.getInt("FAVORITES");
                                            java.sql.Date uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime()); 
                                            Boolean restr = sharedContentRS.getBoolean("RESTRICTED");

                                            usersRS = users.GetName(profid);
                                            usersRS.next();
                                            String profname =  usersRS.getString("USERNAME");
                                            
                                            out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                            out.print("<div id=\"vid\" class=\"ban\">");
                                            out.print("<h3 id=\"titulo\" class=\"subidos\">"+title+"</h3>");
                                            out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">");
                                            out.print("<table class=\"stats\">");
                                            out.print("<tr>");
                                            out.print("<td>"+cat+"</td>");
                                            out.print("<td><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod+"</td>");
                                            out.print("</tr> ");
                                            out.print("<tr>");
                                            if(restr)
                                                out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            else
                                                out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");                                            
                                            out.print("<td><img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<td>"+uploaded+"</td>");
                                            out.print("<td><img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</td>");
                                            out.print("</tr>");
                                            out.print("</table> ");
                                            out.print("</div>");
                                            out.print("</a>");
                                            out.print("<a href=\"profile.jsp?USERNAME="+profname+"\">");
                                            out.print("<div id=\"usr\" class=\"ban\">");
                                            out.print("<h3 class=\"subidos\">"+profname+"</h3>");
                                            out.print("<img src=readUserImages?IMAGE=PROFILE&USERNAME="+profname+" alt=\"Profile\" width=\"50\" height=\"50\" class=\"subidos\" id=\"usrpic\" onerror=\"this.src = 'css/img/Cursed.png'\">");
                                            out.print("</div>");
                                            out.print("</a>");
                                            out.print("<div id=\"buttons\">");                                            
                                            out.print("<form action=\"banVideo\" method=\"post\">");
                                            out.print("<input type=\"text\" name=\"RID\" value="+reportsRS.getInt("ID")+" class=\"subidos\" required>");
                                            out.print("<input type=\"text\" name=\"VID\" value="+vid+" class=\"subidos\" required>");
                                            out.print("<input type=\"text\" name=\"TITLE\" value='"+title+"' class=\"subidos\" required>");
                                            out.print("<input type=\"submit\" value=\"Bloquear Video\" class=\"bansubidos\">");
                                            out.print("</form>");
                                            out.print("<form method=\"post\" action=\"banUser.jsp\">");
                                            out.print("<input type=\"text\" name=\"ID\" value="+profid+" class=\"subidos\" required>");
                                            out.print("<input type=\"text\" name=\"USERNAME\" value='"+profname+"' class=\"subidos\" required>");
                                            out.print("<input type=\"submit\" value=\"Bloquear Usuario\" class=\"bansubidos\">");                                            
                                            out.print("</form>");
                                            out.print("<form action=\"delReport\" method=\"post\">");
                                            out.print("<input type=\"text\" name=\"ID\" value="+reportsRS.getInt("ID")+" class=\"subidos\" required>");
                                            out.print("<input type=\"submit\" value=\"Eliminar Reporte\" class=\"bansubidos\">");
                                            out.print("</form>");                                            
                                            out.print("</div>");
                                            out.print("</div>");
                                            
                                        }
                                    }
                                %>                                            
                            </div>                    
                        </div>
                    </li>
                </ul>
            </section>    
        </main>                        
    </body>    
</html>

<%
    sharedContent.Disconnect(); 
    users.Disconnect();
%>
