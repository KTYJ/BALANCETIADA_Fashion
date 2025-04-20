package domain;

import model.Customer;
import model.Staff;
import da.CustomerDA;
import da.StaffDA;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Clear any existing session
        HttpSession session = request.getSession();
        session.invalidate();
        session = request.getSession(true);
        
        String email = request.getParameter("logemail");
        String password = request.getParameter("logpass");
        
        // Basic validation
        if (email == null || password == null || 
            email.trim().isEmpty() || password.trim().isEmpty()) {
            session.setAttribute("errorMessage", "Email and password are required");
            response.sendRedirect("LoginAndRegister.jsp");
            return;
        }
        
        try {
            // First check if it's a staff login attempt
            StaffDA staffDA = new StaffDA();
            Staff staff = staffDA.findById(email);
            
            if (staff != null && email.equals(password)) {
                // Staff login successful - password matches the ID
                session.setAttribute("loggedInStaff", staff);
                session.setAttribute("staffId", staff.getStaffid());
                session.setAttribute("staffName", staff.getName());
                session.setAttribute("staffEmail", staff.getEmail());
                session.setAttribute("staffType", staff.getType());
                session.setAttribute("isStaffLoggedIn", true);
                
                // Set welcome message
                session.setAttribute("successMessage", "Welcome back, " + staff.getName() + "!");
                
                // Redirect to admin page
                response.sendRedirect("alogin.jsp");
                return;
            }
            
            // If not a staff, try customer login
            CustomerDA customerDA = new CustomerDA();
            Customer customer = CustomerDA.validateLogin(email, password);
            
            if (customer != null) {
                // Store all necessary user information in session
                session.setAttribute("loggedInUser", customer);
                session.setAttribute("firstName", customer.getFirstName());
                session.setAttribute("lastName", customer.getLastName());
                session.setAttribute("email", customer.getEmail());
                session.setAttribute("custID", customer.getCustID());
                session.setAttribute("isLoggedIn", true);
                
                // Set welcome message
                session.setAttribute("successMessage", "Welcome back, " + customer.getFirstName() + "!");
                
                // Set session timeout (30 minutes)
                session.setMaxInactiveInterval(30 * 60);
                
                // Redirect to welcome page
                response.sendRedirect("welcome.jsp");
            } else {
                // Invalid login
                session.setAttribute("errorMessage", "Invalid email or password");
                response.sendRedirect("LoginAndRegister.jsp");
            }
            
        } catch (SQLException e) {
            session.setAttribute("errorMessage", "Database error: " + e.getMessage());
            response.sendRedirect("LoginAndRegister.jsp");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
} 