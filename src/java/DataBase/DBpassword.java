/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;

/**
 *
 * @author Nelson
 */
public class DBpassword extends DBconnection
{
        public DBpassword()
    {
        Connect();
    }
    
    public ResultSet ValidateExistance(String name, String email) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT QUESTION, ANSWER FROM USERS WHERE USERNAME = '" + name + "' AND EMAIL = '" + email + "'";
            stmt = con.prepareStatement(sql);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return null;
        }
    }
        
    public boolean UpdatePassword(String name, String email, String password) throws Exception
    {
        try
        {
            String hashedPassword = generateHash(password);
            
            getStmt();
            stmt = con.prepareStatement("UPDATE USERS SET PASSWORD='"+hashedPassword+"' WHERE USERNAME='"+name+"' AND EMAIL='"+email+"'");
            stmt.executeUpdate();
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }
    }  
    
    public String generateHash(String input) 
    {
        StringBuilder hash = new StringBuilder();

        try 
        {
            MessageDigest sha = MessageDigest.getInstance("SHA-1");
            byte[] hashedBytes = sha.digest(input.getBytes());
            char[] digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                            'a', 'b', 'c', 'd', 'e', 'f' };
            for (int idx = 0; idx < hashedBytes.length;   idx++) 
            {
                    byte b = hashedBytes[idx];
                    hash.append(digits[(b & 0xf0) >> 4]);
                    hash.append(digits[b & 0x0f]);
            }
        } 
        catch (NoSuchAlgorithmException e) 
        {            
            System.err.println("generateHash: " + e.getMessage());
        }

        return hash.toString();
    }
}
