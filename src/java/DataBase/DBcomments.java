/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Nelson
 */
public class DBcomments extends DBconnection
{
    public DBcomments()
    {
        Connect();
    }
    
    public boolean AddComment(Integer vid, Integer profid, String aname, String amail, String comment) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO COMMENTS (VIDEOID, USERID, ANAME, AMAIL, COMMENT, WRITTEN) VALUES (?, ?, ?, ?, ?, ?)");
            stmt.setInt(1, vid);
            stmt.setInt(2, profid);
            stmt.setString(3, aname);      
            stmt.setString(4, amail);
            stmt.setString(5, comment);
            String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date());                     
            stmt.setString(6, timeStamp);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    } 
    
    public ResultSet GetVideoComments(Integer vid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();                       
            stmt = con.prepareStatement("SELECT USERID, ANAME, AMAIL, COMMENT, WRITTEN FROM COMMENTS WHERE VIDEOID = ? ORDER BY ID DESC");
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
}
