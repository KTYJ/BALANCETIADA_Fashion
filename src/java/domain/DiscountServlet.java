package domain;

import da.DiscountDA;   // //NEW
import model.Discount;  // NEW

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet(name = "DiscountServlet", urlPatterns = {"/DiscountServlet"})
public class DiscountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            DiscountDA da = new DiscountDA();
            List<Discount> codes = da.getAllDiscount();
            
            if (codes == null) {
                codes = new ArrayList<>();  // Initialize to empty list if null
            }
            
            request.setAttribute("voucherList", codes);
            RequestDispatcher dispatcher = request.getRequestDispatcher("voucher.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            // Log the error
            e.printStackTrace();
            // Forward to an error page or send error response
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching discount codes");
        }
    }
}
