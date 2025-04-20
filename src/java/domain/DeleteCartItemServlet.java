package domain;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import da.CartDA;

@WebServlet(name = "DeleteCartItem", urlPatterns = {"/deleteCartItem"})
public class DeleteCartItemServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String custId = (String) session.getAttribute("custID");
        
        if (custId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }
        
        try {
            String uid = request.getParameter("uid");
            
            if (uid == null || uid.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid item ID");
                return;
            }
            
            CartDA cartDA = new CartDA();
            boolean success = cartDA.deleteCartItem(uid);
            
            if (success) {
                // Update cart list in session
                session.setAttribute("cartList", cartDA.getCartByCustomer(custId));
                session.setAttribute("successMessage", "Item successfully removed from cart");
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("success");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Failed to delete item");
            }
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
} 