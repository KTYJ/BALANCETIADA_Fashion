package domain;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/UpdateProfileServlet"})
public class UpdateProfileServlet extends HttpServlet {

    private static final String NAME_PATTERN = "^[A-Za-z]{2,30}$";
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@(.+)$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        String custID = request.getParameter("id");
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate inputs
        List<String> errors = new ArrayList<>();
        
        if (firstName == null || !Pattern.matches(NAME_PATTERN, firstName.trim())) {
            errors.add("First name must be 1-50 characters long and contain only letters");
        }
        
        if (lastName == null || !Pattern.matches(NAME_PATTERN, lastName.trim())) {
            errors.add("Last name must be 1-50 characters long and contain only letters");
        }
        
        if (email == null || !Pattern.matches(EMAIL_PATTERN, email.trim())) {
            errors.add("Please enter a valid email address");
        }
        
        // If there are validation errors, return to form with error messages
        if (!errors.isEmpty()) {
            String errorMessage = String.join("<br>", errors);
            request.setAttribute("message", errorMessage);
            request.getRequestDispatcher("editprofile.jsp").forward(request, response);
            return;
        }
        
        // Hash the password using Toolkit
        String hashedPassword = Toolkit.hashPsw(password);
        
        // Database connection details
        String url = "jdbc:derby://localhost:1527/btdb";
        String dbUser = "nbuser";
        String dbPass = "nbuser";
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(url, dbUser, dbPass);
            
            // First verify the password
            String verifyPassword = "SELECT COUNT(*) FROM CUSTOMER WHERE CUSTID = ? AND PSW = ?";
            stmt = conn.prepareStatement(verifyPassword);
            stmt.setString(1, custID);
            stmt.setString(2, hashedPassword);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                request.setAttribute("message", "Incorrect password. Please try again.");
                request.getRequestDispatcher("editprofile.jsp").forward(request, response);
                return;
            }
            rs.close();
            
            // Check if email already exists for another user
            String checkEmail = "SELECT COUNT(*) FROM CUSTOMER WHERE EMAIL = ? AND CUSTID != ?";
            stmt = conn.prepareStatement(checkEmail);
            stmt.setString(1, email.trim());
            stmt.setString(2, custID);
            
            ResultSet rs2 = stmt.executeQuery();
            if (rs2.next() && rs2.getInt(1) > 0) {
                request.setAttribute("message", "Email address is already in use by another account");
                request.getRequestDispatcher("editprofile.jsp").forward(request, response);
                return;
            }
            rs2.close();
            
            // Proceed with update if email is unique
            String sql = "UPDATE CUSTOMER SET FNAME=?, LNAME=?, EMAIL=? WHERE CUSTID=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, firstName.trim());
            stmt.setString(2, lastName.trim());
            stmt.setString(3, email.trim());
            stmt.setString(4, custID);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Update session with new values
                session.setAttribute("firstName", firstName.trim());
                session.setAttribute("lastName", lastName.trim());
                session.setAttribute("email", email.trim());
                
                // Set success message and redirect to myprofile.jsp
                session.setAttribute("message", "Profile updated successfully!");
                response.sendRedirect("myprofile.jsp");
                return;
            } else {
                request.setAttribute("message", "Failed to update profile. Please try again.");
                request.getRequestDispatcher("editprofile.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("editprofile.jsp").forward(request, response);
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("myprofile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
} 