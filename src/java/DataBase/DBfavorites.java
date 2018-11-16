/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import java.sql.ResultSet;

/**
 *
 * @author Nelson
 */
public class DBfavorites extends DBconnection
{
    public DBfavorites()
    {
        Connect();
    }
    
    public Boolean AddFav(Integer vid, Integer userid) throws Exception
    {
        try
        {
            getStmt();                        
            stmt = con.prepareStatement("INSERT INTO FAVORITES (VIDEOID, USERID) VALUES (?, ?)");
            stmt.setInt(1, vid);
            stmt.setInt(2, userid);
            stmt.executeUpdate();
            
            getStmt();                        
            stmt = con.prepareStatement("UPDATE VIDEOS SET FAVORITES = FAVORITES + 1 WHERE ID = ?");
            stmt.setInt(1, vid);
            stmt.executeUpdate();
            
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }    
    
    public Boolean DelFav(Integer vid, Integer userid) throws Exception
    {
        try
        {
            getStmt();                        
            stmt = con.prepareStatement("DELETE FROM FAVORITES WHERE VIDEOID = ? AND USERID = ?");
            stmt.setInt(1, vid);
            stmt.setInt(2, userid);
            stmt.executeUpdate();
            
            getStmt();                        
            stmt = con.prepareStatement("UPDATE VIDEOS SET FAVORITES = FAVORITES - 1 WHERE ID = ?");
            stmt.setInt(1, vid);
            stmt.executeUpdate();
            
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }  
    
    public ResultSet CheckFavorite(Integer vid, Integer userid) throws Exception
    {
        try
        {
           ResultSet resultado;
            getStmt();                        
            stmt = con.prepareStatement("SELECT ID FROM FAVORITES WHERE VIDEOID = ? AND USERID = ?");
            stmt.setInt(1, vid);
            stmt.setInt(2, userid);
            resultado = stmt.executeQuery();
            return resultado;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetFavs(Integer vid) throws Exception
    {
        try
        {
           ResultSet resultado;
            getStmt();                        
            stmt = con.prepareStatement("SELECT FAVORITES FROM VIDEOS WHERE ID = ?");
            stmt.setInt(1, vid);
            resultado = stmt.executeQuery();
            return resultado;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetFavorites(Integer userid, String order) throws Exception
    {
        try
        {
           ResultSet resultado;
            getStmt();            
            String sql1 = "SELECT VIDEOS.ID, VIDEOS.USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, VIDEOS.FAVORITES, UPLOADED, RESTRICTED FROM FAVORITES, VIDEOS WHERE VIDEOID = VIDEOS.ID AND FAVORITES.USERID = ? ";
            String sql2 = "";  
            if(order == null)
                order = "TA";
            switch(order)
            {
                case "TA":
                    sql2 = "ORDER BY TITLE";
                    break;
                case "UD":
                    sql2 = "ORDER BY UPLOADED DESC";
                    break;
                case "UA":
                    sql2 = "ORDER BY UPLOADED";
                    break;
                case "RD":
                    sql2 = "ORDER BY REPRODUCTIONS DESC";
                    break;
                case "RA":
                    sql2 = "ORDER BY REPRODUCTIONS";
                    break;
                case "LD":
                    sql2 = "ORDER BY LIKES DESC";
                    break;
                case "LA":
                    sql2 = "ORDER BY LIKES";
                    break;
                case "FD":
                    sql2 = "ORDER BY FAVORITES DESC";
                    break;
                case "FA":
                    sql2 = "ORDER BY FAVORITES";
                    break;
                default:
                    sql2 = "ORDER BY TITLE";
                    break;
            }
            String sqlf = sql1 + sql2;
            stmt = con.prepareStatement(sqlf);
            stmt.setInt(1, userid);
            resultado = stmt.executeQuery();
            return resultado;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
     public Boolean AddLike(Integer vid, Integer userid) throws Exception
    {
        try
        {
            getStmt();                        
            stmt = con.prepareStatement("INSERT INTO LIKES (VIDEOID, USERID) VALUES (?, ?)");
            stmt.setInt(1, vid);
            stmt.setInt(2, userid);
            stmt.executeUpdate();
            
            getStmt();                        
            stmt = con.prepareStatement("UPDATE VIDEOS SET LIKES = LIKES + 1 WHERE ID = ?");
            stmt.setInt(1, vid);
            stmt.executeUpdate();
            
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }    
    
    public Boolean DelLike(Integer vid, Integer userid) throws Exception
    {
        try
        {
            getStmt();                        
            stmt = con.prepareStatement("DELETE FROM LIKES WHERE VIDEOID = ? AND USERID = ?");
            stmt.setInt(1, vid);
            stmt.setInt(2, userid);
            stmt.executeUpdate();
            
            getStmt();                        
            stmt = con.prepareStatement("UPDATE VIDEOS SET LIKES = LIKES - 1 WHERE ID = ?");
            stmt.setInt(1, vid);
            stmt.executeUpdate();
            
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }  
    
    public ResultSet CheckLike(Integer vid, Integer userid) throws Exception
    {
        try
        {
           ResultSet resultado;
            getStmt();                        
            stmt = con.prepareStatement("SELECT ID FROM LIKES WHERE VIDEOID = ? AND USERID = ?");
            stmt.setInt(1, vid);
            stmt.setInt(2, userid);
            resultado = stmt.executeQuery();
            return resultado;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetLikes(Integer vid) throws Exception
    {
        try
        {
           ResultSet resultado;
            getStmt();                        
            stmt = con.prepareStatement("SELECT LIKES FROM VIDEOS WHERE ID = ?");
            stmt.setInt(1, vid);
            resultado = stmt.executeQuery();
            return resultado;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
}
