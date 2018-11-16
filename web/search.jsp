<%-- 
    Document   : search
    Created on : 24/05/2018, 02:09:29 PM
    Author     : Nelson
--%>

<%@page import="DataBase.DBreports"%>
<%@page import="DataBase.DBusers"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBsharedContent"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DBsharedContent sharedContent = new DBsharedContent();
    ResultSet sharedContentRS = null;
    
    DBusers users = new DBusers();
    ResultSet usersRS = null;
    
    DBreports reports = new DBreports();
    ResultSet reportsRS = null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Buscar Videos - La Hoguera</title>
        <script src="js/searchValidation.js"></script> 
        <script>
            function SetLastSearch(filter, quest, questc, questf1, questf2)
            {
                document.getElementById("filtro").value = filter;
                
                if(quest !== "null")
                    document.getElementById("busqueda").value = quest;
                
                if(questc !== "null")
                    document.getElementById("busquedacat").value = questc;
                
                if(questf1 !== "null")
                    document.getElementById("busquedafeini").value = questf1;
                
                if(questf2 !== "null")
                    document.getElementById("busquedafefin").value = questf2;
                
                ChangeQuest();                
            }
            function SetNumEncontrados(encontrados, filter, quest, questc, questf1, questf2)
            {
                var resultado = encontrados+" Videos";
                if(encontrados === "1")
                    resultado = encontrados+" Video";
                
                if(quest != "null" && filter === "Titulo")
                    resultado = resultado+" con \""+quest+"\" en el Titulo";
                else if(quest != "null" && filter === "Usuario")
                    resultado = resultado+" de Usuarios con \""+quest+"\" en su Nombre";
                else if(questc != "null")
                    resultado = resultado+" de la Categoria \""+questc+"\"";
                else if(questf1 != "null" && questf2 != "null")
                    resultado = resultado+" en el Rango de Fechas de \""+questf1+"\" a \""+questf2+"\"";
                
                document.getElementById("numencontrados").textContent = resultado;
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
            String filter = request.getParameter("FILTER");
            String quest = request.getParameter("QUEST");
            String questc = request.getParameter("QUESTC");
            String questf1 = request.getParameter("QUESTF1");
            String questf2 = request.getParameter("QUESTF2");
        %>
        <script>SetLastSearch('<%=filter%>', '<%=quest%>', '<%=questc%>', '<%=questf1%>', '<%=questf2%>')</script>
        <main>
            <section class="subidos">                                
                <h2 class="subidos" id="numencontrados">                    
                    X Videos Encontrados
                </h2>                
                <div class="subidos">
                    <div id="containerSubidos">                                               
                        <%      
                            Integer encontrados = 0;
                            sharedContentRS = sharedContent.FindVideos(filter, quest, questc, questf1, questf2); 
                            if(sharedContentRS.next())
                            {
                                Integer vid = null;  
                                Integer profid = null; 
                                String title = null;
                                String cat = null;
                                Integer reprod = null;
                                Integer likes = null; 
                                Integer favs = null;
                                java.sql.Date uploaded = null;
                                String profname = null;                                                                 
                                do
                                {               
                                    vid = sharedContentRS.getInt("ID");
                                    reportsRS = reports.CheckBannedVideo(vid);
                                    if(!reportsRS.next())
                                    {                                                                          
                                        profid = sharedContentRS.getInt("USERID");
                                        reportsRS = reports.CheckBannedUser(profid);
                                        if(!reportsRS.next())
                                        {
                                            encontrados++; 
                                            title = sharedContentRS.getString("TITLE");
                                            cat = sharedContentRS.getString("CATEGORY1");
                                            reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                            likes = sharedContentRS.getInt("LIKES");
                                            favs = sharedContentRS.getInt("FAVORITES");
                                            uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime());                                     

                                            out.print("<div id=\"videoSubido\">");
                                            out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                            out.print("<div id=\"vid\">");
                                            out.print("<h3 id=\"titulo\" class=\"subidos\">" + title + "</h3>");                                    
                                            out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">"); 
                                            out.print("<h3 class=\"subidos\">"+cat+"</h3>");
                                            out.print("<h3 class=\"subidos\"><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod);
                                            out.print(" <img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes);
                                            out.print(" <img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</h3>");
                                            out.print("<h3 class=\"subidos\">"+uploaded+"</h3>");
                                            out.print("</div>");
                                            out.print("</a>");  

                                            usersRS = users.GetName(profid);
                                            usersRS.next();
                                            profname =  usersRS.getString("USERNAME");

                                            out.print("<a href=\"profile.jsp?USERNAME="+profname+"\">");
                                            out.print("<div id=\"usr\">");                                                                      
                                            out.print("<img src=readUserImages?IMAGE=PROFILE&USERNAME="+profname+" alt=\"Profile\" width=\"50\" height=\"50\" class=\"subidos\" id=\"usrpic\" onerror=\"this.src = 'css/img/Cursed.png'\">");
                                            out.print("<h3 class=\"subidos\">"+profname+"</h3>");  
                                            out.print("</div>");
                                            out.print("</a>");
                                            out.print("</div>");
                                        }
                                    }
                                } 
                                while(sharedContentRS.next());
                            }                                                            
                        %>                        
                    </div>
                </div>                
            </section>
            <script>SetNumEncontrados('<%=encontrados%>', '<%=filter%>', '<%=quest%>', '<%=questc%>', '<%=questf1%>', '<%=questf2%>');</script>
        </main>                        
    </body>    
</html>

<%
    sharedContent.Disconnect();
    users.Disconnect();
    reports.Disconnect();
%>
