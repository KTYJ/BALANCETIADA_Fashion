package domain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import da.ProductDA;
import model.Product;

@WebServlet(name = "GetProductSizes", urlPatterns = {"/GetProductSizes"})
public class GetProductSizesServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sku = request.getParameter("sku");
        
        if (sku == null || sku.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "SKU is required");
            return;
        }
        
        try {
            ProductDA productDA = new ProductDA();
            Product product = productDA.getProductBySku(sku);
            
            if (product != null) {
                // Get the sizes string from the product
                String sizes = product.getSize();
                response.getWriter().write(sizes);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching product sizes");
        }
    }
} 