/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da; // Adjust this package name as needed

import domain.Toolkit;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Product;

public class ProductDA {

    private static Connection connection;
    
    private final static String url = "jdbc:derby://localhost:1527/btdb";
    private final static String user = "nbuser";
    private final static String password = "nbuser";
    
    
    // Constructor to establish the database connection
    public ProductDA() throws SQLException {
        this.connection = DriverManager.getConnection(url, user, password);
    }

    // Method to add a product
    public void addProduct(Product product) throws SQLException {
        String sql = "INSERT INTO product (sku, name, file, stock, description, catId, size, price, sold) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getSku());
            stmt.setString(2, product.getName());
            stmt.setString(3, product.getFile());
            stmt.setString(4, Toolkit.arrayToString(product.getStock()));
            stmt.setString(5, product.getDescription());
            stmt.setInt(6, product.getCatId());
            stmt.setString(7, Toolkit.arrayToString(product.getSize()));
            stmt.setDouble(8, product.getPrice());
            stmt.setInt(9, product.getSold());
            stmt.executeUpdate();
        }
    }

    public ArrayList<Product> srcProduct(String search) throws SQLException {
        String sql = "SELECT * FROM NBUSER.PRODUCT WHERE lower(name) LIKE ? OR lower(description) LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + search + "%");
            stmt.setString(2, "%" + search + "%");
            ResultSet rs = stmt.executeQuery();
            ArrayList<Product> productList = new ArrayList<>();
            while (rs.next()) {
                productList.add(new Product(
                        rs.getString("sku"),
                        rs.getString("name"),
                        rs.getString("file"),
                        Toolkit.stringToIntArray(rs.getString("stock")),
                        rs.getString("description"),
                        rs.getInt("catId"),
                        Toolkit.stringToStrArray(rs.getString("size")),
                        rs.getDouble("price"),
                        rs.getInt("sold")
                ));
            }
            return productList;
        }
    }
    // Method to retrieve a product by SKU
    public Product getProduct(String sku) throws SQLException {
        String sql = "SELECT * FROM NBUSER.PRODUCT WHERE sku = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, sku);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getString("sku"),
                        rs.getString("name"),
                        rs.getString("file"),
                        Toolkit.stringToIntArray(rs.getString("stock")),
                        rs.getString("description"),
                        rs.getInt("catId"),
                        Toolkit.stringToStrArray(rs.getString("size")),
                        rs.getDouble("price"),
                        rs.getInt("sold")
                );
            }
        }
        return null; // Product not found
    }

    public ArrayList<Product> getAllProduct() throws SQLException {
        String sql = "SELECT * FROM NBUSER.PRODUCT";
        ArrayList<Product> productList = new ArrayList<>(); // Initialize the ArrayList
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) { // Loop through the ResultSet
                productList.add(new Product(
                        rs.getString("sku"),
                        rs.getString("name"),
                        rs.getString("file"),
                        Toolkit.stringToIntArray(rs.getString("stock")),
                        rs.getString("description"),
                        rs.getInt("catId"),
                        Toolkit.stringToStrArray(rs.getString("size")),
                        rs.getDouble("price"),
                        rs.getInt("sold")
                ));
            }
        }
        return productList; // Return the list of products
    }

    // Method to update a product
    public void updateProduct(Product product) throws SQLException {
        String sql = "UPDATE product SET name = ?, file = ?, stock = ?, description = ?, catId = ?, size = ?, price = ?, sold = ? WHERE sku = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getFile());
            stmt.setString(3, Toolkit.arrayToString(product.getStock()));
            stmt.setString(4, product.getDescription());
            stmt.setInt(5, product.getCatId());
            stmt.setString(6, Toolkit.arrayToString(product.getSize()));
            stmt.setDouble(7, product.getPrice());
            stmt.setInt(8, product.getSold());

            //SKU is fixed, cannot be changed
            stmt.setString(9, product.getSku());
            stmt.executeUpdate();
        }
    }

    // Method to delete a product
    public void deleteProduct(String sku) throws SQLException {
        String sql = "DELETE FROM product WHERE sku = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, sku);
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
