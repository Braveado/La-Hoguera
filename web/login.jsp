<%-- 
    Document   : login
    Created on : 3/05/2018, 06:57:49 AM
    Author     : Nelson
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/sesion.css">
        <title>Iniciar Sesion - La Hoguera</title>
    </head>
    <%        
        request.getSession(false).removeAttribute("user");
        request.getSession(false).removeAttribute("userid");
    %>
    <body>
        <header>
            <a href="login.jsp"><img src="css/img/LaHoguera.png" alt="LOGO" height="90" width="500"></a>
        </header>
        <section>   
            <ul>
                <li class="imagen">
                    <img src="css/img/Summon.png" alt="LOGIN" height="60">
                </li>                 
                    <%
                        String CuserValue = "";
                        String CpassValue = "";
                        Cookie cookie = null;
                        Cookie[] cookies = null;
                        // Get an array of Cookies associated with this domain
                        cookies = request.getCookies();
                        if( cookies != null )
                        {
                            for (int i = 0; i < cookies.length; i++)
                            {
                                cookie = cookies[i];
                                if((cookie.getName()).compareTo("Cuser") == 0)
                                {
                                    CuserValue = cookie.getValue();
                                }
                                if((cookie.getName()).compareTo("Cpass") == 0)
                                {
                                    CpassValue = cookie.getValue();
                                }
                            }
                        }
                    %>
                <form method="post" action="login">
                    <li>
                        <input type="text" name="USERNAME" placeholder="Nombre de usuario" required <%if((CuserValue).compareTo("") != 0){out.print(" value ="+CuserValue);}%> >
                    </li>
                    <li>
                        <input type="password" name="PASSWORD" placeholder="Contraseña" required <%if((CpassValue).compareTo("") != 0){out.print(" value ="+CpassValue);}%> >
                    </li>
                    <li>   
                        <label>
                            <div id="checkbox">
                                <input type="checkbox" name="REMEMBER" <%if((CuserValue).compareTo("") != 0){out.print(" checked ");}%>>
                                <span>Recordar?</span>
                            </div>
                        </label>
                    </li>
                    <li>
                        <input type="submit" value="Iniciar Sesion">
                    </li>                
                    <li class="fb2">
                        <a href="login">                        
                            <h3>Entrar Anonimamente</h3>
                        </a>
                    </li>
                </form>
            </ul>              
        </section>    
        <section id="signup">   
            <ul>
                <li class="imagen">
                    <img src="css/img/Tools.png" height="60">
                </li>                
                <li class="fakebutton">
                    <a href="signup.html">
                        <h3>Creacion de Cuenta</h3>                        
                    </a>
                </li>                                
                <li class="fb2">
                    <a href="password.html">
                        <h3>Olvidaste tu Contraseña?</h3>
                    </a>
                </li>                
            </ul>             
        </section> 
    </body>    
</html>
