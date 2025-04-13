/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// import your Toolkit
import domain.Toolkit.*;

/**
 *
 * @author KTYJ
 */
@WebServlet("/Add-Staff")

public class AddStaff extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("psw");
        
        // Validate inputs
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required");
            return;
        }
        
        try {
            // Hash the password (using BCrypt as recommended)
            String hashedPassword = Toolkit.hashPsw(password);
            
            // Save to database (pseudo-code)
            //Staff staff = new Staff(name, email, hashedPassword);
            //staffDao.save(staff);
            
            // Redirect to success page
            response.sendRedirect("staff-added-success.html");
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }
}
