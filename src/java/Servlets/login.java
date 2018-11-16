/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBlogin;
import DataBase.DBreports;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nelson
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {

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
        DBlogin login = new DBlogin();
        try 
        {            
            PrintWriter out = response.getWriter();                                     
            ResultSet res;            
            String name = request.getParameter("USERNAME");
            String password = request.getParameter("PASSWORD"); 
            Integer id = 0;
            
            res = login.ValidateExistance(name, password);
            if(name == null || res.next())
            {      
                // do cookies
                if(name != null)
                {       
                    id = res.getInt(1);
                    if(request.getParameter("REMEMBER") != null)
                    {
                        // Create cookies for user.      
                        Cookie Cuser = new Cookie("Cuser", name);
                        Cookie Cpass = new Cookie("Cpass", password);
                        // Set expiry date after a month for both the cookies.
                        Cuser.setMaxAge(60*60*24*30); 
                        Cpass.setMaxAge(60*60*24*30); 
                        // Add both the cookies in the response header.
                        response.addCookie( Cuser );
                        response.addCookie( Cpass );
                    }                 
                    else
                    {
                        Cookie cookie = null;
                        Cookie[] cookies = null;
                        // Get an array of Cookies associated with this domain
                        cookies = request.getCookies();
                        if( cookies != null )
                        {
                            for (int i = 0; i < cookies.length; i++)
                            {
                                cookie = cookies[i];
                                if(((cookie.getName()).compareTo("Cuser") == 0) || ((cookie.getName()).compareTo("Cpass") == 0))
                                {
                                    cookie.setMaxAge(0);
                                    response.addCookie(cookie);
                                }
                            }
                        }
                    }                     
                }
                else
                {
                    name = "Anonimo";
                    id = 0;
                }
                // do session
                HttpSession session = request.getSession();
                session.setAttribute("user", name);
                session.setAttribute("userid", id);
                // check ban
                
                DBreports reports = new DBreports();
                ResultSet reportsRS;
                
                reportsRS = reports.GetBannedUserInfo(id);
                if(reportsRS.next())
                {
                    Boolean perma = reportsRS.getBoolean("PERMANENT");
                    String expires = reportsRS.getString("EXPIRES");
                    String reason = reportsRS.getString("REASON");
                    String details = reportsRS.getString("DETAILS");
                    
                    // do html
                    out.print("<!DOCTYPE html>");
                    out.print("<html>");
                    out.print("<head>");
                    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">");
                    out.print("<title>Iniciar Sesion - La Hoguera</title>");
                    out.print("</head>");
                    out.print("<body>");
                    out.print("<section class=\"principal\">");
                    out.print("<a href=\"login.jsp\">");
                    out.print("<img src=\"css/img/LaHoguera.png\" height=\"90\" width=\"500\">");
                    out.print("</a>");
                    out.print("</section>");
                    out.print("<main> ");
                    out.print("<section class=\"modificarusuario\">");
                    out.print("<ul>");
                    out.print("<li class=\"imagen\" id=\"banhead\">");
                    out.print("<img src=\"css/img/Invasion.png\" height=\"60\"> ");
                    out.print("</li>");

                    String until = null;
                    if(perma)
                        until = "Usuario Bloqueado<br>Indefinidamente";
                    else
                        until = "Usuario Bloqueado Hasta<br>"+expires;
                    
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>"+name+"<br>"+until+"</h3>");                                        
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>Por la razon:<br>"+reason+"</h3>");
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<table class=\"coment\">");
                    out.print("<tr>");
                    out.print("<td class=\"comentario\" rowspan=\"3\">");
                    out.print(details);
                    out.print("</td>");
                    out.print("</tr>");
                    out.print("</table>");
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>Para cualquier duda, contacte con:<br>admin@lahoguera.com</h3>");
                    out.print("</li>");
                                        
                    out.print("<li>");    
                    out.print("<a href=\"login.jsp\">");  
                    out.print("<input type=\"submit\" value=\"Regresar\" class=\"ban\">");
                     out.print("</a>"); 
                    out.print("</li> ");
                    out.print("</ul>");
                    out.print("</section>");
                    out.print("</main>");
                    out.print("</body>");
                    out.print("</html>");
                }
                else
                {
                    // do html
                    out.print("<!DOCTYPE html>");
                    out.print("<html>");
                    out.print("<head>");
                    out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/sesion.css\">");
                    out.print("<title>Iniciar Sesion - La Hoguera</title>");
                    out.print("</head>");
                    out.print("<body>");
                    out.print("<header>");
                    out.print("<a href=\"main.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                    out.print("</header>");
                    out.print("<section id=\"signup\"> ");
                    out.print("<ul>");
                    out.print("<li class=\"imagen\">");
                    if((Integer)session.getAttribute("userid") != 0)
                        out.print("<img src=\"css/img/Summon.png\" height=\"60\">");
                    else
                        out.print("<img src=\"css/img/Cursed.png\" height=\"60\">");
                    out.print("</li>");
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>Sesion Iniciada: </h3>");
                    out.print("</li>"); 
                    out.print("<li id=\"pregunta\">");
                    out.print("<h3>" + session.getAttribute("user") +"</h3>");
                    out.print("</li>"); 
                    out.print("<a href=\"main.jsp\">");
                    out.print("<li class=\"fakebutton\">");
                    out.print("Pagina Principal");
                    out.print("</li>");
                    out.print("</a>");
                    out.print("</ul>");
                    out.print("</section>");                               
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
                out.print("<title>Inicar Sesion - La Hoguera</title>");
                out.print("</head>");
                out.print("<body>");
                out.print("<header>");                
                out.print("<a href=\"login.jsp\"><img src=\"css/img/LaHoguera.png\" alt=\"LOGO\" height=\"90\" width=\"500\"></a>");
                out.print("</header>");
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Esa cuenta no existe');");
                out.println("location='login.jsp';");
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
            login.Disconnect();
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
