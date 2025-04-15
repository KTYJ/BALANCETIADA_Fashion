package domain;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import da.CartDA;
import model.Cart;

@WebServlet("/updateCartItem")
public class UpdateCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uid = request.getParameter("uid");
        String size = request.getParameter("size");
        int qty = Integer.parseInt(request.getParameter("qty"));

        CartDA da = new CartDA();
        Cart cart = new Cart();
        cart.setUid(uid);
        cart.setSize(size);
        cart.setQty(qty);

        da.updateCartItem(cart);

        response.sendRedirect("cart?custid=" + request.getParameter("custid"));
    }
}
