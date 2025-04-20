<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="model.Customer"%>
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
    <title>My Profile</title>
    <!-- bootstrap css -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <!-- style css -->
    <link rel="stylesheet" type="text/css" href="css/myprofile.css">
    <!-- icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <!-- font css link -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
    <!-- To overwrite other css desgin which interrupt dropdown menu-->
    <style>
        .dropdown-menu {
                display: none;
                position: absolute;
                background-color: #fff;
                min-width: 160px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.1);
                z-index: 1000;
                margin-left: 50px;
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
    <%
        // Check if user is logged in
        String custID = (String) session.getAttribute("custID");
        if (custID == null) {
            response.sendRedirect("LoginAndRegister.jsp");
            return;
        }
        
        // Get user details from session
        String firstName = (String) session.getAttribute("firstName");
        String lastName = (String) session.getAttribute("lastName");
        String email = (String) session.getAttribute("email");
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
    
    <div class="border1">
        <h2>MY PROFILE</h2>
        
        <!-- Display success message if any -->
        <% 
            String message = (String) session.getAttribute("message");
            if (message != null) {
                String messageClass = message.contains("successfully") ? "success" : "error";
        %>
        <div class="message <%= messageClass %>">
            <%= message %>
        </div>
        <%
                // Clear the message from session after displaying
                session.removeAttribute("message");
            }
        %>
        
        <div class="wrapper">
            <div class="input-box">
                <label>First Name&nbsp;:</label>
                <span><%= firstName %></span>
            </div>
            <div class="input-box">
                <label>Last Name&nbsp;:</label>
                <span><%= lastName %></span>
            </div>
            <div class="input-box">
                <label>Email&nbsp;:</label>
                <span><%= email %></span>
            </div>
        </div>
        <div class="btn-box">
            <a href="editprofile.jsp" class="btn">Edit Profile</a>
        </div>
    </div>
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
</html>