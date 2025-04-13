/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package domain;

import model.Staff;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;


//may need to delete ltr
import java.sql.*;

/**
 *
 * @author KTYJ
 */
public class ALogin extends HttpServlet {

    private Connection con;
    private String query;
    private PreparedStatement stmt;
    private ResultSet rs;

    private void createCon() {
        try {
            con = DriverManager.getConnection("jdbc:derby://localhost:1527/btdb", "nbuser", "nbuser");
        } catch (SQLException ex) {
            System.out.print(ex.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        createCon();

        String staffid = request.getParameter("id");
        String psw = request.getParameter("psw");
        String hashedPsw = Toolkit.hashPsw(psw);

        Staff staff = new Staff(staffid, hashedPsw);
        try {
            stmt = con.prepareStatement("SELECT * FROM NBUSER.STAFF WHERE staffid = ? AND psw = ?"); 
            
            
            stmt.setString(1, staff.getStaffid());
            stmt.setString(2, staff.getPsw());
            rs = stmt.executeQuery();

            if (rs.next()) {

                String name = rs.getString("name");
                String type = rs.getString("type");
                String email = rs.getString("email");

                staff.setName(name);
                staff.setType(type);
                staff.setEmail(email);
                    
                request.setAttribute("staff", staff);

                //redirect to custList.jsp, but it's not working yet!
                RequestDispatcher dispatcher = request.getRequestDispatcher("custList.html");
                dispatcher.forward(request, response);
                
                
                

                
            } else {                // Credentials invalid, show error message
                request.setAttribute("errorMessage", "LOGIN FAILED, CHECK YOUR INFO.");
                request.getRequestDispatcher("alogin.jsp").forward(request, response); // Forward back to login page
            }

        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "INTERNAL ERROR: " + ex.getMessage());
            request.getRequestDispatcher("alogin.jsp").forward(request, response); // Forward back to login page
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
