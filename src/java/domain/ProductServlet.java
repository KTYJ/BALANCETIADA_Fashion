package domain;

import da.ProductDA;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.*;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDA productDA;

    @Override
    public void init() throws ServletException {
        productDA = new ProductDA();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, List<Product>> productMap = new HashMap<>();
        productMap.put("trending", productDA.getProductsByCategory(1));
        productMap.put("women", productDA.getProductsByCategory(2));
        productMap.put("men", productDA.getProductsByCategory(3));
        productMap.put("kids", productDA.getProductsByCategory(4));

        request.setAttribute("productMap", productMap);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Products.jsp");
        dispatcher.forward(request, response);
    }
}
