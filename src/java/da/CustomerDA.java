/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da; // Adjust this package name as needed

import java.sql.Connection; // Assuming you have a Toolkit class for utility methods
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Customer;

public class CustomerDA {

    private static Connection connection;

    private final static String url = "jdbc:derby://localhost:1527/btdb";
    private final static String user = "nbuser";
    private final static String password = "nbuser";

    // Constructor to establish the database connection
    public CustomerDA() throws SQLException {
        this.connection = DriverManager.getConnection(url, user, password);
    }

    // Method to add a customer
    public void addCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO customer (custid, fname, lname, email, psw) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, customer.getCustid());
            stmt.setString(2, customer.getFname());
            stmt.setString(3, customer.getLname());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getPsw());
            stmt.executeUpdate();
        }
    }

    // Method to retrieve a customer by ID
    public Customer getCustomer(String custid) throws SQLException {
        String sql = "SELECT * FROM customer WHERE custid = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, custid);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getString("custid"),
                        rs.getString("fname"),
                        rs.getString("lname"),
                        rs.getString("email"),
                        rs.getString("psw")
                );
            }
        }
        return null; // Customer not found
    }
    
    public Customer getCustomerByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM customer WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getString("custid"),
                        rs.getString("fname"),
                        rs.getString("lname"),
                        rs.getString("email"),
                        rs.getString("psw")
                );
            }
        }
        return null; // Customer not found
    }

    // Method to update a customer
    public void updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE customer SET fname = ?, lname = ?, email = ?, psw = ? WHERE custid = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, customer.getFname());
            stmt.setString(2, customer.getLname());
            stmt.setString(3, customer.getEmail());
            stmt.setString(4, customer.getPsw());
            stmt.setString(5, customer.getCustid());
            stmt.executeUpdate();
        }
    }

    //Method to search for customers
    public ArrayList<Customer> srcCustomer(String search) throws SQLException {
        String sql = "SELECT * FROM customer WHERE lower(fname) LIKE ? OR lower(lname) LIKE ? OR lower(email) LIKE ? OR lower(custid) LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + search + "%");
            stmt.setString(2, "%" + search + "%");
            stmt.setString(3, "%" + search + "%");
            stmt.setString(4, "%" + search + "%");

            ResultSet rs = stmt.executeQuery();
            ArrayList<Customer> custList = new ArrayList<>();
            while (rs.next()) {
                Customer cust = new Customer();
                cust.setCustid(rs.getString("custid"));
                cust.setFname(rs.getString("fname"));
                cust.setLname(rs.getString("lname"));
                cust.setEmail(rs.getString("email"));
                custList.add(cust);
            }
            return custList;
        }
    }

    // Method to retrieve all customers
    public ArrayList<Customer> getAllCust() throws SQLException {
        String queryStr = "SELECT * FROM customer";
        ArrayList<Customer> custList = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(queryStr); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustid(rs.getString("custid"));
                customer.setFname(rs.getString("fname"));
                customer.setLname(rs.getString("lname"));
                customer.setEmail(rs.getString("email"));
                custList.add(customer);
            }
        }

        return custList;
    }

    // Method to delete a customer
    public void deleteCustomer(String custid) throws SQLException {
        String sql = "DELETE FROM customer WHERE custid = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, custid);
            stmt.executeUpdate();
        }
    }

    // Optional: Method to close the connection
    public void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}
