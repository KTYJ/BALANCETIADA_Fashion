package domain;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import da.CartDA;
import model.Cart;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String custId = request.getParameter("custid");

        CartDA da = new CartDA();
        List<Cart> cartList = da.getCartByCustomer(custId);

        request.setAttribute("cartList", cartList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewCart.jsp");
        dispatcher.forward(request, response);
    }
}
