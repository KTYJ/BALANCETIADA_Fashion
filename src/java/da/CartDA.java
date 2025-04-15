/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.DataSource;
import model.Cart;

public class CartDA {

    private Connection connection;

    public CartDA() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver"); // <== make sure add this!
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("jdbc/btdb");
            connection = ds.getConnection();
            System.out.println("Database Connected!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Cart> getCartByCustomer(String custId) {
        List<Cart> cartList = new ArrayList<>();
        try {
            System.out.println("Connecting to database...");
            String sql = "SELECT c.*, p.NAME, p.FILE, p.PRICE "
                    + "FROM CART c JOIN PRODUCT p ON c.SKU = p.SKU WHERE c.CUSTID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, custId);
            System.out.println("Running SQL with custid=" + custId);
            ResultSet rs = ps.executeQuery();
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
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public void updateCartItem(Cart cart) {
        try {
            String sql = "UPDATE CART SET SIZE = ?, QTY = ? WHERE UID = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, cart.getSize());
            ps.setInt(2, cart.getQty());
            ps.setString(3, cart.getUid());

            int rowsUpdated = ps.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
