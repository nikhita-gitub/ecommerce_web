package com.connection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;



public class DatabaseConnection{
    //Creating database Connection in java online shopping system
    public static Connection connection;
    
    public static Connection getConnection(){
        try{
            //registering with mysql Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ecommerce","root","root");
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return connection;
    }
    //Creating universal method to close connect will mysql database
    
    public static void CloseConnection(){
        if(connection != null){
            try{
                connection.close();
                connection = null;
            }
            catch(SQLException ex){
                ex.printStackTrace();
            }
        }
    }
    
    //Creating universal method to query for retrieving information
    
    public static ResultSet getResultFromSqlQuery(String SqlQueryString){
        //Creating Resultset object
        
        ResultSet rs = null;
        try{
            //Checking whether the connection is null or null
            if(connection ==null){
               connection= getConnection();
            }
            rs = connection.createStatement().executeQuery(SqlQueryString);
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return rs;
    }
   //Creating universal method to query for inserting or updating information in mysql database
    
    public static int insertUpdateFromSqlQuery(String SqlQueryString){
        
        int result=2;
        try{
            //Checking whether the connection is null or null
            if (connection == null) {
                connection =getConnection();
            }
            result = connection.createStatement().executeUpdate(SqlQueryString);
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        return result;
    }
    
    
}