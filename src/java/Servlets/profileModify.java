/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBusers;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Nelson
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "profileModify", urlPatterns = {"/profileModify"})
public class profileModify extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        DBusers users = new DBusers();                      
        try 
        {            
            PrintWriter out = response.getWriter();                                     
            String user = (String)request.getSession(false).getAttribute("user");
            
            out.print("<!DOCTYPE html>");
            out.print("<html>");
            out.print("<head>");
            out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">");
            out.print("<script src=\"js/logAlert.js\"></script>"); 
            out.print("<script src=\"js/searchValidation.js\"></script>");
            out.print("<title>Modificar Perfil - La Hoguera</title>");
            out.print("</head>");
            out.print("<body>");
            out.print("<section class=\"principal\">");
            out.print("<a href=\"main.jsp\">");
            out.print("<img src=\"css/img/LaHoguera.png\" height=\"90\" width=\"500\">");
            out.print("</a>");
            out.print("</section>");
            out.print("<script>CheckSession(\""+user+"\");</script>");
            out.print("<header class=\"cabecera\">");
            out.print("<table>");
            out.print("<tr>");
            out.print("<td id=\"perfillink\" class=\"border\"> ");
            out.print("<a href=\"login.jsp\">");
            out.print("<table>");
            out.print("<tr id=\"perfil\">");
            out.print("<td align=\"left\" >");
            out.print("<img src=\"css/img/Exit.png\" alt=\"SALIR\" width=\"50\" height=\"50\" id=\"avatar\">");
            out.print("</td>");
            out.print("<td align=\"left\">");
            out.print("<h3>Salir de Sesion</h3> ");
            out.print("</td>");
            out.print("</tr>");
            out.print("</table>");
            out.print("</a> ");
            out.print("</td>");                                       
            out.print("<form action=\"search.jsp\" onsubmit=\"return ValidateDates(this)\">");
            out.print("<td id=\"buscar\">");
            out.print("<select name=\"FILTER\" class=\"buscacion\" required onchange=\"ChangeQuest()\" id=\"filtro\">");
            out.print("<option value=\"Titulo\">Titulo</option>");
            out.print("<option value=\"Usuario\">Usuario</option>");
            out.print("<option value=\"Categoria\">Categoria</option>");
            out.print("<option value=\"Rango de Fechas\">Rango de Fechas</option>");
            out.print("</select>");
            out.print("<input type=\"text\" name=\"QUEST\" placeholder=\"Busqueda\" maxlengh=\"50\" required id=\"busqueda\">");
            out.print("<select name=\"QUESTC\" id=\"busquedacat\" required disabled>");
            out.print("<option value=\"\" disabled selected hidden>Busqueda</option>");
            out.print("<option value=\"Dark Souls 1\">Dark Souls 1</option>");
            out.print("<option value=\"Dark Souls 2\">Dark Souls 2</option>");
            out.print("<option value=\"Dark Souls 3\">Dark Souls 3</option>");
            out.print("<option value=\"PvP\">PvP</option>");
            out.print("<option value=\"PvE\">PvE</option> ");
            out.print("</select>");
            out.print("<input type=\"date\" name=\"QUESTF1\" id=\"busquedafeini\" required disabled>");
            out.print("<input type=\"date\" name=\"QUESTF2\" id=\"busquedafefin\" required disabled>");
            out.print("<input type=\"submit\" value=\"Buscar\" class=\"buscacion\">");
            out.print("</td>");
            out.print("</form>");
            
            String met = request.getParameter("METHOD"); 
            if(met != null && (met.equals("new") || met.equals("all")))
            {
                String name = request.getParameter("USERNAME");
                String email = request.getParameter("EMAIL");    
                String password = request.getParameter("PASSWORD");
                String question = request.getParameter("QUESTION");
                String answer = request.getParameter("ANSWER"); 
                InputStream profileStream = null; // input stream of the upload file
                Part profilePart = request.getPart("PROFILE");
                if (profilePart != null)
                {
                    profileStream = profilePart.getInputStream();
                }                
                InputStream coverStream = null; // input stream of the upload file
                Part coverPart = request.getPart("COVER");
                if (coverPart != null)
                {
                    coverStream = coverPart.getInputStream();
                }
                String birthdate = request.getParameter("BIRTHDATE");
                String gender = request.getParameter("GENDER");
                String country = request.getParameter("COUNTRY");
                String city = request.getParameter("CITY");

                ResultSet res;
                res = users.ValidateExistance(name, email);
                if(!res.next()) 
                {
                    if(users.ModifyUser(user, met, name, email, password, question, answer, profileStream, coverStream, birthdate, gender, country, city))
                    {                                                      
                        if(name!=null)
                        {
                            HttpSession session = request.getSession(false);
                            session.setAttribute("user", name);
                            user = (String)session.getAttribute("user");
                        }

                        out.print("<td id=\"perfillink\" class=\"border\">");
                        out.print("<a href=\"profile.jsp?USERNAME="+user+"\">");
                        out.print("<table>");
                        out.print("<tr id=\"perfil\">");
                        out.print("<td align=\"right\">");
                        out.print("<h3>"+user+"</h3>");
                        out.print("</td>");
                        out.print("<td align=\"right\" >");
                        out.print("<img src=\"readUserImages?IMAGE=PROFILE&USERNAME="+user+"\" alt=\"Profile\" width=\"50\" height=\"50\" id=\"avatar\" onerror=\"this.src = 'css/img/Cursed.png'\">");
                        out.print("</td>");
                        out.print("</tr>");
                        out.print("</table>");
                        out.print("</a>");
                        out.print("</td>");
                        out.print("</tr>");
                        out.print("</table>");                      
                        out.print("</header>");
                        out.print("<main>");

                        out.print("<section class=\"modificarusuario\">");  
                        out.print("<ul>");
                        out.print("<li class=\"imagen\">");
                        out.print("<img src=\"css/img/Summon.png\" height=\"60\">");
                        out.print("</li>");
                        out.print("<li id=\"pregunta\">");
                        out.print("<h3>" + user +"</h3>");
                        out.print("</li>");
                        out.print("<li id=\"pregunta\">");
                        out.print("<h3>Perfil modificado con exito.</h3>");
                        out.print("</li>");
                        out.print("</ul>");
                        out.print("</section>");

                        out.print("</main>");
                        out.print("</body> ");
                        out.print("</html>");                    
                    }   
                    else
                    {
                        out.print("<td id=\"perfillink\" class=\"border\">");
                        out.print("<a href=\"profile.jsp?USERNAME="+user+"\">");
                        out.print("<table>");
                        out.print("<tr id=\"perfil\">");
                        out.print("<td align=\"right\">");
                        out.print("<h3>"+user+"</h3>");
                        out.print("</td>");
                        out.print("<td align=\"right\" >");
                        out.print("<img src=\"readUserImages?IMAGE=PROFILE&USERNAME="+user+"\" alt=\"Profile\" width=\"50\" height=\"50\" id=\"avatar\" onerror=\"this.src = 'css/img/Cursed.png'\">");
                        out.print("</td>");
                        out.print("</tr>");
                        out.print("</table>");
                        out.print("</a>");
                        out.print("</td>");
                        out.print("</tr>");
                        out.print("</table>");                      
                        out.print("</header>");
                        out.print("<main>");

                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Error al modificar el usuario');");
                        out.println("location='profileModify.jsp';");
                        out.println("</script>");

                        out.print("</main>");
                        out.print("</body> ");
                        out.print("</html>");
                    }    
                }   
                else
                {                
                    out.print("<td id=\"perfillink\" class=\"border\">");
                    out.print("<a href=\"profile.jsp?USERNAME="+user+"\">");
                    out.print("<table>");
                    out.print("<tr id=\"perfil\">");
                    out.print("<td align=\"right\">");
                    out.print("<h3>"+user+"</h3>");
                    out.print("</td>");
                    out.print("<td align=\"right\" >");
                    out.print("<img src=\"readUserImages?IMAGE=PROFILE&USERNAME="+user+"\" alt=\"Profile\" width=\"50\" height=\"50\" id=\"avatar\" onerror=\"this.src = 'css/img/Cursed.png'\">");
                    out.print("</td>");
                    out.print("</tr>");
                    out.print("</table>");
                    out.print("</a>");
                    out.print("</td>");
                    out.print("</tr>");
                    out.print("</table>");                      
                    out.print("</header>");
                    out.print("<main>");

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Ese nombre y/o correo electronico no esta(n) disponible(s)');");
                    out.println("location='profileModify.jsp';");
                    out.println("</script>");

                    out.print("</main>");
                    out.print("</body> ");
                    out.print("</html>"); 
                } 
            }
            else
            {
                out.print("<td id=\"perfillink\" class=\"border\">");
                out.print("<a href=\"profile.jsp?USERNAME="+user+"\">");
                out.print("<table>");
                out.print("<tr id=\"perfil\">");
                out.print("<td align=\"right\">");
                out.print("<h3>"+user+"</h3>");
                out.print("</td>");
                out.print("<td align=\"right\" >");
                out.print("<img src=\"readUserImages?IMAGE=PROFILE&USERNAME="+user+"\" alt=\"Profile\" width=\"50\" height=\"50\" id=\"avatar\" onerror=\"this.src = 'css/img/Cursed.png'\">");
                out.print("</td>");
                out.print("</tr>");
                out.print("</table>");
                out.print("</a>");
                out.print("</td>");
                out.print("</tr>");
                out.print("</table>");                      
                out.print("</header>");
                out.print("<main>");

                out.println("<script type=\"text/javascript\">");
                out.println("alert('No indico un tipo de modificacion valido');");
                out.println("location='profileModify.jsp';");
                out.println("</script>");

                out.print("</main>");
                out.print("</body> ");
                out.print("</html>");
            }            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            users.Disconnect();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
