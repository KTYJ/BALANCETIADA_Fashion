<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Orders"%>
<%@page import="model.Product"%>
<%@page import="da.OrdersDA"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="model.Staff" %>
<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- icons -->
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- font css link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
        <!-- style css -->
        <link rel="stylesheet" type="text/css" href="css/orderDetail.css">

        <style>
            .dropdown-menu {
                display: none;
                position: absolute;
                background-color: #fff;
                min-width: 160px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
                z-index: 1000;
                border-radius: 4px;
            }

            .dropdown-menu.show {
                display: block;
            }

            .dropdown-menu li {
                padding: 16px;
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .dropdown-menu li a {
                color: #000000;
                text-decoration: none;
                display: block;
                text-align: left;
                padding: 16px;
                margin: 0;
                padding: 0;
            }

            .dropdown-menu li:hover {
                background-color: #000000;
            }

            .dropdown-menu li:hover a {
                color: #ffffff;
            }

            .dropdown-toggle {
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .dropdown-toggle i {
                margin-right: 5px;
            }

            .login_btn .dropdown > a {
                display: flex;
                align-items: center;
                white-space: nowrap;
            }
        </style>

        <script>
            // Dropdown functionality
            document.addEventListener('DOMContentLoaded', function() {
                const dropdownToggle = document.querySelector('.dropdown-toggle');
                const dropdownMenu = document.querySelector('.dropdown-menu');
                
                if (dropdownToggle && dropdownMenu) {
                    // Toggle dropdown on click
                    dropdownToggle.addEventListener('click', function(e) {
                        e.preventDefault();
                        dropdownMenu.classList.toggle('show');
                    });
    
                    // Close dropdown when clicking outside
                    document.addEventListener('click', function(e) {
                        if (!dropdownToggle.contains(e.target) && !dropdownMenu.contains(e.target)) {
                            dropdownMenu.classList.remove('show');
                        }
                    });
                }
            });
            
            // Logout confirmation
            function confirmLogout() {
                return confirm("Are you sure you want to logout?");
            }
            
            // Form validation
            function validateForm() {
                let isValid = true;
                
                // Get form elements
                const firstName = document.getElementById('firstName');
                const lastName = document.getElementById('lastName');
                const email = document.getElementById('email');
                const password = document.getElementById('password');
                
                // Clear previous errors
                clearErrors();
                
                // Validate First Name
                if (!firstName.value.match(/^[A-Za-z]{1,50}$/)) {
                    showError(firstName, 'First name must contain only letters and be 1-50 characters long');
                    isValid = false;
                }
                
                // Validate Last Name
                if (!lastName.value.match(/^[A-Za-z]{1,50}$/)) {
                    showError(lastName, 'Last name must contain only letters and be 1-50 characters long');
                    isValid = false;
                }
                
                // Validate Email
                if (!email.value.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
                    showError(email, 'Please enter a valid email address');
                    isValid = false;
                }
                
                // Validate Password
                if (!password.value.trim()) {
                    showError(password, 'Please enter your password to confirm changes');
                    isValid = false;
                }
                
                if (isValid) {
                    return confirm('Are you sure you want to update your profile?');
                }
                
                return false;
            }
            
            function showError(input, message) {
                input.classList.add('invalid');
                
                // Create error element if it doesn't exist
                let error = input.nextElementSibling;
                if (!error || !error.classList.contains('form-error')) {
                    error = document.createElement('div');
                    error.className = 'form-error';
                    input.parentNode.insertBefore(error, input.nextSibling);
                }
                
                error.textContent = message;
                error.style.display = 'block';
            }
            
            function clearErrors() {
                // Remove all error messages and invalid classes
                document.querySelectorAll('.form-error').forEach(error => error.style.display = 'none');
                document.querySelectorAll('.invalid').forEach(input => input.classList.remove('invalid'));
            }
        </script>

        <style>
            .dropdown-menu {
                    display: none;
                    position: absolute;
                    background-color: #fff;
                    min-width: 160px;
                    box-shadow: 0 8px 16px rgba(0,0,0,0.1);
                    z-index: 1000;
                    border-radius: 4px;
                }
                
                .dropdown-menu.show {
                    display: block;
                }
                
                .dropdown-menu li {
                    padding: 16px;
                    list-style: none;
                    padding: 0;
                    margin: 0;
                }
                
                .dropdown-menu li a {
                    color: #000000;
                    text-decoration: none;
                    display: block;
                    text-align: left;
                    padding: 16px;
                    margin: 0;
                    padding: 0;
                }

                .dropdown-menu li:hover {
                    background-color: #000000;
                }

                .dropdown-menu li:hover a {
                    color: #ffffff;
                }

                .dropdown-toggle {
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    gap: 5px;
                }

                .dropdown-toggle i {
                    margin-right: 5px;
                }

                .login_btn .dropdown > a {
                    display: flex;
                    align-items: center;
                    white-space: nowrap;
                }
        </style>
    </head>
    <body>
        <!-- ** Header Area Start ** -->
        <%!
            // Helper method to get status text
            public String getStatusText(String status) {
                if (status == null) return "Unknown";
                switch (status) {
                    case "1": return "Packaging";
                    case "2": return "Shipping";
                    case "3": return "Out for delivery";
                    case "4": return "Delivered";
                    default: return "Unknown";
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
                ArrayList<Product> products = order.getProducts();
                double productTotal = 0.0;
                if (products != null) {
                    for (Product product : products) {
                        productTotal += product.getPrice() * product.getStock()[0];
                    }
                }
                double shippingFee = getShippingFee(order.getShipping());
                double tax = productTotal * 0.06;
                double subtotal = productTotal + tax + shippingFee;
                double discount = subtotal - order.getTotal();
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
                                    <%= getStatusText(order.getStatus())%>
                                </span>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Shipping Method:</strong> <%=order.getShipping().toUpperCase()%></p>
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
                    <p><%=order.getAddress()%>,</p>
                    <p><%=order.getPosCode()%> <%=order.getCity()%>,</p>
                    <p><%=order.getState()%></p>
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
                                    <th>SKU</th>
                                    <th style="width:50%;">Product</th>
                                    <th>Size</th>
                                    <th style="text-align: right;">Price (RM)</th>
                                    <th style="text-align: right;">Quantity</th>
                                    <th style="text-align:right;"> Total Amount (RM)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (products != null) {
                                        for (Product product : products) {
                                            double itemSubtotal = product.getPrice() * product.getStock()[0];
                                %>
                                <tr>
                                    <td style="color:grey;"><%=product.getSku().toUpperCase()%></td>
                                    <td><%=product.getName()%></td>
                                    <td><%=product.getSize()[0]%></td>
                                    <td style="text-align: right;"><%=String.format("%.2f", product.getPrice())%></td>
                                    <td style="text-align: right;"><%=product.getStock()[0]%></td>
                                    <td style="text-align: right;"><%=String.format("%.2f", itemSubtotal)%></td>
                                </tr>
                                <%
                                        }
                                    }
                                %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="5" class="text-end"><strong>SST (6%):</strong></td>
                                    <td style="text-align: right;"><strong><%=String.format("%.2f", tax)%></strong></td> <!-- 106% -->
                                </tr>
                                <tr>
                                    <td colspan="5" class="text-end"><strong>Order Sub Total:</strong></td>
                                    <td style="text-align: right;"><strong>  <%=String.format("%.2f", subtotal)%></strong></td> <!-- 100% -->
                                </tr>
                                <tr>
                                    <td colspan="5" class="text-end"><strong><i>(<%=order.getShipping().toUpperCase().substring(0, 1) + order.getShipping().toLowerCase().substring(1) %>)</i> Shipping Fee :</strong></td>
                                    <td style="text-align: right;"><strong>  <%=String.format("%.2f", shippingFee)%></strong></td>
                                </tr>
                                <tr class="text-success">
                                    <td colspan="5" class="text-end"><strong>Discount:</strong></td>
                                    <td style="text-align: right;"><strong>- <%=String.format("%.2f", discount)%></strong></td>
                                </tr>
                                <tr class="table-primary">
                                    <td colspan="5" class="text-end"><strong>Net Total (RM):</strong></td>
                                    <td style="text-align: right;"><strong><%=String.format("%.2f", order.getTotal())%></strong></td> <!-- 106% -->
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
            

        </div>
        <%
            } else {
        %>
        <div class="container mt-5">
            <div class="alert alert-danger" role="alert">
                Order not found or invalid order ID provided.
            </div>
        </div>
        <%
            }
        %>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
    <!-- copyright section start -->
    <div class="copyright_section">
    <div class="container" align="center">
        <p class="copyright_text">&copy; 2025 BalanceTiada, All Rights Reserved.</p>
    </div>
    </div>
    <!-- copyright section end -->

    <script>
    // Logout confirmation
        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
            window.location.href = "LogoutServlet";
            }
        }
    </script>
</html>
