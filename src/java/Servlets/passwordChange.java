/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBpassword;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nelson
 */
@WebServlet(name = "password_change", urlPatterns = {"/password_change"})
public class passwordChange extends HttpServlet {

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
                                   
            String name = request.getParameter("USERNAME");
            String email = request.getParameter("EMAIL");  
            String password = request.getParameter("PASSWORD");            
            if(pass.UpdatePassword(name, email, password))
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
                out.print("<section id=\"signup\"> ");
                out.print("<ul><li class=\"imagen\">");
                out.print("<img src=\"css/img/Tools.png\" height=\"60\">");
                out.print("</li><li id=\"pregunta\">");
                out.print("<h3>" + name + "</h3>");
                out.print("</li><li id=\"pregunta\">");
                out.print("<h3>Contraseña cambiada con exito.</h3><h3>Nueva contraseña:</h3>");
                out.print("</li><li id=\"pregunta\">");
                out.print("<h3>"+ password +"</h3>");
                out.print("</li></ul>  ");
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
                out.println("alert('Error al cambiar la contraseña');");
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
