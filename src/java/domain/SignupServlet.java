/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import model.Customer;
import da.CustomerDA;
import java.sql.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author User
 */
@WebServlet(name = "SignupServlet", urlPatterns = {"/SignupServlet"})
public class SignupServlet extends HttpServlet {

    private static final String NAME_PATTERN = "^[A-Za-z]{2,30}$";
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final int MIN_PASSWORD_LENGTH = 6;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Clear any existing session
        HttpSession session = request.getSession();
        session.invalidate();
        session = request.getSession(true);
        
        try {
            // Get form parameters
            String firstName = request.getParameter("firstname");
            String lastName = request.getParameter("lastname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmpassword");

            // Validate inputs
            List<String> errors = new ArrayList<>();
            
            // Validate First Name
            if (firstName == null || firstName.trim().isEmpty()) {
                errors.add("First name is required");
            } else if (!Pattern.matches(NAME_PATTERN, firstName.trim())) {
                errors.add("First name must be 2-30 characters long and contain only letters");
            }
            
            // Validate Last Name
            if (lastName == null || lastName.trim().isEmpty()) {
                errors.add("Last name is required");
            } else if (!Pattern.matches(NAME_PATTERN, lastName.trim())) {
                errors.add("Last name must be 2-30 characters long and contain only letters");
            }
            
            // Validate Email
            if (email == null || email.trim().isEmpty()) {
                errors.add("Email is required");
            } else if (!Pattern.matches(EMAIL_PATTERN, email.trim())) {
                errors.add("Please enter a valid email address");
            }
            
            // Validate Password
            if (password == null || password.trim().isEmpty()) {
                errors.add("Password is required");
            } else if (password.trim().length() < MIN_PASSWORD_LENGTH) {
                errors.add("Password must be at least " + MIN_PASSWORD_LENGTH + " characters long");
            }
            
            // Validate Confirm Password
            if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
                errors.add("Please confirm your password");
            } else if (!password.equals(confirmPassword)) {
                errors.add("Passwords do not match");
            }

            // If there are validation errors, return to form with error messages
            if (!errors.isEmpty()) {
                session.setAttribute("errorMessage", String.join("<br>", errors));
                response.sendRedirect("LoginAndRegister.jsp");
                return;
            }

            // Check if email already exists
            CustomerDA customerDA = new CustomerDA();
            if (CustomerDA.isEmailExists(email.trim())) {
                session.setAttribute("errorMessage", "Email address is already registered");
                response.sendRedirect("LoginAndRegister.jsp");
                return;
            }

            // Hash the password using Toolkit
            String hashedPassword = Toolkit.hashPsw(password);

            // Create a new customer (custID will be generated in CustomerDA)
            Customer customer = new Customer(null, firstName.trim(), lastName.trim(), email.trim(), hashedPassword);

            // Add the customer to the database
            CustomerDA.addCustomer(customer);

            // Set success message and redirect to login page
            session.setAttribute("showSuccessPopup", true);
            session.setAttribute("successMessage", "Account created successfully! Please login to continue.");
            response.sendRedirect("LoginAndRegister.jsp");

        } catch (SQLException e) {
            session.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            response.sendRedirect("LoginAndRegister.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
