/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import java.sql.ResultSet;
import java.util.Date;

/**
 *
 * @author Nelson
 */
public class DBreports extends DBconnection
{
    public DBreports()
    {
        Connect();
    }
    
    public boolean AddReport(Integer videoid, Integer uploaderid, Integer reporterid, String reason) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO REPORTS (VIDEOID, UPLOADERID, REPORTERID, REASON) VALUES (?, ?, ?, ?)");
            stmt.setInt(1, videoid);
            stmt.setInt(2, uploaderid);
            stmt.setInt(3, reporterid);
            stmt.setString(4, reason);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    } 
    
    public boolean DelReport(Integer rid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM REPORTS WHERE ID = ?");
            stmt.setInt(1, rid);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean DelVideoReports(Integer vid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM REPORTS WHERE VIDEOID = ?");
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
    
    public boolean DelUserReports(Integer profid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM REPORTS WHERE UPLOADERID = ?");
            stmt.setInt(1, profid);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }
    
    public ResultSet GetReason(Integer rid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT REASON FROM REPORTS WHERE ID = ?");
            stmt.setInt(1, rid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet CheckBannedVideo(Integer vid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT REASON FROM BANNEDVIDEOS WHERE VIDEOID = ?");
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
    
    public ResultSet CheckBannedUser(Integer profid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT EXPIRES FROM BANNEDUSERS WHERE USERID = ?");
            stmt.setInt(1, profid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetBannedUserInfo(Integer profid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT PERMANENT, EXPIRES, REASON, DETAILS FROM BANNEDUSERS WHERE USERID = ?");
            stmt.setInt(1, profid);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetReports() throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT ID, VIDEOID, REPORTERID, REASON FROM REPORTS ORDER BY ID");            
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetBannedVideos() throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT ID, VIDEOID, REASON FROM BANNEDVIDEOS ORDER BY ID");            
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetBannedUsers() throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT ID, USERID, PERMANENT, EXPIRES, REASON, DETAILS FROM BANNEDUSERS ORDER BY ID");            
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet CountReports(Integer vid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT COUNT(ID) AS COUNTEDREPORTS FROM REPORTS WHERE VIDEOID = ?"); 
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
    
    public boolean BanVideo(Integer vid, String reason) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO BANNEDVIDEOS (VIDEOID, REASON) VALUES (?, ?)");                        
            stmt.setInt(1, vid);
            stmt.setString(2, reason);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean DelUserBan(Integer profid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM BANNEDUSERS WHERE USERID = ?");                        
            stmt.setInt(1, profid);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean DelVideoBan(Integer vid) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM BANNEDVIDEOS WHERE VIDEOID = ?");                        
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
    
    public boolean BanUser(Integer profid, Boolean time, String expires, String reason, String details) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO BANNEDUSERS (USERID, PERMANENT, EXPIRES, REASON, DETAILS) VALUES (?, ?, ?, ?, ?)");     
            stmt.setInt(1, profid);
            stmt.setBoolean(2, time);
            if(!time)
            {
                String [] expsplit = expires.split("-");
                int year = Integer.parseInt(expsplit[0]);
                int month = Integer.parseInt(expsplit[1]);
                int day = Integer.parseInt(expsplit[2]);            
                Date date = new Date(year - 1900, month, day);  
                java.sql.Date sqlDate = new java.sql.Date(date.getTime());                         
                stmt.setDate(3, sqlDate);
            }
            else
                stmt.setDate(3, null);
            stmt.setString(4, reason);
            if(details.compareTo("") != 0)
                stmt.setString(5, details);
            else
                stmt.setString(5, null);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }
}
