/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DataBase.DBsignup;
import java.io.InputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author Nelson
 */
@MultipartConfig(maxFileSize = 16177215)
@WebServlet(name = "signup", urlPatterns = {"/signup"})
public class signup extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        DBsignup signup = new DBsignup();
        try 
        {
            PrintWriter out = response.getWriter();                                     
            ResultSet res;            
            String name = request.getParameter("USERNAME");
            String email = request.getParameter("EMAIL");            
            
            res = signup.ValidateExistance(name, email);
            if(!res.next() && !name.equals("Anonimo"))
            {
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
                if(signup.AddUser(name, email, password, question, answer, profileStream, coverStream, birthdate, gender, country, city))
                {
                    out.print("<!DOCTYPE html>");
                    out.print("<html>");
                    out.print("<head>");
                    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/sesion.css\">");
                    out.print("<title>Crear Cuenta - La Hoguera</title>");
                    out.print("</head>");
                    out.print("<body>");
                    out.print("<header>");
                    out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                    out.print("</header>");
                    out.print("<section id=\"signup\"> ");
                    out.print("<ul>");
                    out.print("<li class=\"imagen\">");
                    out.print("<img src=\"css/img/Tools.png\" height=\"60\">");
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>Cuenta creada con exito.</h3>");
                    out.print("<h3>Datos para iniciar sesion:</h3>");
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>" + name +"</h3>");
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>" + password +"</h3>");
                    out.print("</li>");
                    out.print("</ul>");
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
                    out.print("<title>Crear Cuenta - La Hoguera</title>");
                    out.print("</head>");
                    out.print("<body>");
                    out.print("<header>");
                    out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                    out.print("</header>");
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Error al agregar el usuario');");
                    out.println("location='signup.html';");
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
                out.print("<title>Crear Cuenta - La Hoguera</title>");
                out.print("</head>");
                out.print("<body>");
                out.print("<header>");
                out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                out.print("</header>");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Ese nombre y/o correo electronico no esta(n) disponible(s)');");
                out.println("location='signup.html';");
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
            signup.Disconnect();
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
