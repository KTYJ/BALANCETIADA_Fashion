<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Orders"%>
<%@page import="model.Product"%>
<%@page import="da.OrdersDA"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%-- 
    Document   : viewOrder2
    (Iframe)
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%!
            // Helper method to get status text
            public String getStatusText(String status) {
                if (status == null) return "Unknown";
                switch (status.toLowerCase()) {
                    case "packaging": return "Packaging";
                    case "shipping": return "Shipping";
                    case "delivery": return "Out for delivery";
                    case "completed": return "Completed";
                    default: return "   ";
                }
            }
            
            // Helper method to get status badge color
            public String getStatusBadgeColor(String status) {
                if (status == null) return "bg-secondary";
                switch (status) {
                    case "1": return "bg-info";
                    case "2": return "bg-primary";
                    case "3": return "bg-warning";
                    case "4": return "bg-success";
                    default: return "bg-secondary";
                }
            }

            // Helper method to get shipping fee
            public double getShippingFee(String shippingMethod) {
                if (shippingMethod == null) return 0.0;
                switch (shippingMethod.toLowerCase()) {
                    case "standard": return 25.0;
                    case "express": return 35.0;
                    case "free shipping": return 0.0;
                    default: return 0.0;
                }
            }
        %>
        <%
            // Get orderId from request parameter
            String orderId = request.getParameter("orderId");
            Orders order = null;
            
            if (orderId != null && !orderId.isEmpty()) {
                try {
                    OrdersDA ordersDA = new OrdersDA();
                    order = ordersDA.getOrderByOrderId(orderId);
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            }
            
            if (order != null) {
                // Calculate subtotal and shipping fee
                double subtotal = 0.0;
                ArrayList<Product> products = order.getProducts();
                if (products != null) {
                    for (Product product : products) {
                        subtotal += product.getPrice() * product.getStock()[0];
                    }
                }
                double shippingFee = getShippingFee(order.getShipping());
                double total = subtotal + shippingFee;
        %>
        <div class="container mt-5">
            <h2>Order Details</h2>
            
            <!-- Order Header Information -->
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Order #<%=order.getOrderId()%></h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Order Date:</strong> <%=Orders.timeStampToStr(order.getOrderDate())%></p>
                            <p><strong>Status:</strong> 
                                <span class="badge <%=getStatusBadgeColor(order.getStatus())%>">
                                    <%=order.getStatus()%>
                                </span>
                            </p>
                            <p><strong>Customer ID:</strong> <%=order.getCustId()%></p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Shipping Method:</strong> <%=order.getShipping().substring(0, 1).toUpperCase() + order.getShipping().substring(1)%></p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Shipping Address -->
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Shipping Address</h4>
                </div>
                <div class="card-body">
                    <p><%=order.getAddress()%></p>
                    <p><%=order.getCity()%>, <%=order.getState()%> <%=order.getPosCode()%></p>
                </div>
            </div>
            
            <!-- Order Items -->
            <div class="card mb-4">
                <div class="card-header">
                    <h4>Order Items</h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>SKU</th>
                                    <th>Size</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (products != null) {
                                        for (Product product : products) {
                                            double itemSubtotal = product.getPrice() * product.getStock()[0];
                                %>
                                <tr>
                                    <td><%=product.getName()%></td>
                                    <td><%=product.getSku()%></td>
                                    <td><%=product.getSize()[0]%></td>
                                    <td>RM <%=String.format("%.2f", product.getPrice())%></td>
                                    <td><%=product.getStock()[0]%></td>
                                    <td>RM <%=String.format("%.2f", itemSubtotal)%></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="5" class="text-end"><strong>Subtotal:</strong></td>
                                    <td><strong>RM <%=String.format("%.2f", subtotal)%></strong></td>
                                </tr>
                                <tr>
                                    <td colspan="5" class="text-end"><strong>Shipping Fee (<%=order.getShipping()%>):</strong></td>
                                    <td><strong>RM <%=String.format("%.2f", shippingFee)%></strong></td>
                                </tr>
                                <tr class="table-primary">
                                    <td colspan="5" class="text-end"><strong>Total:</strong></td>
                                    <td><strong>RM <%=String.format("%.2f", total)%></strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Back Button 
            <div class="mb-4">
                <a href="javascript:history.back()" class="btn btn-secondary">Back</a>
            </div>-->
        </div>
        <%
            } else {
        %>
        <div class="container mt-5">
            <div class="alert alert-danger" role="alert">
                Order not found or invalid order ID provided.
            </div>
            <!--<a href="javascript:history.back()" class="btn btn-secondary">Back</a>-->
        </div>
        <%
            }
        %>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
