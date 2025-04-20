package domain;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import da.CartDA;
import model.Cart;

@WebServlet(name = "ViewCart", urlPatterns = {"/ViewCart"})
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String custId = (String) session.getAttribute("custID");
        
        // If user is not logged in, redirect to login page
        if (custId == null) {
            session.setAttribute("errorMessage", "Please login to view your cart");
            response.sendRedirect("LoginAndRegister.jsp");
            return;
        }

        try {
            CartDA da = new CartDA();
            List<Cart> cartList = da.getCartByCustomer(custId);
            
            // Store cart list in session
            session.setAttribute("cartList", cartList);
            
            // Redirect to ViewCart.jsp
            response.sendRedirect("ViewCart.jsp");
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error loading cart: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
    }
}
