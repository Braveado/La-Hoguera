<%-- 
    Document   : profile
    Created on : 7/05/2018, 08:14:57 AM
    Author     : Nelson
--%>

<%@page import="DataBase.DBreports"%>
<%@page import="DataBase.DBfavorites"%>
<%@page import="DataBase.DBfollows"%>
<%@page import="java.util.Date"%>
<%@page import="DataBase.DBsharedContent"%>
<%@page import="DataBase.DBusers"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DBusers users = new DBusers();
    ResultSet usersRS = null;
    
    DBsharedContent sharedContent = new DBsharedContent();
    ResultSet sharedContentRS = null;   
    
    DBfavorites favorites = new DBfavorites();
    ResultSet favoritesRS = null;
    
    DBreports reports = new DBreports();
    ResultSet reportsRS = null;
    
    DBfollows follows = new DBfollows();
    ResultSet followsRS = null;        
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <script src="js/logAlert.js"></script>
        <script src="js/searchValidation.js"></script>
        <title>Perfil - La Hoguera</title>            
        <script type="text/javascript">
            function CheckAnonimo(user)
            {
                if(user === "Anonimo")
                {
                    alert("Los usuarios anonimos no pueden acceder a perfiles");
                    location='main.jsp';
                }
            }
            function CheckExistance(email)
            {
                if(email === "null")
                {
                    alert("No se indico un usuario existente");
                    location='main.jsp';
                }
            }
            function CheckSelf(user, name, following)
            {
                if(user === name)
                {                    
                    document.getElementById("modificar").style.display = "block"; 
                    document.getElementById("adminvideos").style.display = "block"; 
                }
                else
                {      
                    if(following === "true")
                        document.getElementById("dejarSeguir").style.display = "block";    
                    else if(following === "false")
                        document.getElementById("seguir").style.display = "block"; 
                }
            }     
            function CheckOptionals(birthday, genero, pais, ciudad)
            {               
                var disp = false;
                if(birthday !== "null")
                {                    
                    document.getElementById("nacimiento").style.display = "block"; 
                    disp = true;
                }
                if(genero !== "null")
                {
                    document.getElementById("genero").style.display = "block";
                    disp = true;
                }
                if(pais !== "null")
                {
                    document.getElementById("pais").style.display = "block";
                    disp = true;
                }
                if(ciudad !== "null")
                {
                    document.getElementById("ciudad").style.display = "block";
                    disp = true;
                }
                if(disp === true)
                    document.getElementById("datosOpcionales").style.display = "table";
            }            
            function SubmitForm(id)
            {
                document.getElementById(id).submit();
            }
            function ShowOrder(show, order, subidos)
            {
                var term = " Videos Subidos";
                if(subidos === "1")
                    term = " Video Subido";
                document.getElementById("numSubidos").textContent = subidos + term;
                
                if(show === "false")
                    document.getElementById("valsubidos").style.display = "none";                                
                
                if(order !== "null")                
                    document.getElementById("orden").value = order;
            }   
            function ShowOrderFavs(show, order, favoritos)
            {
                var term = " Videos Favoritos";
                if(favoritos === "1")
                    term = " Video Favorito";
                document.getElementById("numFavoritos").textContent = favoritos + term;
                
                if(show === "false")
                    document.getElementById("valfavoritos").style.display = "none";                                
                
                if(order !== "null")                
                    document.getElementById("ordenFavs").value = order;
            }   
            function SetFollowings(siguiendo)
            {
                var term = " Usuarios";
                if(siguiendo === "1")
                    term = " Usuario";
                document.getElementById("numSiguiendo").textContent = "Siguiendo " + siguiendo + term;
            } 
            function SetFollowers(seguidores)
            {
                var term = " Usuarios";
                if(seguidores === "1")
                    term = " Usuario";
                document.getElementById("numSeguidores").textContent = "Seguido Por " + seguidores + term;
            } 
            function BanReason(reason)
            {
                alert(reason);
            }
        </script>
    </head>      
    <% 
        String user = (String)session.getAttribute("user");
        Integer userid = (Integer)session.getAttribute("userid");                    
        String name = request.getParameter("USERNAME"); 
        Integer nameid = 0;
                
        usersRS = users.ValidateExistance(name, ""); 
        if(usersRS.next())
        {
            nameid = usersRS.getInt("ID");
        }                
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
        <script>CheckAnonimo("<%=user%>");</script>        
        <%                                
            String email = null;             
            String birthdate = null;
            String gender = null;
            String country = null;
            String city = null;
            
            usersRS = users.GetEmail(name); 
            if(usersRS.next())
            {
                email = usersRS.getString("EMAIL");
                usersRS = users.GetOptionals(name);
                if(usersRS.next())
                {
                    birthdate = usersRS.getString("BIRTHDATE");
                    gender = usersRS.getString("GENDER");
                    country = usersRS.getString("COUNTRY");
                    city = usersRS.getString("CITY");
                }
            }            
        %>
        <script>CheckExistance("<%=email%>");</script>
        <main>
            <section class="portada">
                <img src="readUserImages?IMAGE=COVER&USERNAME=<%=name%>" alt="Portada" class="portada" onerror="this.src = 'css/img/Cursed.png'">
            </section>
            <section class="perfil">
                <table>
                    <tr>
                        <td align="left" id="avatarbig">
                            <img src="readUserImages?IMAGE=PROFILE&USERNAME=<%=name%>" alt="Profile" width="100" height="100" id="avatar" onerror="this.src = 'css/img/Cursed.png'">
                        </td>    
                        <td align="left" class="perfilinfo">
                            <h2><%=name%></h2>
                        </td>
                        <td align="right" class="perfilinfo">
                            <h2><%=email%></h2>
                        </td>
                    </tr>
                </table>               
            </section>            
            <section class="opcionales">
                <table id="datosOpcionales">
                    <tr>
                        <td>
                            <h3 id="nacimiento"><%=birthdate%></h3>
                        </td>
                        <td>
                            <h3 id="genero"><%=gender%></h3>
                        </td>
                        <td>
                            <h3 id="pais"><%=country%></h3>
                        </td>
                        <td>
                            <h3 id="ciudad"><%=city%></h3>
                        </td>
                    </tr>
                </table>
                <ul>
                    <li class="imagen">
                        <img src="css/img/Tools.png" height="60">
                    </li>  
                    <li id="adminvideos">
                        <a href="adminSharedContent.jsp">
                            <input type="submit" value="Administrar Contenido Compartido">
                        </a>
                    </li> 
                    <%
                        Boolean following = false;
                        
                        followsRS = follows.CheckFollow(nameid, userid);
                        if(followsRS.next())
                            following = true;                        
                    %>
                    <li>
                        <a href="profileModify.jsp">
                            <input type="submit" value="Modificar" class="subbutton" id="modificar">
                        </a>
                        <form method="post" action="followUser">
                            <input type="text" name="USERNAME" class="subidos" value="<%=name%>">
                            <input type="submit" value="Seguir" class="subbutton" id="seguir">
                        </form>                            
                        <form method="post" action="unfollowUser">
                            <input type="text" name="USERNAME" class="subidos" value="<%=name%>">
                            <input type="submit" value="Dejar de Seguir" class="subbutton" id="dejarSeguir">
                        </form> 
                    </li>                                       
                </ul>               
            </section>  
            <script>CheckOptionals("<%=birthdate%>", "<%=gender%>", "<%=country%>", "<%=city%>");</script>
            <section class="subidos">
                <h2 class="subidos" id="numSubidos">
                    X Videos Subidos
                </h2>
                <ul id="valsubidos">    
                    <form id="ordenar">
                        <li>
                            <select name="ORDER" id="orden" onchange="SubmitForm('ordenar')">
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
                        <li>
                            <input type="text" name="USERNAME" required value="<%=name%>" class="subidos">
                        </li> 
                    </form>                    
                </ul>     
                <%
                    String order = request.getParameter("ORDER");                    
                %> 
                <div class="subidos">
                    <div id="containerSubidos">
                        <%
                            Boolean showSubidos = false;
                            Integer subidos = 0;
                                                           
                            reportsRS = reports.CheckBannedUser(nameid);  
                            if(!reportsRS.next())
                            {
                                sharedContentRS = sharedContent.GetVideos(nameid, order); 
                                if(sharedContentRS.next())
                                {
                                    Integer vid = null;  
                                    String title = null;
                                    String cat = null;
                                    Integer reprod = null;
                                    Integer likes = null; 
                                    Integer favs = null;
                                    java.sql.Date uploaded = null;
                                    Boolean restr = false;                                
                                    String reason = null;
                                    showSubidos = true;                                
                                    do
                                    {     
                                        vid = sharedContentRS.getInt("ID");
                                        reportsRS = reports.CheckBannedVideo(vid);

                                        if(user.compareTo(name) == 0)
                                        {                                        
                                            subidos ++;                                          
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

                                            if(reportsRS.next())
                                                reason = reportsRS.getString("REASON");

                                            if(reason != null)
                                            {
                                                out.print("<input type=\"submit\" value=\"Bloqueado\" class=\"video\" id=\"baninfo\" style = visibility:visible onclick=\"BanReason('"+reason+"')\">");
                                                reason = null;
                                            }
                                            out.print("</div>");                                        
                                        }
                                        else
                                        {
                                            if(!reportsRS.next())
                                            {
                                                subidos ++;
                                                vid = sharedContentRS.getInt("ID");  
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
                                                out.print("</div>"); 
                                            }
                                        }
                                    } 
                                    while(sharedContentRS.next());
                                } 
                            }
                            else
                            {
                                out.print("<div id=\"cantrep\">");
                                out.print("<img src=\"css/img/Invasion.png\" height=\"60\">");
                                
                                String expires = reportsRS.getString("EXPIRES");
                                String until = "Indefinidamente";
                                
                                if(expires != null)                                                                    
                                    until = "Hasta "+expires;
                                
                                out.print("<div>Usuario Bloqueado "+until+"</div>");                                        
                                out.print("</div>");
                            }
                        %>
