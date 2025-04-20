<%-- 
    Document   : checkOrder
    Created on : Apr 14, 2025, 8:13:05 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- basic -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- mobile metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1">
    <!-- site metas -->
    <title>Order Status</title>
    <!-- bootstrap css -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <!-- style css -->
    <link rel="stylesheet" type="text/css" href="css/checkOrder.css">
    <!-- icons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- font css link -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
</head>
<body> 
    <%
        // Check if user is logged in
        String custID = (String) session.getAttribute("custID");
        if (custID == null) {
            response.sendRedirect("LoginAndRegister.jsp");
            return;
        }
        
        // Get customer details from session
        String firstName = (String) session.getAttribute("firstName");
        String lastName = (String) session.getAttribute("lastName");
        
        // Create Customer object
        Customer customer = new Customer();
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setCustID(custID);
    %>
    <!-- ** Header Area Start ** -->
    <header class="header-area header-sticky">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav class="main-nav">
                        <!-- ** Logo Start ** -->
                        <a href="home.jsp" class="logo">
                            <img src="media/logo.png">
                        </a>
                        <!-- ** Logo End ** -->
                        <!-- ** Menu Start ** -->
                        <ul class="nav">
                            <li class="scroll-to-section"><a href="home.jsp">Home</a></li>
                            <li><a href="Products.jsp">Products</a></li>
                            <li><a href="about.jsp">About Us</a></li>
                            <div class="cart_btn">
                                <li><a href="ViewCart.jsp"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon> CART (0)</a></li>
                            </div>
                            <div class="login_btn">
                                <li class="dropdown">
                                    <a class="dropdown-toggle">
                                        <i class="fa fa-user"></i> Welcome, <%= lastName %> <%= firstName %>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li><a href="myprofile.jsp">My Profile</a></li>
                                        <li><a href="checkOrder.jsp">My Order</a></li>
                                        <li><a href="ViewCart.jsp">My Cart</a></li>
                                        <li><a href="voucher.jsp">My Voucher</a></li>
                                        <li><a href="javascript:void(0);" onclick="confirmLogout()">Logout</a></li>
                                    </ul>
                                </li>
                            </div>
                        </ul>
                        <!-- ** Menu End ** -->
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ** Header Area End ** -->

    <div class="container-1">
        <div class="head-text">
            <h1>ORDER STATUS</h1><br>
        </div>
        <%
            // Database connection details
            String url = "jdbc:derby://localhost:1527/btdb";
            String dbUser = "nbuser";
            String dbPass = "nbuser";
            
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection(url, dbUser, dbPass);
                
                String sql = "SELECT * FROM ORDERS WHERE CUSTID = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, custID);
                rs = stmt.executeQuery();
                
                boolean hasOrders = false;
                
                while(rs.next()) {
                    hasOrders = true;
                    String orderId = rs.getString("ORDERID");
                    String status = rs.getString("STATUS");
                    String orderDate = rs.getString("ORDERDATE");
                    
                    // Calculate how many steps should be active based on status
                    int activeSteps = 1; // Default to first step
                    if("1".equalsIgnoreCase(status)) {
                        activeSteps = 1;
                    } else if("2".equalsIgnoreCase(status)) {
                        activeSteps = 2;
                    } else if("3".equalsIgnoreCase(status)) {
                        activeSteps = 3;
                    } else if("4".equalsIgnoreCase(status)) {
                        activeSteps = 4;
                    }
        %>
        <div class="card">
            <div class="row d-flex justify-content-between px-3 top">
                <div class="d-flex">
                    <h5>ORDER
                        <a href="orderDetail.jsp?orderId=<%= orderId %>"><span class="text-primary font-weight-bold">#<%= orderId %></span></a>
                        <br>
                        <span class="ml-2">by <%= customer.getFullName() %></span>
                    </h5>
                </div>
                <div class="d-flex flex-column text-sm-right">
                    <p class="mb-0">
                        Order Date <span class="font-weight-bold"><%= orderDate %></span>
                    </p>
                </div>
            </div>
            <div class="row d-flex justify-content-center">
                <div class="col-12">
                    <ul id="progressbar" class="text-center">
                        <li class="<%= activeSteps >= 1 ? "active" : "" %> step0"></li>
                        <li class="<%= activeSteps >= 2 ? "active" : "" %> step0"></li>
                        <li class="<%= activeSteps >= 3 ? "active" : "" %> step0"></li>
                        <li class="<%= activeSteps >= 4 ? "active" : "" %> step0"></li>
                    </ul>
                </div>
            </div>
            <div class="row justify-content-between top">
                <div class="row d-flex icon-content">
                    <img src="${pageContext.request.contextPath}/media/CheckList.png" alt="" class="icon"/>
                    <div class="d-flex flex-column">
                        <p class="font-weight-bold">Order<br/>Packaging</p>
                    </div>
                </div>
                <div class="row d-flex icon-content">
                    <img src="${pageContext.request.contextPath}/media/Shipping.png" alt="" class="icon"/>
                    <div class="d-flex flex-column">
                        <p class="font-weight-bold">Order<br/>Shipping</p>
                    </div>
                </div>
                <div class="row d-flex icon-content">
                    <img src="${pageContext.request.contextPath}/media/Delivery.png" alt="" class="icon"/>
                    <div class="d-flex flex-column">
                        <p class="font-weight-bold">Order<br/>Out For Delivery</p>
                    </div>
                </div>
                <div class="row d-flex icon-content">
                    <img src="${pageContext.request.contextPath}/media/Home.png" alt="" class="icon"/>
                    <div class="d-flex flex-column">
                        <p class="font-weight-bold">Order<br/>Delivered</p>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
                
                if (!hasOrders) {
        %>
        <div class="card">
            <div class="wrap-1">
                <div class="box-1">
                    <div class="description">
                        <p>No orders available at the moment.</p>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace(); // This will print the stack trace in server logs
            } finally {
                try { if(rs != null) rs.close(); } catch(Exception e) { }
                try { if(stmt != null) stmt.close(); } catch(Exception e) { }
                try { if(conn != null) conn.close(); } catch(Exception e) { }
            }
        %>
    </div>
<!-- footer section start -->
<div class="footer_section layout_padding">
<div class="container">
    <div class="contact_section_2">
        <div class="row">
            <div class="col-sm-4">
            <h3 class="address_text">Contact Us</h3>
            <div class="address_bt">
                <ul>
                    <li>
                        <a href="#">
                        <i class="fa fa-phone" aria-hidden="true"></i><span class="padding_left10">Call : +6012-3379156</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                        <i class="fa fa-envelope" aria-hidden="true"></i><span class="padding_left10">Email : sjh@gmail.com</span>
                        </a>
                    </li>
                </ul>
            </div>
            </div>
            <div class="col-sm-4 col-middle">
            <div class="footer_1"><p>BALANCETIADA</p></div>
            <p class="dummy_text">Balancetiada blends modern design with timeless values. Every piece is crafted to reflect balance, quality, and contemporary elegance.</p>
            </div>
            <div class="col-sm-4">
            <div class="main">
                <h3 class="address_text">Visit Us</h3>
                <p class="ipsum_text">Tanjung Malim</p>
                <p class="ipsum_text">Rawang</p>
                <p class="ipsum_text">Sungai Buloh</p>
                <p class="ipsum_text">Cheras</p>
                <p class="ipsum_text">Puncak Alam</p>
            </div>
            </div>
        </div>
    </div>
    <div class="social_icon">
        <ul>
            <li>
            <a href="https://www.facebook.com/"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            </li>
            <li>
            <a href="https://www.twitter.com/"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            </li>
            <li>
            <a href="https://www.instagram.com/"><i class="fa fa-instagram" aria-hidden="true"></i></a>
            </li>
        </ul>
    </div>
</div>
</div>
<!-- footer section end -->
<!-- copyright section start -->
<div class="copyright_section">
<div class="container">
    <p class="copyright_text">&copy; 2025 All Rights Reserved.</p>
</div>
</div>
<!-- copyright section end -->

    <!-- Add logout confirmation script -->
    <script>
        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
                window.location.href = "LogoutServlet";
            }
        }

        // Add dropdown functionality
        document.addEventListener('DOMContentLoaded', function() {
            const dropdownToggle = document.querySelector('.dropdown-toggle');
            const dropdownMenu = document.querySelector('.dropdown-menu');
            
            if (dropdownToggle && dropdownMenu) {
                dropdownToggle.addEventListener('click', function(e) {
                    e.preventDefault();
                    dropdownMenu.classList.toggle('show');
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function(e) {
                    if (!e.target.closest('.dropdown')) {
                        dropdownMenu.classList.remove('show');
                    }
                });
            }
        });
    </script>
    
</body>
</html>
