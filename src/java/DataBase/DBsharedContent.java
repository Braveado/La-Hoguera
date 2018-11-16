/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import java.io.InputStream;
import java.util.Date;
import java.sql.ResultSet;

/**
 *
 * @author Nelson
 */
public class DBsharedContent extends DBconnection
{
    public DBsharedContent()
    {
        Connect();
    }
    
    public boolean AddVideo(Integer userid, String title, String description, String category1, String category2, String category3, 
            InputStream image, Boolean restricted, String dir) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO VIDEOS (USERID, TITLE, DESCRIPTION, CATEGORY1, CATEGORY2, CATEGORY3, IMAGE, RESTRICTED, UPLOADED, DIR) "
                                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            stmt.setInt(1, userid);
            stmt.setString(2, title);      
            stmt.setString(3, description);
            stmt.setString(4, category1);
            stmt.setString(5, category2);
            stmt.setString(6, category3);
            stmt.setBlob(7, image);
            stmt.setBoolean(8, restricted); 
            Date date = new Date();  
            java.sql.Date sqlDate = new java.sql.Date(date.getTime());         
            stmt.setDate(9, sqlDate);
            stmt.setString(10, dir);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }  
    
    public boolean ModVideo(Integer videoid, String title, String description, String category1, String category2, String category3, 
            InputStream image, Boolean restricted, String dir) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("UPDATE VIDEOS SET TITLE=?, DESCRIPTION=?, CATEGORY1=?, CATEGORY2=?, CATEGORY3=?, RESTRICTED=? "
                                        + "WHERE ID=? ");
            
            stmt.setString(1, title);      
            stmt.setString(2, description);
            stmt.setString(3, category1);
            stmt.setString(4, category2);
            stmt.setString(5, category3);            
            stmt.setBoolean(6, restricted); 
            stmt.setInt(7, videoid);
            stmt.executeUpdate();
            
            if(image != null)
            {
                getStmt();
                stmt = con.prepareStatement("UPDATE VIDEOS SET IMAGE=? WHERE ID=? ");
                stmt.setBlob(1, image);
                stmt.setInt(2, videoid);
                stmt.executeUpdate();
            }
            
            if(dir != null)
            {
                getStmt();
                stmt = con.prepareStatement("UPDATE VIDEOS SET DIR=? WHERE ID=? ");
                stmt.setString(1, dir);
                stmt.setInt(2, videoid);
                stmt.executeUpdate();
            }
            
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    } 
    
    public ResultSet GetVideoPlay(Integer vid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT USERID, TITLE, DESCRIPTION, CATEGORY1, CATEGORY2, CATEGORY3, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED, DIR FROM VIDEOS WHERE ID = ?");
            stmt.setInt(1, vid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException GetImage: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetViews(Integer vid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();
            stmt = con.prepareStatement("SELECT REPRODUCTIONS FROM VIDEOS WHERE ID = ?");            
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
    
    public boolean IncViews(Integer vid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("UPDATE VIDEOS SET REPRODUCTIONS = REPRODUCTIONS + 1 WHERE ID = ?");            
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
    
    public ResultSet GetVideos(Integer userid, String order) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql1 = "SELECT ID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED FROM VIDEOS WHERE USERID = ? ";
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
            System.err.println("SQLException GetImage: " + ex.getMessage());
            return null;
        }
    }  
    
    public ResultSet FindVideos(String filter, String quest, String questc, String questf1, String questf2) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql1 = "SELECT ID, USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED FROM VIDEOS ";
            String sql2 = "";
            String sqlf = "";
            switch(filter)
            {
                case "Titulo":
                    sql2 = "WHERE UPPER(TITLE) LIKE UPPER(?) ORDER BY TITLE";
                    sqlf = sql1 + sql2;
                    stmt = con.prepareStatement(sqlf);
                    String prepquest = "%"+quest+"%";
                    stmt.setString(1, prepquest);
                    break;
                case "Usuario":
                    sql2 = "WHERE USERID = ANY (SELECT ID FROM USERS WHERE UPPER(USERNAME) LIKE UPPER(?)) ORDER BY USERID";
                    sqlf = sql1 + sql2;
                    stmt = con.prepareStatement(sqlf);
                    String prepquestusr = "%"+quest+"%";
                    stmt.setString(1, prepquestusr);
                    break;
                case "Categoria":
                    sql2 = "WHERE CATEGORY1 = ? ORDER BY CATEGORY1";
                    sqlf = sql1 + sql2;
                    stmt = con.prepareStatement(sqlf);
                    stmt.setString(1, questc);
                    break;
                case "Rango de Fechas":
                    sql2 = "WHERE UPLOADED >= ? AND UPLOADED <= ? ORDER BY UPLOADED";
                    sqlf = sql1 + sql2;
                    stmt = con.prepareStatement(sqlf);
                    stmt.setDate(1, java.sql.Date.valueOf(questf1));
                    stmt.setDate(2, java.sql.Date.valueOf(questf2));
                    break;
                default:
                    sql1 = "";
                    sql2 = "";
                    sqlf = sql1 + sql2;
                    stmt = con.prepareStatement(sqlf);
                    break;
            }                                    
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetMostRepVideos() throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            stmt = con.prepareStatement("SELECT ID, USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED FROM VIDEOS ORDER BY REPRODUCTIONS DESC FETCH FIRST 6 ROWS ONLY");
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetLeastUplVideos() throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            stmt = con.prepareStatement("SELECT ID, USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED FROM VIDEOS ORDER BY UPLOADED DESC FETCH FIRST 6 ROWS ONLY");
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetRndFavVideos() throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            stmt = con.prepareStatement("SELECT ID, USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED FROM VIDEOS WHERE FAVORITES > ? ORDER BY RANDOM() FETCH FIRST 6 ROWS ONLY");
            stmt.setInt(1, 0);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetLeastUplFolVideos(Integer userid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                        
            stmt = con.prepareStatement("SELECT VIDEOS.ID, USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED FROM VIDEOS, FOLLOWS WHERE FOLLOWER = ? AND FOLLOWING = USERID ORDER BY UPLOADED DESC FETCH FIRST 6 ROWS ONLY");
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
    
    public ResultSet GetCategoryVideos(String category, String order) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql1 = "SELECT ID, USERID, TITLE, CATEGORY1, REPRODUCTIONS, LIKES, FAVORITES, UPLOADED, RESTRICTED FROM VIDEOS WHERE CATEGORY1 = ? ";
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
            stmt.setString(1, category);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetVideo(Integer videoid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT IMAGE FROM VIDEOS WHERE ID = ?";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, videoid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException GetImage: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetVideoDir(Integer videoid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT DIR FROM VIDEOS WHERE ID = ?";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, videoid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public boolean DelVideo(Integer videoid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM VIDEOS WHERE ID = ?");
            stmt.setInt(1, videoid);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    } 
    
    public ResultSet GetVideoInfo(Integer videoid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT USERID, TITLE, DESCRIPTION, CATEGORY1, CATEGORY2, CATEGORY3, RESTRICTED, UPLOADED, REPRODUCTIONS, LIKES, FAVORITES FROM VIDEOS WHERE ID = ?";
            stmt = con.prepareStatement(sql);
            stmt.setInt(1, videoid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException GetImage: " + ex.getMessage());
            return null;
        }
    }
      
}