<!--                        
                        <a href="perfil2.html">
                            <div id="videoSubido">                            
                                <h3 id="titulo" class="subidos">Titulo de Video</h3>
                                <img src="css/img/ImgVideo2.jpg" width="240" height="140" class="subidos">  
                            </div>   
                        </a>
-->
                    </div>
                </div>
            </section>  
            <script>ShowOrder("<%=showSubidos%>", "<%=order%>", "<%=subidos%>");</script>
            <section class="subidos">
                <h2 class="subidos" id="numFavoritos">
                    X Videos Subidos
                </h2>
                <ul id="valfavoritos">    
                    <form id="ordenarFavs">
                        <li>
                            <select name="ORDERFAVS" id="ordenFavs" onchange="SubmitForm('ordenarFavs')">
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
                        <li>
                            <input type="text" name="USERNAME" required value="<%=name%>" class="subidos">
                        </li> 
                    </form>                    
                </ul>     
                <%
                    String orderFavs = request.getParameter("ORDERFAVS");                    
                %> 
                <div class="subidos">
                    <div id="containerSubidos">
                        <%
                            Boolean showFavoritos = false;
                            Integer favoritos = 0;
                            
                            favoritesRS = favorites.GetFavorites(nameid, orderFavs);                                                                                    
                            if(favoritesRS.next())
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
                                showFavoritos = true;                                       
                                do
                                {         
                                    
                                    vid = favoritesRS.getInt("ID");                                      
                                    reportsRS = reports.CheckBannedVideo(vid);
                                    if(!reportsRS.next())
                                    {                                        
                                        profid = favoritesRS.getInt("USERID");
                                        reportsRS = reports.CheckBannedUser(profid);
                                        if(!reportsRS.next())
                                        {
                                            favoritos ++;
                                            title = favoritesRS.getString("TITLE");
                                            cat = favoritesRS.getString("CATEGORY1");
                                            reprod = favoritesRS.getInt("REPRODUCTIONS");
                                            likes = favoritesRS.getInt("LIKES");
                                            favs = favoritesRS.getInt("FAVORITES");
                                            uploaded = new java.sql.Date(favoritesRS.getDate("UPLOADED").getTime()); 
                                            restr = favoritesRS.getBoolean("RESTRICTED");

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
                                while(favoritesRS.next());
                            }                                                            
                        %>
<!--                        
                        <a href="perfil2.html">
                            <div id="videoSubido">                            
                                <h3 id="titulo" class="subidos">Titulo de Video</h3>
                                <img src="css/img/ImgVideo2.jpg" width="240" height="140" class="subidos">  
                            </div>   
                        </a>
-->
                    </div>
                </div>
            </section>
            <script>ShowOrderFavs("<%=showFavoritos%>", "<%=orderFavs%>", "<%=favoritos%>");</script>
            <section class="subidos">
                <h2 class="subidos" id="numSiguiendo">Siguiendo X usuarios</h2>
                <div class="subidos">
                    <div id="containerSubidos">
                        <%
                            Integer siguiendo = 0;                                                        
                            followsRS = follows.CheckFollowing(nameid); 
                            if(followsRS.next())
                            {                                
                                Integer followingId = null; 
                                String followingName = null;                                                                                             
                                do
                                {         
                                    siguiendo ++;
                                    followingId = followsRS.getInt("FOLLOWING");                                                                
                                    usersRS = users.GetName(followingId);
                                    if(usersRS.next())
                                    {
                                        followingName = usersRS.getString("USERNAME");

                                        out.print("<div id=\"usuarioSiguiendo\">");
                                        out.print("<a href=\"profile.jsp?USERNAME="+followingName+"\">");                                                                        
                                        out.print("<img src=readUserImages?IMAGE=PROFILE&USERNAME="+followingName+" alt=\"Profile\" width=\"100\" height=\"100\" class=\"subidos\" id=\"usrpicbig\" onerror=\"this.src = 'css/img/Cursed.png'\">");                                         
                                        out.print("<h3 class=\"siguiendo\">"+followingName+"</h3>");    
                                        out.print("</a>");
                                        out.print("</div>");
                                    }

                                } 
                                while(followsRS.next());                                
                            }                                                            
                        %>
<!--                        
                        <div id="usuarioSiguiendo">
                            <a href="profile.jsp">
                                <h3 class="siguiendo">Nombre de Usuario</h3>
                                <img src="css/img/Cursed.png" width="100" height="100" class="subidos">                            
                                
                            </a>
                        </div>
-->                        
                    </div>
                </div>
            </section>
            <script>SetFollowings("<%=siguiendo%>")</script>
            <section class="subidos">
                <h2 class="subidos" id="numSeguidores">Seguido Por X Usuarios</h2>
                <div class="subidos">
                    <div id="containerSubidos">
                        <%
                            Integer seguidores = 0;                                                        
                            followsRS = follows.CheckFollowers(nameid); 
                            if(followsRS.next())
                            {                                
                                Integer followerId = null; 
                                String followerName = null;                                                                                             
                                do
                                {         
                                    seguidores ++;
                                    followerId = followsRS.getInt("FOLLOWER");                                                                
                                    usersRS = users.GetName(followerId);
                                    if(usersRS.next())
                                    {
                                        followerName = usersRS.getString("USERNAME");

                                        out.print("<div id=\"usuarioSiguiendo\">");
                                        out.print("<a href=\"profile.jsp?USERNAME="+followerName+"\">");                                                                         
                                        out.print("<img src=readUserImages?IMAGE=PROFILE&USERNAME="+followerName+" alt=\"Profile\" width=\"100\" height=\"100\" class=\"subidos\" id=\"usrpicbig\" onerror=\"this.src = 'css/img/Cursed.png'\">");                                                                                                            
                                        out.print("<h3 class=\"siguiendo\">"+followerName+"</h3>");   
                                        out.print("</a>");
                                        out.print("</div>");
                                    }

                                } 
                                while(followsRS.next());                                
                            }                                                            
                        %>
<!--                        
                        <div id="usuarioSiguiendo">
                            <a href="profile.jsp">
                                <h3 class="siguiendo">Nombre de Usuario</h3>
                                <img src="css/img/Cursed.png" width="100" height="100" class="subidos">                            
                                
                            </a>
                        </div>
-->                        
                    </div>
                </div>
            </section>
            <script>SetFollowers("<%=seguidores%>")</script>
        </main>
    </body>
    <script>CheckSelf("<%=user%>", "<%=name%>", "<%=following%>");</script>
</html>

<%
    users.Disconnect();
    sharedContent.Disconnect();
    follows.Disconnect();
    reports.Disconnect();
%>