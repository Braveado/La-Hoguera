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
public class DBfollows extends DBconnection
{
    public DBfollows()
    {
        Connect();
    }
    
    public boolean AddFollow(Integer idFollowing, Integer idFollower) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO FOLLOWS (FOLLOWING, FOLLOWER) VALUES (?, ?)");
            stmt.setInt(1, idFollowing);
            stmt.setInt(2, idFollower);
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }
    
    public ResultSet CheckFollow(Integer idFollowing, Integer idFollower) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();
            stmt = con.prepareStatement("SELECT ID FROM FOLLOWS WHERE FOLLOWING = ? AND FOLLOWER = ?");
            stmt.setInt(1, idFollowing);
            stmt.setInt(2, idFollower);
            resultado = stmt.executeQuery();
            return resultado;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException Check Follow: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet CheckFollowing(Integer userid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();
            stmt = con.prepareStatement("SELECT FOLLOWING FROM FOLLOWS WHERE FOLLOWER = ? ORDER BY ID");
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
        
    public ResultSet CheckFollowers(Integer userid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();
            stmt = con.prepareStatement("SELECT FOLLOWER FROM FOLLOWS WHERE FOLLOWING = ? ORDER BY ID");
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
    
    public boolean DelFollow(Integer idFollowing, Integer idFollower) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("DELETE FROM FOLLOWS WHERE FOLLOWING = ? AND FOLLOWER = ?");
            stmt.setInt(1, idFollowing);
            stmt.setInt(2, idFollower);
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
