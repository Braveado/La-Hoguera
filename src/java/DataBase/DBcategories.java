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
public class DBcategories extends DBconnection
{
    public DBcategories()
    {
        Connect();
    }
    
    public Boolean ModCategories(String c1color, Integer c1order, String c2color, Integer c2order, String c3color, Integer c3order, String c4color, Integer c4order, String c5color, Integer c5order)
    {
        try
        {
            String sql = "UPDATE CATEGORIES SET COLOR=?, POS=? WHERE CATNAME=? ";
            
            getStmt();
            stmt = con.prepareStatement(sql);            
            stmt.setString(1, c1color);      
            stmt.setInt(2, c1order);
            stmt.setString(3, "Dark Souls 1");
            stmt.executeUpdate();
                        
            getStmt();
            stmt = con.prepareStatement(sql);           
            stmt.setString(1, c2color);      
            stmt.setInt(2, c2order);
            stmt.setString(3, "Dark Souls 2");
            stmt.executeUpdate();
            
            getStmt();
            stmt = con.prepareStatement(sql);            
            stmt.setString(1, c3color);      
            stmt.setInt(2, c3order);
            stmt.setString(3, "Dark Souls 3");
            stmt.executeUpdate();
            
            getStmt();
            stmt = con.prepareStatement(sql);             
            stmt.setString(1, c4color);      
            stmt.setInt(2, c4order);
            stmt.setString(3, "PvP");
            stmt.executeUpdate();
            
            getStmt();
            stmt = con.prepareStatement(sql);            
            stmt.setString(1, c5color);      
            stmt.setInt(2, c5order);
            stmt.setString(3, "PvE");
            stmt.executeUpdate();
            
            return true;
        }
        catch(Exception ex)
        {
            System.err.println("SQLException: " + ex.getMessage());
            return false;
        }        
    }
    
    public ResultSet GetCategoriesMod()
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT COLOR, POS FROM CATEGORIES ORDER BY ID";
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
    
    public ResultSet GetCategoriesShow()
    {
        try
        {
            ResultSet resultado;
            getStmt();            
            String sql = "SELECT COLOR, CATNAME FROM CATEGORIES ORDER BY POS";
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
}
