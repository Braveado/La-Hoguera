/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBpassword;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nelson
 */
@WebServlet(name = "password", urlPatterns = {"/password"})
public class password extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        DBpassword pass = new DBpassword(); 
        try 
        {
            PrintWriter out = response.getWriter();                                    
            ResultSet res;            
            String name = request.getParameter("USERNAME");
            String email = request.getParameter("EMAIL");            
            
            if(!name.equals("admin"))
            {
                res = pass.ValidateExistance(name, email);
                if(res.next())
                {     
                    String question = res.getString(1);
                    String answer = res.getString(2);               

                    out.print("<!DOCTYPE html>");
                    out.print("<html>");
                    out.print("<head>");
                    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/sesion.css\">");
                    out.print("<script src=\"js/password.js\"></script>");
                    out.print("<title>Recuperar Contraseña - La Hoguera</title>");
                    out.print("</head>");
                    out.print("<body>");
                    out.print("<header>");
                    out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                    out.print("</header>");
                    out.print("<section id=\"rc1\"> ");
                    out.print("<ul><li class=\"imagen\">");
                    out.print("<img src=\"css/img/Tools.png\" height=\"60\">");
                    out.print("</li><li id=\"pregunta\">");
                    out.print("<h3>" + name + "</h3>");
                    out.print("</li><li id=\"pregunta\">");
                    out.print("<h3>" + question + "</h3>");
                    out.print("</li><li>");
                    out.print("<input type=\"password\" placeholder=\"Respuesta\" id=\"resp\">");
                    out.print("</li><li>");
                    out.print("<input type=\"submit\" value=\"Responder\" onclick=\"ValidateAnswer('"+answer+"')\">");
                    out.print("</li></ul>   ");
                    out.print("</section><section id=\"rc2\"> ");
                    out.print("<ul><li class=\"imagen\">");
                    out.print("<img src=\"css/img/Tools.png\" height=\"60\">");
                    out.print("</li><li id=\"pregunta\">");
                    out.print("<h3>" + name + "</h3>");
                    out.print("</li><form method=\"post\" action=\"password_change\" onsubmit=\"return ValidatePassword(this)\"><li>");
                    out.print("<input type=\"text\" name=\"USERNAME\" value="+name+" class=\"hiddeninputs\">");
                    out.print("<input type=\"text\" name=\"EMAIL\" value="+email+" class=\"hiddeninputs\">");
                    out.print("</li><li><p>Contraseña</p>");
                    out.print("<input type=\"password\" name=\"PASSWORD\" placeholder=\"Nueva Contraseña\" id=\"pass\" required>");
                    out.print("<input type=\"password\" placeholder=\"Repetir Contraseña\" id=\"repass\" required>");
                    out.print("</li> <li>");
                    out.print("<input type=\"submit\" value=\"Cambiar Contraseña\">");
                    out.print("</li></form></ul>");
                    out.print("</section>");
                    out.print("</body> ");
                    out.print("</html>");
                }        
                else
                {
                    out.print("<!DOCTYPE html>");
                    out.print("<html>");
                    out.print("<head>");
                    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/sesion.css\">");
                    out.print("<title>Recuperar Contraseña - La Hoguera</title>");
                    out.print("</head>");
                    out.print("<body>");
                    out.print("<header>");
                    out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                    out.print("</header>");
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Ese usuario no existe');");
                    out.println("location='password.html';");
                    out.println("</script>");
                    out.print("</body> ");
                    out.print("</html>");
                }
            }
            else
            {
                out.print("<!DOCTYPE html>");
                out.print("<html>");
                out.print("<head>");
                out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/sesion.css\">");
                out.print("<title>Recuperar Contraseña - La Hoguera</title>");
                out.print("</head>");
                out.print("<body>");
                out.print("<header>");
                out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                out.print("</header>");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('No se puede cambiar la contraseña del administrador');");
                out.println("location='password.html';");
                out.println("</script>");
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
            pass.Disconnect();
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
