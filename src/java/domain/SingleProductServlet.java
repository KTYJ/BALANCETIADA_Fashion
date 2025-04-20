package domain;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import da.ProductDA;
import model.Product;

@WebServlet(name = "SingleProduct", urlPatterns = {"/SingleProduct"})
public class SingleProductServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String sku = request.getParameter("sku");
        
        if (sku == null || sku.trim().isEmpty()) {
            response.sendRedirect("Products.jsp");
            return;
        }
        
        try {
            ProductDA productDA = new ProductDA();
            Product product = productDA.getProductBySku(sku);
            
            if (product != null) {
                // Store in session
                HttpSession session = request.getSession();
                session.setAttribute("product", product);
                
                // Forward to JSP
                RequestDispatcher dispatcher = request.getRequestDispatcher("single-product.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("Products.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect("Products.jsp");
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
