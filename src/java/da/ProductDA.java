package da;

import java.sql.*;
import java.util.*;
import model.Product;

public class ProductDA {

    private final String jdbcURL = "jdbc:derby://localhost:1527/btdb";
    private final String jdbcUsername = "nbuser";
    private final String jdbcPassword = "nbuser";

    private static final String SELECT_BY_CATID = "SELECT * FROM PRODUCT WHERE CATID=?";

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException e) {
            throw new SQLException(e);
        }
    }

    public List<Product> getProductsByCategory(int catid) {
        List<Product> products = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_CATID)) {

            preparedStatement.setInt(1, catid);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setSku(rs.getString("SKU"));
                p.setName(rs.getString("NAME"));
                p.setFile(rs.getString("FILE"));
                p.setStock(rs.getInt("STOCK"));
                p.setDescription(rs.getString("DESCRIPTION"));
                p.setCatid(rs.getInt("CATID"));
                p.setSize(rs.getString("SIZE"));
                p.setPrice(rs.getDouble("PRICE"));
                p.setSold(rs.getInt("SOLD"));
                products.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductBySku(String sku) {
        Product product = null;
        String query = "SELECT * FROM PRODUCT WHERE SKU = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, sku);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setSku(rs.getString("SKU"));
                product.setName(rs.getString("NAME"));
                product.setFile(rs.getString("FILE"));
                product.setStock(rs.getInt("STOCK"));
                product.setDescription(rs.getString("DESCRIPTION"));
                product.setCatid(rs.getInt("CATID"));
                product.setSize(rs.getString("SIZE"));
                product.setPrice(rs.getDouble("PRICE"));
                product.setSold(rs.getInt("SOLD"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

}
