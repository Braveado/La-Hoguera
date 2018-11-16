<%-- 
    Document   : reportVideo
    Created on : 26/05/2018, 07:58:35 PM
    Author     : Nelson
--%>

<%@page import="DataBase.DBfavorites"%>
<%@page import="DataBase.DBusers"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBsharedContent"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    
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
        <title>Reportar Video - La Hoguera</title>
        <script src="js/searchValidation.js"></script>  
        <script>
            function SetReportInfo(vid, profid, vname)
            {
                document.getElementById("repvid").value = vid;
                document.getElementById("repprofid").value = profid;
                document.getElementById("repvname").value = vname;
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
            Integer vid = Integer.parseInt(request.getParameter("ID"));             
            sharedContentRS = sharedContent.GetVideoInfo(vid); 
            sharedContentRS.next();

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
                               <div id="videoSubido">  
                                   <a href="playVideo.jsp?ID=<%=vid%>">
                                   <div id="vid" class="ban">
                                   <h3 id="titulo" class="subidos"><%=title%></h3>
                                   <img src=readVideo?ID=<%=vid%> width="240" height="140" class="subidos"> 
                                   <table class="stats">
                                       <tr>
                                           <td><%=cat%></td>
                                           <td><img src="css/img/Binoculars.png" width="24" height="24" class="icon"> <%=reprod%></td>
                                       </tr>    
                                       <tr>
                                           <%
                                                if(restr)
                                                    out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                                else
                                                    out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                           %>                                                                                                                                 
                                           <td><img src="css/img/PrismStone.png" width="24" height="24" class="icon"> <%=likes%></td>  
                                       </tr>
                                       <tr>
                                           <td><%=uploaded%></td>
                                           <td><img src="css/img/SunlightMedal.png" width="24" height="24" class="icon"> <%=favs%></td>
                                       </tr>
                                   </table>                                
                                   </div> 
                                   </a>
                                   <a href="profile.jsp?USERNAME=<%=profname%>">
                                   <div id="usr" class="ban">
                                   <h3 class="subidos"><%=profname%></h3>
                                   <img src=readUserImages?IMAGE=PROFILE&USERNAME=<%=profname%> alt="Profile" width="50" height="50" class="subidos" id="usrpic" onerror="this.src = 'css/img/Cursed.png'">
                                   </div>
                                   </a>
                               </div>                                                            
                           </div>                    
                       </div>
                    </li>
                    <form action="reportVideo" method="post">
                        <li>
                            <select name="REASON" required class="ban">
                                <option value="" disabled selected hidden>Razon del Reporte</option>
                                <option value="Contenido irrelevante (Clickbait)">Contenido irrelevante (Clickbait)</option>
                                <option value="Contenido ofensivo (Hate Speech)">Contenido ofensivo (Hate Speech)</option>
                                <option value="El contenido no pertenece a La Hoguera">El contenido no pertenece a La Hoguera</option>                            
                            </select>
                        </li>
                        <input type="text" name="VID" class="subidos" required id="repvid">    
                        <input type="text" name="PROFID" class="subidos" required id="repprofid"> 
                        <input type="text" name="TITLE" class="subidos" required id="repvname">                        
                        <li>
                            <input type="submit" value="Enviar Reporte" class="ban">
                        </li>
                    </form>                    
                </ul>
            </section>
            <script>SetReportInfo('<%=vid%>', '<%=profid%>', '<%=title%>');</script>
        </main>                        
    </body>    
</html>

<%
    sharedContent.Disconnect(); 
    users.Disconnect();
%>
