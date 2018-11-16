<%-- 
    Document   : main
    Created on : 6/05/2018, 10:03:38 PM
    Author     : Nelson
--%>

<%@page import="DataBase.DBreports"%>
<%@page import="DataBase.DBusers"%>
<%@page import="DataBase.DBsharedContent"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBcategories"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>          

<%
    DBcategories categories = new DBcategories();
    ResultSet categoriesRS = null;
    
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
        <script src="js/logAlert.js"></script>
        <script src="js/searchValidation.js"></script>
        <title>La Hoguera</title>
        <script>
            var tas = false;
            function ToggleAllSec()
            {
                if(!tas)
                {
                    document.getElementById("vmrp").style.display = "none";
                    document.getElementById("vmrc").style.display = "none";
                    document.getElementById("vf").style.display = "none";
                    document.getElementById("vmrcfol").style.display = "none";
                    tas = true
                }
                else
                {
                    document.getElementById("vmrp").style.display = "block";
                    document.getElementById("vmrc").style.display = "block";
                    document.getElementById("vf").style.display = "block";
                    document.getElementById("vmrcfol").style.display = "block";
                    tas = false;
                }
            }
            function Toggleable(id)
            {
                if(document.getElementById(id).style.display !== "none")
                    document.getElementById(id).style.display = "none";
                else
                    document.getElementById(id).style.display = "block";

            }    
            var tac = false;
            function ToggleAllCat()
            {
                if(!tac)
                {
                    document.getElementById("cat1").style.display = "none";
                    document.getElementById("cat2").style.display = "none";
                    document.getElementById("cat3").style.display = "none";
                    document.getElementById("cat4").style.display = "none";
                    document.getElementById("cat5").style.display = "none";
                    tac = true
                }
                else
                {
                    document.getElementById("cat1").style.display = "block";
                    document.getElementById("cat2").style.display = "block";
                    document.getElementById("cat3").style.display = "block";
                    document.getElementById("cat4").style.display = "block";
                    document.getElementById("cat5").style.display = "block";
                    tac = false;
                }
            }
            function ShowSubidosCat(id, name, subidos)
            {
                var term = "Videos";
                if(subidos === "1")
                    term = "Video";
                document.getElementById(id).textContent = subidos + " "+term+" de " + name;                                
            } 
            function ShowOrderCats(show, order)
            {                                
                if(show === "false")
                    document.getElementById("valcat").style.display = "none";                                
                
                if(order !== "null")                
                    document.getElementById("ordencat").value = order;
            }                        
            function SubmitForm(id)
            {
                document.getElementById(id).submit();
            }
        </script>
    </head>
    <%
        String user = (String)session.getAttribute("user");
        Integer userid = (Integer)session.getAttribute("userid");
    %>     
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
                                    <td align="right">
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
            <%                
                if(user.compareTo("admin")==0 || userid == 14)
                {
                    out.println("<section class=\"modificarusuario\">");
                    out.println("<ul>");
                    out.println("<li class=\"imagen\">");
                    out.println("<img src=\"css/img/Tools.png\" height=\"60\">");
                    out.println("</li>");
                    out.println("<li>");
                    out.println("<a href=\"adminCategories.jsp\">");
                    out.println("<input type=\"submit\" value=\"Administrar Categorias\" class=\"subbutton\">");
                    out.println("</a>");
                    out.println("</li>");
                    out.println("<li>");
                    out.println("<a href=\"adminReports.jsp\">");
                    out.println("<input type=\"submit\" value=\"Administrar Reportes\" class=\"subbutton\">");
                    out.println("</a>");
                    out.println("</li>");
                    out.println("<li>");
                    out.println("<a href=\"adminBans.jsp\">");
                    out.println("<input type=\"submit\" value=\"Administrar Bloqueos\" class=\"subbutton\">");
                    out.println("</a>");
                    out.println("</li>");
                    out.println("</ul>");
                    out.println("</section>");
                }
            %>            
            <section class="subidos">                                
                <h2 class="subidos" id="togall" onclick="ToggleAllSec()">
                    Secciones
                </h2>
                <h2 class="subidossec" onclick="Toggleable('vmrp')">Videos Mas Reproducidos</h2> 
                <div class="subidos" id="vmrp">
                    <div id="containerSubidos">                                               
                        <%                                             
                            sharedContentRS = sharedContent.GetMostRepVideos(); 
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
                                Boolean restr = false;
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
                                            title = sharedContentRS.getString("TITLE");
                                            cat = sharedContentRS.getString("CATEGORY1");
                                            reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                            likes = sharedContentRS.getInt("LIKES");
                                            favs = sharedContentRS.getInt("FAVORITES");
                                            uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime()); 
                                            restr = sharedContentRS.getBoolean("RESTRICTED");

                                            out.print("<div id=\"videoSubido\">");
                                            out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                            out.print("<div id=\"vid\">");
                                            out.print("<h3 id=\"titulo\" class=\"subidos\">" + title + "</h3>");                                    
                                            out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">"); 

                                            out.print("<table class=\"stats\">");
                                            out.print("<tr>");
                                            out.print("<td>"+cat+"</td>");
                                            out.print("<td><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<td>"+uploaded+"</td>");
                                            out.print("<td><img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");

                                            if(restr)
                                                out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            else
                                                out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            out.print("<td><img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</td>");
                                            out.print("</tr>");
                                            out.print("</table>");

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
                <h2 class="subidossec" onclick="Toggleable('vmrc')">Videos Mas Recientes</h2> 
                <div class="subidos" id="vmrc">
                    <div id="containerSubidos">                                               
                        <%                                             
                            sharedContentRS = sharedContent.GetLeastUplVideos(); 
                            if(sharedContentRS.next())
                            {
                                Integer vid = null;  
                                Integer profid = null; 
                                String title = null;
                                String cat = null;
                                Integer reprod = null;
                                Integer likes = null; 
                                Integer favs = null;
                                Boolean restr = false;
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
                                            title = sharedContentRS.getString("TITLE");
                                            cat = sharedContentRS.getString("CATEGORY1");
                                            reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                            likes = sharedContentRS.getInt("LIKES");
                                            favs = sharedContentRS.getInt("FAVORITES");
                                            uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime());                                     
                                            restr = sharedContentRS.getBoolean("RESTRICTED");

                                            out.print("<div id=\"videoSubido\">");
                                            out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                            out.print("<div id=\"vid\">");
                                            out.print("<h3 id=\"titulo\" class=\"subidos\">" + title + "</h3>");                                    
                                            out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">"); 
                                            out.print("<table class=\"stats\">");
                                            out.print("<tr>");
                                            out.print("<td>"+cat+"</td>");
                                            out.print("<td><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<td>"+uploaded+"</td>");
                                            out.print("<td><img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");

                                            if(restr)
                                                out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            else
                                                out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            out.print("<td><img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</td>");
                                            out.print("</tr>");
                                            out.print("</table>");
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
                <h2 class="subidossec" onclick="Toggleable('vf')">Videos Favoritos</h2> 
                <div class="subidos" id="vf">
                    <div id="containerSubidos">                                               
                        <%                                             
                            sharedContentRS = sharedContent.GetRndFavVideos(); 
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
                                Boolean restr = false;
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
                                            title = sharedContentRS.getString("TITLE");
                                            cat = sharedContentRS.getString("CATEGORY1");
                                            reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                            likes = sharedContentRS.getInt("LIKES");
                                            favs = sharedContentRS.getInt("FAVORITES");
                                            uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime());  
                                            restr = sharedContentRS.getBoolean("RESTRICTED");

                                            out.print("<div id=\"videoSubido\">");
                                            out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                            out.print("<div id=\"vid\">");
                                            out.print("<h3 id=\"titulo\" class=\"subidos\">" + title + "</h3>");                                    
                                            out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">"); 
                                            out.print("<table class=\"stats\">");
                                            out.print("<tr>");
                                            out.print("<td>"+cat+"</td>");
                                            out.print("<td><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<td>"+uploaded+"</td>");
                                            out.print("<td><img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");

                                            if(restr)
                                                out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            else
                                                out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            out.print("<td><img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</td>");
                                            out.print("</tr>");
                                            out.print("</table>");
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
                <h2 class="subidossec" onclick="Toggleable('vmrcfol')">Videos Mas Recientes de Usuarios que Sigues</h2> 
                <div class="subidos" id="vmrcfol">
                    <div id="containerSubidos">                                               
                        <%                                             
                            sharedContentRS = sharedContent.GetLeastUplFolVideos(userid); 
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
                                Boolean restr = false;
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
                                            title = sharedContentRS.getString("TITLE");
                                            cat = sharedContentRS.getString("CATEGORY1");
                                            reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                            likes = sharedContentRS.getInt("LIKES");
                                            favs = sharedContentRS.getInt("FAVORITES");
                                            uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime());                                     
                                            restr = sharedContentRS.getBoolean("RESTRICTED");

                                            out.print("<div id=\"videoSubido\">");
                                            out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                            out.print("<div id=\"vid\">");
                                            out.print("<h3 id=\"titulo\" class=\"subidos\">" + title + "</h3>");                                    
                                            out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">"); 
                                            out.print("<table class=\"stats\">");
                                            out.print("<tr>");
                                            out.print("<td>"+cat+"</td>");
                                            out.print("<td><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");
                                            out.print("<td>"+uploaded+"</td>");
                                            out.print("<td><img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes+"</td>");
                                            out.print("</tr>");
                                            out.print("<tr>");                                    
                                            if(restr)
                                                out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            else
                                                out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                            out.print("<td><img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</td>");
                                            out.print("</tr>");
                                            out.print("</table>");
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
            <section class="subidos">                
                <h2 class="subidos" id="togall" onclick="ToggleAllCat()">
                    Categorias
                </h2>
                <ul id="valcat">    
                    <form id="ordenarcat">
                        <li>
                            <select name="ORDERCAT" id="ordencat" onchange="SubmitForm('ordenarcat')">
                                <option value="" disabled selected hidden>Ordenar Por</option>  
                                <option value="TA">Alfabeticamente</option>                                                                
                                <option value="RD">Mas Vistos</option>
                                <option value="RA">Menos Vistos</option>
                                <option value="LD">Mas "Me Gusta"</option>
                                <option value="LA">Menos "Me Gusta"</option>
                                <option value="FD">Mas Favoritos</option>
                                <option value="FA">Menos Favoritos</option> 
                                <option value="UD">Recientes</option>
                                <option value="UA">Antiguos</option> 
                            </select>
                        </li>                            
                    </form>                    
                </ul>     
                <%
                    Boolean showcat = false;
                    String ordercat = request.getParameter("ORDERCAT");                    
                    
                    Integer catnum = 0;
                    Integer subidoscat = 0;
                    categoriesRS = categories.GetCategoriesShow();                    
                    while(categoriesRS.next())
                    {               
                        catnum++;
                        String color = categoriesRS.getString("COLOR");
                        String name = categoriesRS.getString("CATNAME");
                        
                        out.println("<h2 class=\"subidoscat\" style=\"background-color:"+color+"80\" onclick=\"Toggleable('cat"+catnum+"')\" id=\"cat"+catnum+"name\">X Videos de Categoria</h2>");
                        out.println("<div class=\"subidos\" id=\"cat"+catnum+"\">");
                        out.println("<div id=\"containerSubidos\">");
                        
                        if(subidoscat > 0)
                            showcat = true;
                        subidoscat = 0;
                        
                        sharedContentRS = sharedContent.GetCategoryVideos(name, ordercat);
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
                            Boolean restr = false;
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
                                        subidoscat++;
                                        title = sharedContentRS.getString("TITLE");
                                        cat = sharedContentRS.getString("CATEGORY1");
                                        reprod = sharedContentRS.getInt("REPRODUCTIONS");
                                        likes = sharedContentRS.getInt("LIKES");
                                        favs = sharedContentRS.getInt("FAVORITES");
                                        uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime()); 
                                        restr = sharedContentRS.getBoolean("RESTRICTED");

                                        out.print("<div id=\"videoSubido\">");
                                        out.print("<a href=\"playVideo.jsp?ID="+vid+"\">");
                                        out.print("<div id=\"vid\">");
                                        out.print("<h3 id=\"titulo\" class=\"subidos\">" + title + "</h3>");                                    
                                        out.print("<img src=readVideo?ID="+vid+" width=\"240\" height=\"140\" class=\"subidos\">"); 
                                        out.print("<table class=\"stats\">");
                                        out.print("<tr>");
                                        out.print("<td>"+cat+"</td>");
                                        out.print("<td><img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+reprod+"</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<td>"+uploaded+"</td>");
                                        out.print("<td><img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+likes+"</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");                                    
                                        if(restr)
                                            out.print("<td><img src=\"css/img/Summon.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                        else
                                            out.print("<td><img src=\"css/img/Cursed.png\" width=\"24\" height=\"24\" class=\"icon\"></td>");
                                        out.print("<td><img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+favs+"</td>");
                                        out.print("</tr>");
                                        out.print("</table>");
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
                        out.println("</div>");
                        out.println("</div>"); 
                        out.println("<script>ShowSubidosCat(\"cat"+catnum+"name\", \""+name+"\", \""+subidoscat+"\");</script>");
                    }
                %>
            </section> 
            <script>ShowOrderCats("<%=showcat%>", "<%=ordercat%>");</script>
        </main>        
    </body>
</html>

<%
    categories.Disconnect();
    sharedContent.Disconnect();
    users.Disconnect();
%>


        
