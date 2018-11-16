<%-- 
    Document   : modVideo
    Created on : 20/05/2018, 02:17:06 PM
    Author     : Nelson
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DataBase.DBsharedContent"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <title>Modificar Video - La Hoguera</title>
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
            function CheckForm()
                {
                    var desc = document.getElementById('description');
                    desc.disabled = desc.value == "";
                    
                    var img = document.getElementById('imagefile');
                    img.disabled = img.value == "";
                }            
            function SetVideoInfo(title, description, category1, category2, category3, restricted)
                {
                    document.getElementById('imagelabel').textContent = "Imagen";
                    document.getElementById('imagefile').value = "";
                    
                    if(title !== "null")                                       
                        document.getElementById("titulo").value = title;   
                    if(description !== "null")                                       
                        document.getElementById("description").textContent = description;
                    if(category1 !== "null")    
                    {
                        document.getElementById("c1").value = category1; 
                        
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
                    if(category2 !== "null") 
                    {
                        document.getElementById("c2").value = category2;
                        
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
                    if(category3 !== "null")                                       
                        document.getElementById("c3").value = category3;
                    if(restricted === "false")                                       
                        document.getElementById("rest").checked = false;
                    else if(restricted === "true")                                       
                        document.getElementById("rest").checked = true;                                                                
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
            DBsharedContent sharedContent = new DBsharedContent();
            Integer videoid = Integer.parseInt(request.getParameter("ID"));
            String title = null;
            String description = null;
            String category1 = null;
            String category2 = null;
            String category3 = null;
            Boolean restricted = false;
            ResultSet res = sharedContent.GetVideoInfo(videoid);
            if(res.next())
            {                  
                title = res.getString("TITLE");  
                description = res.getString("DESCRIPTION"); 
                category1 = res.getString("CATEGORY1"); 
                category2 = res.getString("CATEGORY2"); 
                category3 = res.getString("CATEGORY3"); 
                restricted = res.getBoolean("RESTRICTED"); 
            }
            sharedContent.Disconnect();
        %>
        <main>                          
            <form onsubmit="CheckForm()" enctype="multipart/form-data" method="post" action="modVideo">
                <section class="modificarusuario">
                    <ul>
                        <li class="imagen">
                            <h2>
                                Modificar Video
                            </h2>
                        </li> 
                        <li style="display: none">
                            <input type=text value="<%=videoid%>" name="ID" required>
                        </li>                       
                        <li>
                            <input type=text placeholder="Titulo" name="TITLE" id="titulo" required>
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
                            <p>*Llene solo si quiere modificar*</p>
                            <input type="file" id="imagefile" name="IMAGE" accept=".jpg, .jpeg, .png" onchange="UpdateImage()">
                            <label class="filelabel" id="imagelabel" for="imagefile">
                            Imagen
                            </label>                            
                        </li>
                      
                        <li>
                            <p>*Llene solo si quiere modificar*</p>
                            <input type="file" id="videofile" name="VIDEO" accept=".mp4" onchange="UpdateVideo()">
                            <label class="filelabel" id="videolabel" for="videofile" required>
                            Video
                            </label>
                        </li>

                        <li>
                            <label>
                                <div id="checkbox">
                                <input type="checkbox" name="RESTRICTED" id="rest">
                                <span>Restringir Video ?</span>
                                </div>
                            </label>
                        </li>
                        <li>
                            <input type="submit" value="Modificar">
                        </li> 
                    </ul>
                </section>
            
                <section class="modificarusuario">
                    <ul>
                        <li class="imagen">
                            <img src="css/img/Tools.png" height="60">
                        </li>
                        <li>
                            <input type="button" value="Reiniciar Campos" onclick="SetVideoInfo('<%=title%>', '<%=description%>', '<%=category1%>', '<%=category2%>', '<%=category3%>', '<%=restricted%>')">
                        </li> 
                    </ul>
                </section>
            </form>
        </main>
        <script>SetVideoInfo("<%=title%>", "<%=description%>", "<%=category1%>", "<%=category2%>", "<%=category3%>", "<%=restricted%>");</script>
    </body>    
</html>
