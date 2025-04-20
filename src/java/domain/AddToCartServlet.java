package domain;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import da.CartDA;
import model.Cart;

@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCartServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String custId = (String) session.getAttribute("custID");
        
        // If user is not logged in, redirect to login page
        if (custId == null) {
            session.setAttribute("errorMessage", "You need to LOG IN then Able to Add To CART!!!");
            response.sendRedirect("LoginAndRegister.jsp");
            return;
        }
        
        try {
            // Get parameters from the form
            String sku = request.getParameter("sku");
            String size = request.getParameter("size");
            int qty = Integer.parseInt(request.getParameter("quantity"));
            
            // First check if item already exists in cart
            CartDA cartDA = new CartDA();
            Cart existingItem = cartDA.checkExistingCartItem(custId, sku, size);
            
            String uid = cartDA.addToCart(custId, sku, size, qty);
            
            if (uid != null) {
                if (existingItem != null) {
                    // Item existed and quantity was updated
                    session.setAttribute("successMessage", 
                        String.format("This item was already in your cart. Quantity has been updated to %d", 
                            existingItem.getQty() + qty));
                } else {
                    // New item was added
                    session.setAttribute("successMessage", "Successfully added to cart!");
                }
                
                // Refresh cart list in session
                session.setAttribute("cartList", cartDA.getCartByCustomer(custId));
                response.sendRedirect("SingleProduct?sku=" + sku);
            } else {
                session.setAttribute("errorMessage", "Failed to add to cart. Please try again.");
                response.sendRedirect("SingleProduct?sku=" + sku);
            }
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("SingleProduct?sku=" + request.getParameter("sku"));
        }
    }
} 