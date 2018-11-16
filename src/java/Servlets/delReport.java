/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBreports;
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
@WebServlet(name = "delReport", urlPatterns = {"/delReport"})
public class delReport extends HttpServlet {

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
        DBreports reports = new DBreports();
        ResultSet reportsRS = null;
        try
        {
            PrintWriter out = response.getWriter();     
            
            String user = (String)request.getSession(false).getAttribute("user"); 
            Integer rid = Integer.parseInt(request.getParameter("ID"));  
            reportsRS = reports.GetReason(rid);
            String reason = null;
            if(reportsRS.next())
                reason = reportsRS.getString("REASON");
            
            out.print("<!DOCTYPE html>");
            out.print("<html>");
            out.print("<head>");
            out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\">");
            out.print("<script src=\"js/logAlert.js\"></script>"); 
            out.print("<script src=\"js/searchValidation.js\"></script>");
            out.print("<title>Eliminar Reporte - La Hoguera</title>");
            out.print("</head>");
            out.print("<body>");
            out.print("<section class=\"principal\">");
            out.print("<a href=\"main.jsp\">");
            out.print("<img src=\"css/img/LaHoguera.png\" height=\"90\" width=\"500\">");
            out.print("</a>");
            out.print("</section>");
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

            if(reports.DelReport(rid))
            {
                out.println("<section class=\"modificarusuario\">");
                out.println("<ul>");
                out.println("<li class=\"imagen\">");
                out.println("<img src=\"css/img/Tools.png\" height=\"60\">");
                out.println("</li>");
                out.println("<li id=\"pregunta\">");
                out.println("<h3>Reporte Por</h3>");
                out.println("</li>");   
                out.println("<li id=\"pregunta\">");
                out.println("<h3>"+reason+"</h3>");
                out.println("</li>");
                out.println("<li id=\"pregunta\">");
                out.println("<h3>Eliminado Exitosamente</h3>");
                out.println("</li>");
                out.println("<li>");
                out.println("<a href=\"adminReports.jsp\">");
                out.println("<input type=\"submit\" value=\"Regresar\">");
                out.println("</a>");
                out.println("</li>");
                out.println("</ul>");
                out.println("</section>");                
            }    
            else
            {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Error al eliminar reporte');");
                out.println("location='adminReports.jsp';");
                out.println("</script>");
            }

            out.print("</main>");
            out.print("</body> ");
            out.print("</html>");  
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            reports.Disconnect();
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
