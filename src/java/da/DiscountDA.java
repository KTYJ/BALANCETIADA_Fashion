package da;

import java.sql.*; // NEW
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Discount;

public class DiscountDA {
    private static final Logger LOGGER = Logger.getLogger(DiscountDA.class.getName());

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            String jdbcURL = "jdbc:derby://localhost:1527/btdb";
            String dbUser = "nbuser";
            String dbPass = "nbuser";
            return DriverManager.getConnection(jdbcURL, dbUser, dbPass);
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Derby JDBC driver not found", e);
            throw new SQLException("Derby JDBC driver not found", e);
        }
    }

    public List<Discount> getAllDiscount() {
        List<Discount> codes = new ArrayList<>();
        String sql = "SELECT * FROM DISCOUNT";

        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String id = rs.getString("ID");
                String code = rs.getString("CODE");
                String type = rs.getString("TYPE");
                int value = rs.getInt("VALUE");
                String description = rs.getString("DESCRIPTION");
                
                // Only add if we have at least the essential fields
                if (id != null && code != null && type != null) {
                    Discount discountCode = new Discount(id, code, type, value, 
                        description != null ? description : "");
                    codes.add(discountCode);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching discount codes", e);
            // Return empty list instead of null
            return new ArrayList<>();
        }

        return codes;
    }

    public void addDiscount(Discount discount) throws SQLException {
        String sql = "INSERT INTO DISCOUNT (ID, CODE, TYPE, VALUE, DESCRIPTION) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, discount.getId());
            stmt.setString(2, discount.getCode());
            stmt.setString(3, discount.getType());
            stmt.setInt(4, discount.getValue());
            stmt.setString(5, discount.getDescription());
            
            stmt.executeUpdate();
        }
    }

    public void updateDiscount(Discount discount) throws SQLException {
        String sql = "UPDATE DISCOUNT SET CODE = ?, TYPE = ?, VALUE = ?, DESCRIPTION = ? WHERE ID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, discount.getCode());
            stmt.setString(2, discount.getType());
            stmt.setInt(3, discount.getValue());
            stmt.setString(4, discount.getDescription());
            stmt.setString(5, discount.getId());
            
            stmt.executeUpdate();
        }
    }

    public void deleteDiscount(String id) throws SQLException {
        String sql = "DELETE FROM DISCOUNT WHERE ID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            stmt.executeUpdate();
        }
    }

    public Discount findById(String id) throws SQLException {
        String sql = "SELECT * FROM DISCOUNT WHERE ID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Discount(
                        rs.getString("ID"),
                        rs.getString("CODE"),
                        rs.getString("TYPE"),
                        rs.getInt("VALUE"),
                        rs.getString("DESCRIPTION")
                    );
                }
            }
        }
        return null;
    }

    public Discount findByCode(String code) throws SQLException {
        String sql = "SELECT * FROM DISCOUNT WHERE CODE = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, code);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Discount(
                        rs.getString("ID"),
                        rs.getString("CODE"),
                        rs.getString("TYPE"),
                        rs.getInt("VALUE"),
                        rs.getString("DESCRIPTION")
                    );
                }
            }
        }
        return null;
    }

    public List<Discount> searchDiscounts(String searchTerm) throws SQLException {
        List<Discount> results = new ArrayList<>();
        String sql = "SELECT * FROM DISCOUNT WHERE " +
                    "LOWER(CODE) LIKE ? OR " +
                    "LOWER(DESCRIPTION) LIKE ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm.toLowerCase() + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    results.add(new Discount(
                        rs.getString("ID"),
                        rs.getString("CODE"),
                        rs.getString("TYPE"),
                        rs.getInt("VALUE"),
                        rs.getString("DESCRIPTION")
                    ));
                }
            }
        }
        return results;
    }
}
