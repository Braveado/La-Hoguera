/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Nelson
 */
public class DBconnection
{
    protected Connection con;
    protected PreparedStatement stmt;
    private String serverName = "localhost";
    private String portNumber = "1527";
    private String databaseName = "PAPW";
    private String url = "jdbc:derby://localhost:1527/PAPW";
    private String userName = "nelson";
    private String password = "nelson";
    private String errString;
    
    public Connection Connect()
    {
        con = null;
        try
        {
            Class.forName("org.apache.derby.jdbc.ClientDriver");            
        }
        catch(ClassNotFoundException e)
        {
            errString = "no se encontro el driver.";
            System.out.println(errString);
            e.printStackTrace();
            return null;
        }
        try
        {
            con = DriverManager.getConnection(url, userName, password);            
        }
        catch(SQLException e)
        {
            errString = "fallo el get connection.";
            System.out.println(errString);
            e.printStackTrace();
            return null;
        }
        errString = "Conectado a la base.";
        System.out.println(errString);
        return con;
    }
    
    public void Disconnect()
    {
        try
        {
            if(stmt != null)
            {
                stmt.close();
            }
            con.close();
            errString = "Desconectado de la base.";
            System.out.println(errString);
        }
        catch(SQLException e)
        {
            errString = "Error al desconectar de la base de datos.";
            System.out.println(errString);
        }
    }
    
    public Statement getStmt()
    {
        this.stmt = null;
        return this.stmt;
    }
}