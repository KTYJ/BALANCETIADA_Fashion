package domain;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import da.CartDA;
import da.ProductDA;
import model.Cart;
import model.Product;

@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/updateCartItem"})
public class UpdateCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String custId = (String) session.getAttribute("custID");
        
        try {
            String uid = request.getParameter("uid");
            String sku = request.getParameter("sku");
            String size = request.getParameter("size");
            int qty = Integer.parseInt(request.getParameter("qty"));

            if (uid == null || sku == null || size == null || qty < 1) {
                session.setAttribute("errorMessage", "Invalid parameters provided");
                response.sendRedirect("ViewCart.jsp");
                return;
            }

            CartDA da = new CartDA();
            
            // Check for duplicates when changing size
            Cart currentItem = da.checkExistingCartItem(custId, sku, size);
            if (currentItem != null && !currentItem.getUid().equals(uid)) {
                ProductDA productDA = new ProductDA();
                Product product = productDA.getProductBySku(sku);
                session.setAttribute("errorMessage", 
                    "Cannot update: An item with Product " + product.getName() + " and size " + size + " already exists in your cart!");
                response.sendRedirect("ViewCart.jsp");
                return;
            }

            // First validate the size against product's available sizes
            ProductDA productDA = new ProductDA();
            Product product = productDA.getProductBySku(sku);
            
            if (product == null) {
                session.setAttribute("errorMessage", "Product not found");
                response.sendRedirect("ViewCart.jsp");
                return;
            }

            String[] availableSizes = product.getSize().split("\\|");
            boolean isValidSize = false;
            
            for (String validSize : availableSizes) {
                if (validSize.trim().equals(size.trim())) {
                    isValidSize = true;
                    break;
                }
            }
            
            if (!isValidSize) {
                session.setAttribute("errorMessage", "Invalid size selected");
                response.sendRedirect("ViewCart.jsp");
                return;
            }
            
            // If size is valid and no duplicates, update the cart
            Cart cart = new Cart();
            cart.setUid(uid);
            cart.setSize(size);
            cart.setQty(qty);

            boolean updateSuccess = da.updateCartItem(cart);
            
            if (!updateSuccess) {
                session.setAttribute("errorMessage", "Failed to update cart item");
                response.sendRedirect("ViewCart.jsp");
                return;
            }
            
            // Refresh the cart list in session
            if (custId != null) {
                session.setAttribute("cartList", da.getCartByCustomer(custId));
                session.setAttribute("successMessage", "Cart item updated successfully");
            }
            
            response.sendRedirect("ViewCart.jsp");
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Invalid quantity value");
            response.sendRedirect("ViewCart.jsp");
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error updating cart: " + e.getMessage());
            response.sendRedirect("ViewCart.jsp");
        }
    }
}
