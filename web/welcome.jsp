<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to BalanceTiada</title>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/welcome.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
</head>
<body>
   <%
   // Check if user is logged in and get user details from session
   String custID = (String) session.getAttribute("custID");
   String firstName = (String) session.getAttribute("firstName");
   String lastName = (String) session.getAttribute("lastName");
   String email = (String) session.getAttribute("email");
   String password = (String) session.getAttribute("password");
   
   // Redirect to login if not logged in
   if (custID == null || firstName == null) {
       response.sendRedirect("LoginAndRegister.jsp");
       return;
   }
   
   // Create Customer object
   Customer customer = new Customer();
   customer.setCustID(custID);
   customer.setFirstName(firstName);
   customer.setLastName(lastName);
   customer.setEmail(email);
   customer.setPassword(password);
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
        
    <div class="welcome-container">
        <img src="media/logo.png" alt="BalanceTiada Logo" class="logo">
        <h1 class="welcome-title">WELCOME<br> <%= firstName %>!</h1>
        <p class="welcome-message">Thank you for joining BALENCETIADA. We're excited to have you as part of our community.</p>
        <a href="home.jsp" class="continue-btn">Continue to Shopping</a>
    </div>

    <!-- Bootstrap and jQuery Scripts -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
</body>
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
    <script>
    // Logout confirmation
    function confirmLogout() {
        if (confirm("Are you sure you want to logout?")) {
        window.location.href = "LogoutServlet";
        }
    }

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
</script>
</html> 