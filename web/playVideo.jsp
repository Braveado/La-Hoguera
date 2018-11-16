<%-- 
    Document   : playVideo
    Created on : 25/05/2018, 12:15:40 PM
    Author     : Nelson
--%>

<%@page import="DataBase.DBcomments"%>
<%@page import="DataBase.DBreports"%>
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
    
    DBfavorites favorites = new DBfavorites();
    ResultSet favoritesRS = null;
    
    DBreports reports = new DBreports();
    ResultSet reportsRS = null;
    
    DBcomments comments = new DBcomments();
    ResultSet commentsRS;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Reproducir Video - La Hoguera</title>
        <script src="js/searchValidation.js"></script> 
        <script>
            function CheckAnonimo(user, restricted)
            {
                if(user === "Anonimo" && restricted === "true")
                {
                    alert("Los usuarios anonimos no pueden acceder a este video");
                    location='main.jsp';
                }
            }
            var played = false;
            function PlayVideo(vid, user)
            {
                if(played == false)
                {
                    played = true;                    
                    
                    document.getElementById("reportbutton").style.visibility = "visible";
                    document.getElementById("likebutton").style.visibility = "visible";
                    document.getElementById("favbutton").style.visibility = "visible";
                    document.getElementById("comentbutton").style.visibility = "visible";
                    if(user === "Anonimo")
                        document.getElementById("acoment").style.display = "block";
                    
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() 
                    {
                        if (this.readyState == 4 && this.status == 200) 
                        {
                            document.getElementById("reprods").innerHTML = this.responseText;
                        }
                    };
                    xhttp.open("GET", "VideoCounts?VID="+vid+"&ACTION=IR&USERID=0", true);
                    xhttp.send();
                }
            }      
            var favorite = false;
            function ToggleFav(vid, usrid)
            {
                if(usrid != 0)
                {
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() 
                    {
                        if (this.readyState == 4 && this.status == 200) 
                        {
                            document.getElementById("favs").innerHTML = this.responseText;
                        }
                    };
                    var act = "";
                    if(!favorite)
                        act = "AF";
                    if(favorite)
                        act = "RF";
                    xhttp.open("GET", "VideoCounts?VID="+vid+"&ACTION="+act+"&USERID="+usrid, true);
                    xhttp.send();
                    if(!favorite)
                    {
                        favorite = true;
                        document.getElementById("favbutton").value = "Quitar Favorito";
                    }
                    else if(favorite)
                    {
                        favorite = false;
                        document.getElementById("favbutton").value = "Agregar Favorito";
                    }
                }
                else
                {
                    alert("Los usuarios anonimos no pueden agregar favoritos");
                }
            }
            var like = false;
            function ToggleLike(vid, usrid)
            {
                if(usrid != 0)
                {
                    xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() 
                    {
                        if (this.readyState == 4 && this.status == 200) 
                        {
                            document.getElementById("likes").innerHTML = this.responseText;
                        }
                    };
                    var act = "";
                    if(!like)
                        act = "AL";
                    if(like)
                        act = "RL";
                    xhttp.open("GET", "VideoCounts?VID="+vid+"&ACTION="+act+"&USERID="+usrid, true);
                    xhttp.send();
                    if(!like)
                    {
                        like = true;
                        document.getElementById("likebutton").value = "Quitar Me Gusta";
                    }
                    else if(like)
                    {
                        like = false;
                        document.getElementById("likebutton").value = "Dar Me Gusta";
                    }
                }
                else
                {
                    alert("Los usuarios anonimos no pueden dar me gusta");
                }
            }
            function ValidateReport(user, vid)
            {
                if(user !== "Anonimo")
                    location="reportVideo.jsp?ID="+vid;
                else
                    alert("Los usuarios anonimos no pueden reportar videos");
            }
            function SendComment(vid, usrid)
            {                           
                var aname = document.getElementById('aname');
                var amail = document.getElementById('amail');
                if(usrid === '0' && (aname.value === "" || amail.value === ""))
                {                
                    alert("Los usuarios anonimos deben registrar un nombre y correo para poder comentar");
                }
                else
                {
                    var comentarea = document.getElementById('mycomment');
                    var comment = comentarea.value;

                    if(comment !== "")
                    {
                        xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() 
                        {
                            if (this.readyState == 4 && this.status == 200) 
                            {
                                document.getElementById("log").innerHTML = this.responseText;
                            }
                        };                             
                        xhttp.open("GET", "SendComment?VID="+vid+"&USERID="+usrid+"&ANAME="+aname.value+"&AMAIL="+amail.value+"&COMMENT="+comment, true);
                        xhttp.send();  

                        comentarea.value = "";
                    }
                    else
                        alert("No hay un comentario escrito");
                }
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
            sharedContentRS = sharedContent.GetVideoPlay(vid); 
            sharedContentRS.next();

            Integer profid = sharedContentRS.getInt("USERID");
            String title = sharedContentRS.getString("TITLE");
            String desc = sharedContentRS.getString("DESCRIPTION");
            String cat1 = sharedContentRS.getString("CATEGORY1");
            String cat2 = sharedContentRS.getString("CATEGORY2");
            String cat3 = sharedContentRS.getString("CATEGORY3");
            Integer reprod = sharedContentRS.getInt("REPRODUCTIONS");
            Integer likes = sharedContentRS.getInt("LIKES");
            Integer favs = sharedContentRS.getInt("FAVORITES");
            java.sql.Date uploaded = new java.sql.Date(sharedContentRS.getDate("UPLOADED").getTime());  
            Boolean restr = sharedContentRS.getBoolean("RESTRICTED");   
            String temp = sharedContentRS.getString("DIR");            
            String dir = "/PF_PAPW/VIDEOS/"+temp;
            
            favoritesRS = favorites.CheckFavorite(vid, userid);
            Boolean fav = favoritesRS.next();    
            
            favoritesRS = favorites.CheckLike(vid, userid);
            Boolean like = favoritesRS.next(); 

            usersRS = users.GetName(profid);
            usersRS.next();
            String profname = usersRS.getString("USERNAME");  
            
            reportsRS = reports.CountReports(vid);
            reportsRS.next();
            Integer cantrep = reportsRS.getInt("COUNTEDREPORTS");
            
            String reason = null;
            reportsRS = reports.CheckBannedVideo(vid);
            if(reportsRS.next())
                reason = reportsRS.getString("REASON");
        %>
        <script>CheckAnonimo("<%=user%>", "<%=restr%>");</script>
        <main>            
            <section class="video">  
                <h2 class="video"><%=title%></h2>                
                <video src=<%=dir%> controls  onplay="PlayVideo('<%=vid%>', '<%=user%>')"></video>
                <table class="video">
                    <tr>
                        <td align="center" rowspan="2" class="video">
                            <a href="profile.jsp?USERNAME=<%=profname%>">
                                <div id="perfilvideo">
                                    <img src=readUserImages?IMAGE=PROFILE&USERNAME=<%=profname%> width="50" height="50" class="icon" onerror="this.src='css/img/Cursed.png'">   
                                    <%=profname%>
                                </div>
                            </a>
                        </td>                    
                        <td aligtn="center" class="video" rowspan="3">
                            <%
                                out.print(cat1);
                                if(cat2 != null)
                                    out.print("<br><br>"+cat2);
                                if(cat3 != null)
                                    out.print("<br><br>"+cat3);       
                            %>                   
                        </td>
                        <td align="center" class="video" id="reprods">                            
                            <img src="css/img/Binoculars.png" width="24" height="24" class="icon"> <%=reprod%>
                        </td>
                        <td align="center" class="video">
                            <input type="submit" class="video" id="reportbutton" value="Reportar" onclick="ValidateReport('<%=user%>', '<%=vid%>')">
                        </td>
                    </tr>
                    <tr>                                            
                        <td align="center" class="video" id="likes">
                            <img src="css/img/PrismStone.png" width="24" height="24" class="icon"> <%=likes%>
                        </td>
                        <td align="center" class="video">
                            <input type="submit" class="video" id="likebutton" value="<%=like?"Quitar Me Gusta":"Dar Me Gusta"%>" onclick="ToggleLike('<%=vid%>', '<%=userid%>')">
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="video">
                            <%=uploaded%>
                        </td>                        
                        <td align="center" class="video" id="favs">
                            <img src="css/img/SunlightMedal.png" width="24" height="24" class="icon"> <%=favs%>
                        </td>
                        <td align="center" class="video">
                            <input type="submit" class="video" id="favbutton" value="<%=fav?"Quitar Favorito":"Agregar Favorito"%>" onclick="ToggleFav('<%=vid%>', '<%=userid%>')">                                                  
                        </td>
                        <script>favorite = <%=fav%></script>                        
                    </tr>                
                </table>  
                <%
                    if(desc != null)
                    {
                        out.print("<div id=\"descripcion\">");
                        out.print(desc);
                        out.print("</div>");
                    }
                %> 
                <%
                    if(reason != null)
                    {
                        out.print("<div id=\"cantrep\">");
                        out.print("<img src=\"css/img/Invasion.png\" height=\"60\">");
                        out.print("<div>"+reason+"</div>");
                        out.print("</div>");
                    }
                    else if(cantrep > 0)
                    {
                        out.print("<div id=\"cantrep\">");
                        out.print("<img src=\"css/img/Report.png\" height=\"60\">");
                        out.print("<div>"+cantrep+"</div>");
                        out.print("</div>"); 
                    }
                %>  
            </section>  
            <section class="modificarusuario" id="acoment">
                <ul>
                    <li class="imagen">
                        <img src="css/img/Tools.png" height="60">
                    </li>
                    <li>
                        <input type="text" id="aname" placeholder="Nombre para comentar" class="subtext">                    
                    </li>
                    <li>
                        <input type="text" id="amail" placeholder="Correo para comentar" class="subtext">
                    </li>
                </ul>
            </section>
            <section class="video">
                <h2 id="imgcoments">
                    <img src="css/img/Message.png" height="60">                   
                </h2>
                <div class="comentario">
                    <table class="coment">
                        <tr>
                            <td class="comentusr" rowspan="2">
                                <%
                                    if(user != "Anonimo")
                                    {
                                        out.print("<a href=profile.jsp?USERNAME="+user+">");
                                        out.print("<div id=\"perfilvideo\">");
                                    }
                                %>
                                    
                                        <img src=readUserImages?IMAGE=PROFILE&USERNAME=<%=user%> width="50" height="50" class="icon" onerror="this.src='css/img/Cursed.png'">   
                                        <%=user%>
                                <%
                                    if(user != "Anonimo")
                                    {
                                        out.print("</div>");
                                        out.print("</a>");
                                    }
                                %>
                            </td>
                            <td class="comentario" rowspan="3">
                                <textarea placeholder="Escribe un comentario" id="mycomment"></textarea>
                            </td>
                        </tr>
                        <tr></tr>
                        <tr>
                            <td class="comentusr">
                                <input type="submit" class="video" id="comentbutton" value="Comentar" onclick="SendComment('<%=vid%>', '<%=userid%>')">
                            </td>
                        </tr>
                    </table>
                </div>                            
                <div class="comentario" id="log">
                    <%
                        commentsRS = comments.GetVideoComments(vid);
                        while(commentsRS.next())
                        {           
                            profid = commentsRS.getInt("USERID");
                            profname = commentsRS.getString("aname");
                            String email = commentsRS.getString("amail");
                            usersRS = users.GetName(profid);
                            if(usersRS.next())
                                profname = usersRS.getString("USERNAME");

                            out.print("<table class=\"coment\">");
                            out.print("<tr>");
                            out.print("<td class=\"comentusr\" rowspan=\"2\">");
                            if(profid != 0) 
                            {
                                out.print("<a href=\"profile.jsp?USERNAME="+profname+"\">");
                                out.print("<div id=\"perfilvideo\">");
                            }
                            else
                                out.print("<div id=\"anonimovideo\">");
                            out.print("<img src=readUserImages?IMAGE=PROFILE&USERNAME="+profname+" width=\"50\" height=\"50\" class=\"icon\" onerror=\"this.src='css/img/Cursed.png'\">");
                            out.print(profname);
                            out.print("</div>");
                            if(profid != 0) 
                                out.print("</a>");
                            out.print("</td>");
                            out.print("<td class=\"comentario\" rowspan=\"3\">");
                            out.print(commentsRS.getString("COMMENT"));
                            out.print("</td>");
                            out.print("</tr>");
                            out.print("<tr></tr>");
                            out.print("<tr>");

                            String [] ds = (commentsRS.getString("WRITTEN")).split("[.]");
                            String timeStamp = ds[0]+"-"+ds[1]+"-"+ds[2]+" / "+ds[3]+":"+ds[4]+":"+ds[5];

                            if(profid == 0)                   
                                out.print("<td class=\"comentusr\">"+email+"<br>"+timeStamp+"</td>");                    
                            else
                                out.print("<td class=\"comentusr\">"+timeStamp+"</td>");

                            out.print("</tr>");
                            out.print("</table>"); 
                        }
                    %>
                </div>
            </section>                                                                       
        </main>                        
    </body>    
</html>

<%
    sharedContent.Disconnect();
    users.Disconnect();
    favorites.Disconnect();
    reports.Disconnect();
    comments.Disconnect();
%>