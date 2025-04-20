package domain;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Get the session
        HttpSession session = request.getSession(false); // Don't create new session if none exists
        
        if (session != null) {
            // Clear all session attributes
            session.removeAttribute("loggedInUser");
            session.removeAttribute("firstName");
            session.removeAttribute("lastName");
            session.removeAttribute("email");
            session.removeAttribute("custID");
            session.removeAttribute("isLoggedIn");
            
            // Invalidate the session
            session.invalidate();
        }
        
        // Set a message for the login page
        request.getSession().setAttribute("successMessage", "You have been successfully logged out.");
        
        // Redirect to login page
        response.sendRedirect("LoginAndRegister.jsp");
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
} 