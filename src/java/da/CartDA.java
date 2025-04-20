package da;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;
import model.Cart;

public class CartDA {

    private final String jdbcURL = "jdbc:derby://localhost:1527/btdb";
    private final String jdbcUsername = "nbuser";
    private final String jdbcPassword = "nbuser";
    
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            throw new SQLException(e);
        }
    }
    
    public Cart checkExistingCartItem(String custId, String sku, String size) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            String sql = "SELECT c.*, p.NAME, p.FILE, p.PRICE FROM CART c "
                      + "JOIN PRODUCT p ON c.SKU = p.SKU "
                      + "WHERE c.CUSTID = ? AND c.SKU = ? AND c.SIZE = ?";
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, custId);
            ps.setString(2, sku);
            ps.setString(3, size);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Cart cart = new Cart(
                    rs.getString("UID"),
                    rs.getString("CUSTID"),
                    rs.getString("SKU"),
                    rs.getString("SIZE"),
                    rs.getInt("QTY")
                );
                cart.setProductName(rs.getString("NAME"));
                cart.setFile(rs.getString("FILE"));
                cart.setPrice(rs.getDouble("PRICE"));
                return cart;
            }
            return null;
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
    
    public String addToCart(String custId, String sku, String size, int qty) throws SQLException {
        Cart existingItem = checkExistingCartItem(custId, sku, size);
        
        if (existingItem != null) {
            // Update existing item quantity
            existingItem.setQty(existingItem.getQty() + qty);
            updateCartItem(existingItem);
            return existingItem.getUid();
        }
        
        // If no existing item, insert new one
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = getConnection();
            String sql = "INSERT INTO CART (UID, CUSTID, SKU, SIZE, QTY) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            
            String uid = String.valueOf(System.currentTimeMillis());
            ps.setString(1, uid);
            ps.setString(2, custId);
            ps.setString(3, sku);
            ps.setString(4, size);
            ps.setInt(5, qty);
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return uid;
            }
            return null;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    public List<Cart> getCartByCustomer(String custId) {
        List<Cart> cartList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            
            // Modified query to get all cart items, ordered by SKU and SIZE
            String sql = "SELECT c.*, p.NAME, p.FILE, p.PRICE "
                      + "FROM CART c "
                      + "JOIN PRODUCT p ON c.SKU = p.SKU "
                      + "WHERE c.CUSTID = ? "
                      + "ORDER BY c.SKU, c.SIZE";
                      
            ps = conn.prepareStatement(sql);
            ps.setString(1, custId);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Cart cart = new Cart(
                    rs.getString("UID"),
                    rs.getString("CUSTID"),
                    rs.getString("SKU"),
                    rs.getString("SIZE"),
                    rs.getInt("QTY")
                );
                cart.setProductName(rs.getString("NAME"));
                cart.setFile(rs.getString("FILE"));
                cart.setPrice(rs.getDouble("PRICE"));
                
                cartList.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return cartList;
    }

    public boolean updateCartItem(Cart cart) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = getConnection();
            String sql = "UPDATE CART SET SIZE = ?, QTY = ? WHERE UID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, cart.getSize());
            ps.setInt(2, cart.getQty());
            ps.setString(3, cart.getUid());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean checkDuplicateOnEdit(String custId, String currentUid, String sku, String size) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            // Check if any other item exists with same SKU and size (excluding current item)
            String sql = "SELECT COUNT(*) as COUNT FROM CART WHERE CUSTID = ? AND SKU = ? AND SIZE = ? AND UID != ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, custId);
            ps.setString(2, sku);
            ps.setString(3, size);
            ps.setString(4, currentUid);
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("COUNT") > 0;
            }
            return false;
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }

    public boolean deleteCartItem(String uid) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = getConnection();
            String sql = "DELETE FROM CART WHERE UID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, uid);
            
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        } finally {
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    }
}
