/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import java.sql.*;
import da.StaffDA;
import model.Staff;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author KTYJ
 */
@WebServlet(name = "AddStaffServlet", urlPatterns = {"/AddStaffServlet"})
public class AddStaffServlet extends HttpServlet {
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

                    try {
                        String staffid = request.getParameter("staffid");
                        String name = request.getParameter("name");
                        String email = request.getParameter("email");
                        String psw = request.getParameter("psw");
                        
                        //String type = request.getParameter("type");
                        

                        if (staffid == null || name == null || email == null || psw == null) {
                            throw new SQLException("Missing required parameters");
                        }

                        Staff staff = new Staff(staffid, name, email, psw, "staff");

                        StaffDA staffDA = new StaffDA();
                        staffDA.addStaff(staff);

                        request.setAttribute("successMessage", "Staff ID: " + staffid + " added successfully. <br><normal>Hint: Default password same with ID :)</normal>");
                        request.getRequestDispatcher("staffRes.jsp").forward(request, response); // Forward back to addProdRes.jsp
                        
                    } catch (SQLException e) {


                        request.setAttribute("errorMessage", "INTERNAL ERROR: " + e.getMessage());
                        request.getRequestDispatcher("staffRes.jsp").forward(request, response); // Forward back to addProdRes.jsp
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
