/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package da;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Staff;

/**
 *
 * @author KTYJ
 */
public class StaffDA {

    private Connection connection;
    private PreparedStatement stmt;

    // Database connection details
    private String host = "jdbc:derby://localhost:1527/btdb";
    private String user = "nbuser";
    private String password = "nbuser";

    public StaffDA() throws SQLException {
        createConnection();
    }

    private void createConnection() throws SQLException {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection(host, user, password);
        } catch (ClassNotFoundException ex) {
            throw new SQLException("Database driver not found: " + ex.getMessage());
        } catch (SQLException ex) {
            throw new SQLException("Failed to connect to database: " + ex.getMessage());
        }
    }

    public Staff findById(String staffId) throws SQLException {
        String queryStr = "SELECT * FROM STAFF WHERE staffid = ?";
        Staff staff = null;
        stmt = connection.prepareStatement(queryStr);
        stmt.setString(1, staffId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            staff = new Staff();
            staff.setStaffid(rs.getString("staffid"));
            staff.setName(rs.getString("name"));
            staff.setPsw(rs.getString("psw"));
            staff.setEmail(rs.getString("email"));
            staff.setType(rs.getString("type"));
        }

        return staff;
    }
    public Staff findByEmail(String email) throws SQLException {
        String queryStr = "SELECT * FROM STAFF WHERE email = ?";
        Staff staff = null;
        stmt = connection.prepareStatement(queryStr);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            staff = new Staff();
            staff.setStaffid(rs.getString("staffid"));
            staff.setName(rs.getString("name"));
            staff.setEmail(rs.getString("email"));
            staff.setType(rs.getString("type"));
        }

        return staff;
    }

    public Staff findbyEmailAndPassword(String email, String password) throws SQLException {
        String queryStr = "SELECT * FROM STAFF WHERE email = ? AND psw = ?";
        Staff staff = null;

        stmt = connection.prepareStatement(queryStr);
        stmt.setString(1, email);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            staff = new Staff();
            staff.setStaffid(rs.getString("staffid"));
            staff.setName(rs.getString("name"));
            staff.setPsw(rs.getString("psw"));
            staff.setEmail(rs.getString("email"));
            staff.setType(rs.getString("type"));
        }

        return staff;
    }

    public Staff findbyIdAndPassword(String id, String password) throws SQLException {
        String queryStr = "SELECT * FROM STAFF WHERE staffid = ? AND psw = ?";
        Staff staff = null;

        stmt = connection.prepareStatement(queryStr);
        stmt.setString(1, id);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            staff = new Staff();
            staff.setStaffid(rs.getString("staffid"));
            staff.setPsw(rs.getString("psw"));
            staff.setName(rs.getString("name"));
            staff.setEmail(rs.getString("email"));
            staff.setType(rs.getString("type"));
        }

        return staff;
    }

    public List<Staff> findAllStaff() throws SQLException {
        String queryStr = "SELECT * FROM STAFF";
        List<Staff> staffList = new ArrayList<>();

        stmt = connection.prepareStatement(queryStr);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Staff staff = new Staff();
            staff.setStaffid(rs.getString("staffid"));
            staff.setName(rs.getString("name"));
            staff.setEmail(rs.getString("email"));
            staff.setType(rs.getString("type"));
            staffList.add(staff);
        }

        return staffList;
    }

    //search staff
    public ArrayList<Staff> srcStaff(String search) throws SQLException {
        String sql = "SELECT * FROM NBUSER.STAFF WHERE lower(name) LIKE ? OR lower(email) LIKE ? OR lower(staffid) LIKE ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + search + "%");
            stmt.setString(2, "%" + search + "%");
            stmt.setString(3, "%" + search + "%");
            
            ResultSet rs = stmt.executeQuery();
            ArrayList<Staff> staffList = new ArrayList<>();
            while (rs.next()) {
                Staff staff = new Staff();
                staff.setStaffid(rs.getString("staffid"));
                staff.setName(rs.getString("name"));
                staff.setEmail(rs.getString("email"));
                staff.setType(rs.getString("type"));
                staffList.add(staff);
            }
            return staffList;
        }
    }

    public List<Staff> findAllStaff(String type) throws SQLException {
        String queryStr = "SELECT * FROM STAFF WHERE type = ?";
        List<Staff> staffList = new ArrayList<>();
        stmt = connection.prepareStatement(queryStr);
        stmt.setString(1, type);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Staff staff = new Staff();
            staff.setStaffid(rs.getString("staffid"));
            staff.setName(rs.getString("name"));
            staff.setEmail(rs.getString("email"));
            staff.setType(rs.getString("type"));
            staffList.add(staff);
        }

        return staffList;
    }

    public void addStaff(Staff staff) throws SQLException {
        String insertStr = "INSERT INTO STAFF (staffid, name, email, psw, type) VALUES (?, ?, ?, ?, ?)";
        stmt = connection.prepareStatement(insertStr);
        stmt.setString(1, staff.getStaffid());
        stmt.setString(2, staff.getName());
        stmt.setString(3, staff.getEmail());
        stmt.setString(4, staff.getPsw());
        stmt.setString(5, staff.getType());
        stmt.executeUpdate();
    }

    public void updateStaff(Staff staff) throws SQLException {
        String updateStr = "UPDATE STAFF SET name = ?, email = ?, type = ?, psw = ? WHERE staffid = ?";

        stmt = connection.prepareStatement(updateStr);
        stmt.setString(1, staff.getName());
        stmt.setString(2, staff.getEmail());
        stmt.setString(3, staff.getType());
        stmt.setString(4, staff.getPsw());
        stmt.setString(5, staff.getStaffid());
        stmt.executeUpdate();
    }

    public void deleteStaff(String staffId) throws SQLException {
        String deleteStr = "DELETE FROM STAFF WHERE staffid = ?";
        try {
            stmt = connection.prepareStatement(deleteStr);
            stmt.setString(1, staffId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void closeConnection() {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
