/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import domain.Toolkit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Customer;
/**
 *
 * @author User
 */
public class CustomerDA {
    private static Connection connection;
    
    private final static String url = "jdbc:derby://localhost:1527/btdb";
    private final static String user = "nbuser";
    private final static String password = "nbuser";
    
    public CustomerDA() throws SQLException {
        createConnection();
    }
    
    private static void createConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(url, user, password);
        }
    }
    
    public static void addCustomer(Customer customer) throws SQLException {
        createConnection(); // Ensure connection is available
        
        String sql = "INSERT INTO customer (custid, fname, lname, email, psw) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String custId = Toolkit.generateUID();
            stmt.setString(1, custId);
            stmt.setString(2, customer.getFirstName());   
            stmt.setString(3, customer.getLastName());   
            stmt.setString(4, customer.getEmail());  
            stmt.setString(5, Toolkit.hashPsw(customer.getPassword())); // psw (hashed)
            stmt.executeUpdate();
        }
    }
    
    public static Customer validateLogin(String email, String password) throws SQLException {
        createConnection(); // Ensure connection is available
        
        String sql = "SELECT * FROM customer WHERE email = ? AND psw = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, Toolkit.hashPsw(password)); // Hash the password for comparison
            
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                // Create and return a Customer object if credentials are valid
                Customer customer = new Customer(
                    rs.getString("custid"),
                    rs.getString("fname"),
                    rs.getString("lname"),
                    rs.getString("email"),
                    "" // Don't include password in the returned object for security
                );
                return customer;
            }
            return null; // Return null if no matching user found
        }
    }

    public static boolean isEmailExists(String email) throws SQLException {
        createConnection(); // Ensure connection is available
        
        String sql = "SELECT COUNT(*) FROM customer WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0; // Returns true if count is greater than 0
            }
            return false;
        }
    }
}
