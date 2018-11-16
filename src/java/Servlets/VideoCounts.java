/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import DataBase.DBfavorites;
import DataBase.DBsharedContent;
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
@WebServlet(name = "VideoCounts", urlPatterns = {"/VideoCounts"})
public class VideoCounts extends HttpServlet {

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
        
        Integer vid = Integer.parseInt(request.getParameter("VID"));
        String act = request.getParameter("ACTION");
        Integer usrid = Integer.parseInt(request.getParameter("USERID"));
        String result = "";
        
        DBsharedContent sharedContent = new DBsharedContent();
        ResultSet sharedContentRS = null;
        DBfavorites favorites = new DBfavorites();
        ResultSet favoritesRS = null;
        
        try  
        {
            
            
            switch(act)
            {
                case "IR":
                    sharedContent.IncViews(vid);
                    sharedContentRS = sharedContent.GetViews(vid);            
                    sharedContentRS.next();
                    result = "<img src=\"css/img/Binoculars.png\" width=\"24\" height=\"24\" class=\"icon\"> "+Integer.toString(sharedContentRS.getInt("REPRODUCTIONS"));            
                    out.write(result);
                    break;
                case "AF":
                    favorites.AddFav(vid, usrid);
                    favoritesRS = favorites.GetFavs(vid);            
                    favoritesRS.next();
                    result = "<img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+Integer.toString(favoritesRS.getInt("FAVORITES"));            
                    out.write(result);
                    break;
                case "RF":
                    favorites.DelFav(vid, usrid);
                    favoritesRS = favorites.GetFavs(vid);            
                    favoritesRS.next();
                    result = "<img src=\"css/img/SunlightMedal.png\" width=\"24\" height=\"24\" class=\"icon\"> "+Integer.toString(favoritesRS.getInt("FAVORITES"));            
                    out.write(result);
                    break;
                case "AL":
                    favorites.AddLike(vid, usrid);
                    favoritesRS = favorites.GetLikes(vid);            
                    favoritesRS.next();
                    result = "<img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+Integer.toString(favoritesRS.getInt("LIKES"));            
                    out.write(result);
                    break;
                case "RL":
                    favorites.DelLike(vid, usrid);
                    favoritesRS = favorites.GetLikes(vid);            
                    favoritesRS.next();
                    result = "<img src=\"css/img/PrismStone.png\" width=\"24\" height=\"24\" class=\"icon\"> "+Integer.toString(favoritesRS.getInt("LIKES"));            
                    out.write(result);
                    break;
                default:
                    break;
            }            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        finally
        {
            sharedContent.Disconnect();
            favorites.Disconnect();
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
