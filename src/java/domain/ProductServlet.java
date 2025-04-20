package domain;

import da.ProductDA;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {
    private ProductDA productDA;

    @Override
    public void init() throws ServletException {
        productDA = new ProductDA();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        
        try {
            Map<String, List<Product>> productMap = new HashMap<>();
            productMap.put("trending", productDA.getProductsByCategory(1));
            productMap.put("women", productDA.getProductsByCategory(2));
            productMap.put("men", productDA.getProductsByCategory(3));
            productMap.put("kids", productDA.getProductsByCategory(4));
            
            // Store in session for future use
            session.setAttribute("productMap", productMap);
            
            // Redirect to Products.jsp instead of forwarding
            response.sendRedirect("Products.jsp");
            
        } catch (Exception e) {
            session.setAttribute("errorMessage", "Error loading products: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }
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
