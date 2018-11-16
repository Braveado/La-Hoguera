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
public class DBusers  extends DBconnection
{
    public DBusers()
    {
        Connect();
    }
    
    public ResultSet GetImage(String name, String img) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT " + img + " FROM USERS WHERE USERNAME = '" + name + "'";
            stmt = con.prepareStatement(sql);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException GetImage: " + ex.getMessage());
            return null;
        }
    }      
    
    public ResultSet GetEmail(String name) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT EMAIL FROM USERS WHERE USERNAME = '" + name + "'";
            stmt = con.prepareStatement(sql);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException GetEmail: " + ex.getMessage());
            return null;
        }
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
            System.err.println("SQLException ValidateExistance: " + ex.getMessage());
            return null;
        }
    }
    
    public ResultSet GetName(Integer userid) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();
            stmt = con.prepareStatement("SELECT USERNAME FROM USERS WHERE ID = ?");
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
    
    public ResultSet GetOptionals(String name) throws Exception
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT BIRTHDATE, GENDER, COUNTRY, CITY FROM USERS WHERE USERNAME = '" + name + "'";
            stmt = con.prepareStatement(sql);
            resultado = stmt.executeQuery();
            return resultado;            
        }
        catch(Exception ex)
        {
            System.err.println("SQLException GetOptionals: " + ex.getMessage());
            return null;
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
    
    public boolean ModifyUser(String user, String met, String name, String email, String password, String question, String answer, 
            InputStream profile, InputStream cover, String birthdate, String gender, String country, String city) throws Exception
    {
        try
        {
            if(met.equals("new"))
            {                     
                if(email != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET EMAIL='"+email+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(password != null)
                {                    
                    String hashedPassword = generateHash(password);
                    
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET PASSWORD='"+hashedPassword+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(question != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET QUESTION='"+question+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(answer != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET ANSWER='"+answer+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(profile != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET PROFILE=? WHERE USERNAME='"+user+"'");
                    stmt.setBlob(1, profile);
                    stmt.executeUpdate();
                }
                if(cover != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET COVER=? WHERE USERNAME='"+user+"'");
                    stmt.setBlob(1, cover);
                    stmt.executeUpdate();
                }
                if(birthdate != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET BIRTHDATE='"+birthdate+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(gender != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET GENDER='"+gender+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(country != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET COUNTRY='"+country+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(city != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET CITY='"+city+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                if(name != null)
                {
                    getStmt();
                    stmt = con.prepareStatement("UPDATE USERS SET USERNAME='"+name+"' WHERE USERNAME='"+user+"'");
                    stmt.executeUpdate();
                }
                return true;
            }
            else if(met.equals("all"))
            {
                getStmt();
                stmt = con.prepareStatement("UPDATE USERS SET USERNAME=?, EMAIL=?, PASSWORD=?, QUESTION=?, ANSWER=?, PROFILE=?, COVER=?, BIRTHDATE=?, GENDER=?, COUNTRY=?, CITY=? "
                                            + "WHERE USERNAME='"+user+"'");
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
            else
            {
                return false;
            }
        }
        catch(Exception ex)
        {
            System.err.println("SQLException ModifyUser: " + ex.getMessage());
            return false;
        }
    }
    
}
