package da;

import java.sql.*;
import java.util.ArrayList;
import model.Orders;

public class OrdersDA {
    private static Connection connection;
    private final static String host = "jdbc:derby://localhost:1527/btdb";
    private final static String user = "nbuser";
    private final static String password = "nbuser";
    private final static String tableName = "Orders";

    public OrdersDA() throws SQLException {
        this.connection = DriverManager.getConnection(host, user, password);
    }

    // Get a single order by orderId
    public Orders getOrderByOrderId(String orderId) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Orders order = null;

        try {
            // Get order details
            String sql = "SELECT * FROM " + tableName + " WHERE ORDERID = ? ORDER BY ORDERDATE DESC";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, orderId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Orders();
                order.setOrderId(rs.getString("ORDERID"));
                order.setCustId(rs.getString("CUSTID"));
                order.setOrderDate(rs.getTimestamp("ORDERDATE"));
                order.setStatus(rs.getString("STATUS"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setPosCode(rs.getString("POSCODE"));
                order.setCity(rs.getString("CITY"));
                order.setState(rs.getString("STATE"));
                order.setTotal(rs.getDouble("TOTAL"));
                order.setShipping(rs.getString("SHIPPING"));

                // Get products for this order
                order.setProductsFromString(rs.getString("ITEMS"));
            }
        }
        catch (SQLException e) {
            throw e;
        }
        finally {
            if (rs != null)
                rs.close();
            if (stmt != null)
                stmt.close();
        }

        return order;
    }

    // Get a single order by orderId AND custId (for security)
    public Orders getOrderByCustOrderId(String orderId, String custId) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Orders order = null;

        try {
            // Get order details
            String sql = "SELECT * FROM " + tableName + " WHERE ORDERID = ? AND CUSTID = ? ORDER BY ORDERDATE DESC";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, orderId);
            stmt.setString(2, custId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Orders();
                order.setOrderId(rs.getString("ORDERID"));
                order.setCustId(rs.getString("CUSTID"));
                order.setOrderDate(rs.getTimestamp("ORDERDATE"));
                order.setStatus(rs.getString("STATUS"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setPosCode(rs.getString("POSCODE"));
                order.setCity(rs.getString("CITY"));
                order.setState(rs.getString("STATE"));
                order.setTotal(rs.getDouble("TOTAL"));
                order.setShipping(rs.getString("SHIPPING"));

                // Get products for this order
                order.setProductsFromString(rs.getString("ITEMS"));
            }
        } finally {
            if (rs != null)
                rs.close();
            if (stmt != null)
                stmt.close();
        }

        return order;
    }

    // get all orders
    public ArrayList<Orders> getAllOrder() throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Orders> ordersList = new ArrayList<>();

        try {
            // Get order details
            String sql = "SELECT * FROM " + tableName + " ORDER BY ORDERDATE DESC";
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderId(rs.getString("ORDERID"));
                order.setCustId(rs.getString("CUSTID"));
                order.setOrderDate(rs.getTimestamp("ORDERDATE"));
                order.setStatus(rs.getString("STATUS"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setPosCode(rs.getString("POSCODE"));
                order.setCity(rs.getString("CITY"));
                order.setState(rs.getString("STATE"));
                order.setTotal(rs.getDouble("TOTAL"));
                order.setShipping(rs.getString("SHIPPING"));

                // Get products for this order
                order.setProductsFromString(rs.getString("ITEMS"));
                
                ordersList.add(order);
            }
        } finally {
            if (rs != null)
                rs.close();
            if (stmt != null)
                stmt.close();
        }

        return ordersList;
    }

    // Get all orders for a customer
    public ArrayList<Orders> getCustomerOrders(String custId) throws SQLException, ClassNotFoundException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Orders> orders = new ArrayList<>();

        try {
            String sql = "SELECT * FROM " + tableName + " WHERE CUSTID = ? ORDER BY ORDERDATE DESC";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, custId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderId(rs.getString("ORDERID"));
                order.setCustId(rs.getString("CUSTID"));
                order.setOrderDate(rs.getTimestamp("ORDERDATE"));
                order.setStatus(rs.getString("STATUS"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setPosCode(rs.getString("POSCODE"));
                order.setCity(rs.getString("CITY"));
                order.setState(rs.getString("STATE"));
                order.setTotal(rs.getDouble("TOTAL"));
                order.setShipping(rs.getString("SHIPPING"));

                // Get products for this order
                order.setProductsFromString(rs.getString("ITEMS"));

                orders.add(order);
            }
        } finally {
            if (rs != null)
                rs.close();
            if (stmt != null)
                stmt.close();
        }

        return orders;
    }

    // Update order status
    public boolean updateOrderStatus(String orderId, String status) throws SQLException, ClassNotFoundException {
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            String sql = "UPDATE " + tableName + " SET STATUS = ? WHERE ORDERID = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setString(2, orderId);

            int rowsAffected = stmt.executeUpdate();
            success = (rowsAffected > 0);
        } finally {
            if (stmt != null)
                stmt.close();
        }

        return success;
    }

    // Create new order
    public boolean createOrder(Orders order) throws SQLException, ClassNotFoundException {
        PreparedStatement stmt = null;
        PreparedStatement itemStmt = null;
        boolean success = false;

        try {
            // Insert order
            String sql = "INSERT INTO " + tableName +
                    " (ORDERID, CUSTID, ORDERDATE, STATUS, ADDRESS, POSCODE, CITY, STATE, TOTAL, SHIPPING, ITEMS) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, order.getOrderId());
            stmt.setString(2, order.getCustId());
            stmt.setTimestamp(3, order.getOrderDate());
            stmt.setString(4, order.getStatus());
            stmt.setString(5, order.getAddress());
            stmt.setString(6, order.getPosCode());
            stmt.setString(7, order.getCity());
            stmt.setString(8, order.getState());
            stmt.setDouble(9, order.getTotal());
            stmt.setString(10, order.getShipping());
            stmt.setString(11, order.getItemsString());

            stmt.executeUpdate();
            
            success = true;
        } catch (SQLException e) {
            throw e;
        } finally {
            if (itemStmt != null)
                itemStmt.close();
            if (stmt != null)
                stmt.close();
        }

        return success;
    }

    public ArrayList<Orders> getOrdersByMonth(int month) throws SQLException, ClassNotFoundException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ArrayList<Orders> orders = new ArrayList<>();

        try {
            String sql = "SELECT * FROM " + tableName + " WHERE MONTH(ORDERDATE) = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, month);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Orders order = new Orders();
                order.setOrderId(rs.getString("ORDERID"));
                order.setCustId(rs.getString("CUSTID"));
                order.setOrderDate(rs.getTimestamp("ORDERDATE"));
                order.setStatus(rs.getString("STATUS"));
                order.setAddress(rs.getString("ADDRESS"));
                order.setPosCode(rs.getString("POSCODE"));
                order.setCity(rs.getString("CITY"));
                order.setState(rs.getString("STATE"));
                order.setTotal(rs.getDouble("TOTAL"));
                order.setShipping(rs.getString("SHIPPING"));
                
                order.setProductsFromString(rs.getString("ITEMS"));

                orders.add(order);
            }
        } finally {
            if (rs != null) 
                rs.close();
            if (stmt != null)
                stmt.close();
        }

        return orders;
    }

    // Optional: Method to close the connection
    public void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}