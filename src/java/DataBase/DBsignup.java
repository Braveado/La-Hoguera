/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;

/**
 *
 * @author Nelson
 */
public class DBsignup extends DBconnection
{       
    public DBsignup()
    {
        Connect();
    }
    
    public ResultSet ValidateExistance(String name, String email) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT ID FROM USERS WHERE USERNAME = '" + name + "' OR EMAIL = '" + email + "'";
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
    
    public boolean AddUser(String name, String email, String password, String question, String answer, 
            InputStream profile, InputStream cover, String birthdate, String gender, String country, String city) throws Exception
    {
        try
        {
            getStmt();
            stmt = con.prepareStatement("INSERT INTO USERS (USERNAME, EMAIL, PASSWORD, QUESTION, ANSWER, PROFILE, COVER, BIRTHDATE, GENDER, COUNTRY, CITY) "
                                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            stmt.setString(1, name);
            stmt.setString(2, email);
            String hashedPassword = generateHash(password);
            stmt.setString(3, hashedPassword);            
            stmt.setString(4, question);
            stmt.setString(5, answer);
            stmt.setBlob(6, profile);
            stmt.setBlob(7, cover);
            stmt.setString(8, birthdate);
            stmt.setString(9, gender);
            stmt.setString(10, country);
            stmt.setString(11, city);
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
