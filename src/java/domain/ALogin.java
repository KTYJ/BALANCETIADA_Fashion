/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import model.Staff;
import java.io.IOException;
import java.util.ArrayList;
import da.StaffDA;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import java.sql.SQLException;

//may need to delete ltr
import java.sql.*;

/**
 *
 * @author KTYJ
 */

@WebServlet("/ALogin")

public class ALogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        StaffDA staffDA = null;

        try {
            // Debug logging
            
            // Get form parameters
            String staffid = request.getParameter("id");
            String psw = request.getParameter("psw");
            
            //System.out.println("Staff ID received: " + (staffid != null ? staffid : "null"));
            //System.out.println("Password received: " + (psw != null ? "not null" : "null"));
            
            // Validate parameters
            if (staffid == null || staffid.trim().isEmpty() || psw == null || psw.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Please enter both ID and password");
                request.getRequestDispatcher("alogin.jsp").forward(request, response);
                return;
            }

            // Hash password
            String hashedPsw = null;
            try {
                hashedPsw = Toolkit.hashPsw(psw);
                System.out.println("Password hashed successfully");
            } catch (Exception e) {
                System.out.println("Error hashing password: " + e.getMessage());
                throw e;
            }

            // Create database connection
            try {
                staffDA = new StaffDA();
                System.out.println("Database connection established");
            } catch (SQLException e) {
                System.out.println("Database connection error: " + e.getMessage());
                throw e;
            }

            // Find staff
            Staff staff = null;
            try {
                staff = staffDA.findbyIdAndPassword(staffid, hashedPsw);
                System.out.println("Staff search completed. Result: " + (staff != null ? "found" : "not found"));
            } catch (SQLException e) {
                System.out.println("Error searching for staff: " + e.getMessage());
                throw e;
            }

            if (staff != null) {
                // Staff found, set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("staff", staff);
                
                // Close connection before redirect
                if (staffDA != null) {
                    staffDA.closeConnection();
                }
                
                response.sendRedirect("prodList.jsp");
            } else {
                request.setAttribute("errorMessage", "Invalid ID or password.");
                request.getRequestDispatcher("alogin.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            // Log the full exception details
            System.out.println("Error in login process:");
            ex.printStackTrace();
            
            // Send a user-friendly error message
            request.setAttribute("errorMessage", "System error occurred: " + ex.getMessage());
            request.getRequestDispatcher("alogin.jsp").forward(request, response);
        } finally {
            // Always close the connection in finally block
            if (staffDA != null) {
                staffDA.closeConnection();
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
