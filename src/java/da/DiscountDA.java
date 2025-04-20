package da;

import model.Discount; // NEW

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
                String value = rs.getString("VALUE");
                String description = rs.getString("DESCRIPTION");
                
                // Only add if we have at least the essential fields
                if (id != null && code != null && type != null && value != null) {
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
}
