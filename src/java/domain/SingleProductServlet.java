package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import da.ProductDA;
import model.Product;

@WebServlet("/single-product")
public class SingleProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String sku = request.getParameter("sku");
        
        ProductDA productDA = new ProductDA();
        Product product = productDA.getProductBySku(sku);

        request.setAttribute("product", product);
        request.getRequestDispatcher("single-product.jsp").forward(request, response);
    }
}
