<%-- 
    Document   : adminSharedContent
    Created on : 20/05/2018, 01:58:11 AM
    Author     : Nelson
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBsharedContent"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Administrar Contenido Compartido - La Hoguera</title>
        <script src="js/searchValidation.js"></script>
        <script type="text/javascript">
            function SetMainCat()
                {                    
                    var c1 = document.getElementById("c1");
                    var c2 = document.getElementById("c2");
                    var c3 = document.getElementById("c3");
                    
                    var i;
                    for(i = 1; i < c1.options.length; i++)
                        {
                            c2.options[i].hidden = false;
                            c3.options[i].hidden = false;
                        }                    
                    
                    var c1opt = c1.selectedIndex;                    
                    
                    c2.selectedIndex = 0;
                    c3.selectedIndex = 0;
                    
                    c2.options[c1opt].hidden = true;
                    c3.options[c1opt].hidden = true;
                    
                    c2.style.display = "block";
                    c3.style.display = "none";
                }
            function SetExtCat()
                {                    
                    var c1 = document.getElementById("c1");
                    var c2 = document.getElementById("c2");
                    var c3 = document.getElementById("c3");
                    
                    var i;
                    for(i = 1; i < c1.options.length; i++)
                        {                            
                            c3.options[i].hidden = false;
                        }                    
                    
                    var c1opt = c1.selectedIndex;  
                    var c2opt = c2.selectedIndex;
                                        
                    c3.selectedIndex = 0;
                                        
                    c3.options[c1opt].hidden = true;
                    c3.options[c2opt].hidden = true;
                    
                    c3.style.display = "block";
                }
            function UpdateImage()
                {
                    document.getElementById('imagelabel').textContent = document.getElementById('imagefile').value.split('\\').pop().split('/').pop();
                }

            function UpdateVideo()
                {
                    document.getElementById('videolabel').textContent = document.getElementById('videofile').value.split('\\').pop().split('/').pop();
                }
            function CheckDescription()
                {
                    var desc = document.getElementById('description')
                    desc.disabled = desc.value == "";
                }
            function UndoChanges()
                {
                    document.getElementById('imagelabel').textContent = "Imagen";                    
                    
                    var c2 = document.getElementById("c2");
                    var c3 = document.getElementById("c3");
                    
                    var i;
                    for(i = 1; i < c1.options.length; i++)
                        {
                            c2.options[i].hidden = false;
                            c3.options[i].hidden = false;
                        }                      
                }
            function SubmitForm(id)
            {
                document.getElementById(id).submit();
            }
            function ShowOrder(show, order, subidos)
            {
                document.getElementById("numSubidos").textContent = subidos + " Videos Subidos";
                
                if(show === "false")
                    document.getElementById("valsubidos").style.display = "none";                                
                
                if(order !== "null")                
                    document.getElementById("orden").value = order;
            }   
        </script>
    </head>
    <% 
        String user = (String)session.getAttribute("user");     
        Integer userid = (Integer)session.getAttribute("userid"); 
    %>
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
                <h2 class="subidos" id="numSubidos">
                    Videos Subidos
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
                    </form>                    
                </ul> 
                <br>
                <%
                    String order = request.getParameter("ORDER");
                %> 
                <div class="subidos">
                    <div id="containerSubidos">
                        <%
                            Boolean showSubidos = false;
                            Integer subidos = 0;
                            
                            DBsharedContent sharedContent = new DBsharedContent();
                            ResultSet res = sharedContent.GetVideos(userid, order);
                            if(res.next())
                            {
                                Integer vid = null;  
                                String title = null;
                                String cat = null;
                                Integer reprod = null;
                                Integer likes = null; 
                                Integer favs = null;
                                java.sql.Date uploaded = null;
                                Boolean restr = false;
                                showSubidos = true; 
                                do
                                {                
                                    subidos ++;
                                    vid = res.getInt("ID");  
                                    title = res.getString("TITLE");
                                    cat = res.getString("CATEGORY1");
                                    reprod = res.getInt("REPRODUCTIONS");
                                    likes = res.getInt("LIKES");
                                    favs = res.getInt("FAVORITES");
                                    uploaded = new java.sql.Date(res.getDate("UPLOADED").getTime());
                                    restr = res.getBoolean("RESTRICTED");
                                    
                                    out.print("<div id=\"videoSubido\">");
                                    out.print("<div id=\"top\">");
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
                                    out.print("<div>");
                                    out.print("<form action=modVideo.jsp method=post>");
                                    out.print("<input type=\"text\" name=\"ID\" value=" + vid + " required class=\"subidos\">");
                                    out.print("<input type=\"submit\" value=\"Modificar\" class=\"subidos\"> ");
                                    out.print("</form>");
                                    out.print("<form action=delVideo method=post>");
                                    out.print("<input type=\"text\" name=\"ID\" value=" + vid + " required class=\"subidos\">");
                                    out.print("<input type=\"text\" name=\"TITLE\" value=" + title + " required class=\"subidos\">");
                                    out.print("<input type=\"submit\" value=\"Eliminar\" class=\"subidos\" id=\"last\"> ");
                                    out.print("</form>");
                                    out.print("</div>");
                                    out.print("</div>");                                    
                                }
                                while(res.next());
                            }
                            sharedContent.Disconnect();
                        %>
                        <!--
                        <div id="videoSubido">                            
                            <h3 id="titulo" class="subidos">Titulo de Video</h3>
                            <img src="css/img/DarkSoulsBackground2.jpg" width="240" height="140" class="subidos">
                            <form>
                                <input type="text" name="ID" value="0" required class="subidos">
                                <input type="submit" value="Modificar" class="subidos">   
                            </form>
                            <form>
                                <input type="text" name="ID" value="0" required class="subidos">
                                <input type="submit" value="Eliminar" class="subidos"> 
                            </form> 
                        </div>
                        -->
                    </div>
                </div>
            </section>            
            <script>ShowOrder("<%=showSubidos%>", "<%=order%>", "<%=subidos%>");</script>
            <form enctype="multipart/form-data" action="addVideo" method="post" onsubmit="CheckDescription()">
                <section class="modificarusuario">
                    <ul>
                        <li class="imagen">
                            <h2>
                                Agregar Video
                            </h2>
                        </li>
                        <li>
                            <input type=text placeholder="Titulo" name="TITLE" required>
                        </li>
                        <li>
                            <textarea placeholder="Descripcion" name="DESCRIPTION" id="description" rows="4"></textarea>
                        </li>                       
                        <li>
                            <select name="CATEGORY1" required id="c1" onchange="SetMainCat()">
                               <option value="" disabled selected hidden>Categoria Principal</option>
                                <option value="Dark Souls 1">Dark Souls 1</option>
                                <option value="Dark Souls 2">Dark Souls 2</option>
                                <option value="Dark Souls 3">Dark Souls 3</option>
                                <option value="PvP">PvP</option> 
                                <option value="PvE">PvE</option> 
                            </select>
                        </li>
                        <li>
                            <select name="CATEGORY2" id="c2" onchange="SetExtCat()">
                               <option value="" disabled selected hidden>Categoria Extra</option>
                                <option value="Dark Souls 1">Dark Souls 1</option>
                                <option value="Dark Souls 2">Dark Souls 2</option>
                                <option value="Dark Souls 3">Dark Souls 3</option>
                                <option value="PvP">PvP</option> 
                                <option value="PvE">PvE</option> 
                            </select>
                        </li>
                        <li>
                            <select name="CATEGORY3" id="c3">
                               <option value="" disabled selected hidden>Categoria Extra</option>
                                <option value="Dark Souls 1">Dark Souls 1</option>
                                <option value="Dark Souls 2">Dark Souls 2</option>
                                <option value="Dark Souls 3">Dark Souls 3</option>
                                <option value="PvP">PvP</option> 
                                <option value="PvE">PvE</option>  
                            </select>
                        </li>
                        <li>                            
                            <input type="file" id="imagefile" name="IMAGE" accept=".jpg, .jpeg, .png" onchange="UpdateImage()" required>
                            <label class="filelabelreq" id="imagelabel" for="imagefile">
                            Imagen
                            </label>                            
                        </li>
                       
                        <li>
                            <input type="file" id="videofile" name="VIDEO" accept=".mp4" onchange="UpdateVideo()" required>
                            <label class="filelabelreq" id="videolabel" for="videofile" required>
                            Video
                            </label>
                        </li>

                        <li>
                            <label>
                                <div id="checkbox">
                                <input type="checkbox" name="RESTRICTED">
                                <span>Restringir Video ?</span>
                                </div>
                            </label>
                        </li>
                        <li>
                            <input type="submit" value="Agregar">
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
