/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBcomments;
import DataBase.DBusers;
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
@WebServlet(name = "SendComment", urlPatterns = {"/SendComment"})
public class SendComment extends HttpServlet {

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
        PrintWriter out = response.getWriter();
                
        DBcomments comments = new DBcomments();
        ResultSet commentsRS;
        
        DBusers users = new DBusers();
        ResultSet usersRS;
        
        try
        {
            Integer vid = Integer.parseInt(request.getParameter("VID"));
            Integer profid = Integer.parseInt(request.getParameter("USERID"));
            String aname = request.getParameter("ANAME");
            String amail = request.getParameter("AMAIL");
            String comment = request.getParameter("COMMENT");


            if(comments.AddComment(vid, profid, aname, amail, comment))
            {
                commentsRS = comments.GetVideoComments(vid);
                while(commentsRS.next())
                {           
                    profid = commentsRS.getInt("USERID");
                    String profname = commentsRS.getString("aname");
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
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            comments.Disconnect();
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
