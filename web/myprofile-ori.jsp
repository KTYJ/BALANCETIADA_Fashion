<%-- 
    Document   : editprofile
    Created on : Apr 14, 2025, 7:54:34 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="domain.Customer" %>
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
        <title>Edit Profile</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- bootstrap css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" type="text/css" href="css/editprofile.css">
        <!-- Responsive-->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <!-- fonts -->
        <link href="https://fonts.googleapis.com/css?family=Great+Vibes|Open+Sans:400,700&display=swap&subset=latin-ext" rel="stylesheet">
        <!-- owl stylesheets --> 
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <style>
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 5px;
                text-align: center;
            }
            .success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
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
            String password = (String) session.getAttribute("password");
            
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
                                <li><a href="myprofile.jsp" class="active">My Profile</a></li>
                                <li><a href="checkOrder.jsp">Check Order</a></li>
                                <div class="cart_btn">
                                    <li><a href="ViewCart.jsp"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon>My Cart</a></li>
                                </div>
                                <div class="login_btn">
                                    <li><a href="voucher.jsp">Voucher</a></li>
                                </div>
                                <div class="login_btn">
                                    <li><a href="javascript:void(0);" onclick="confirmLogout()">Log Out</a></li>
                                </div>
                            </ul>
                            <!-- ** Menu End ** -->
                        </nav>
                    </div>
                </div>
            </div>
        </header>
        <!-- ** Header Area End ** -->
        
        <!-- Add scripts -->
        <script>
            function confirmLogout() {
                if (confirm("Are you sure you want to logout?")) {
                    window.location.href = "LogoutServlet";
                }
            }
            
            function confirmUpdate() {
                return confirm("Are you sure you want to update your profile?");
            }
        </script>
        
        <div class="border1">
            <h2>EDIT PROFILE</h2>
            
            <!-- Display message if any -->
            <% String message = (String) request.getAttribute("message");
               if (message != null) {
                   String messageClass = message.contains("successfully") ? "success" : "error";
            %>
            <div class="message <%= messageClass %>">
                <%= message %>
            </div>
            <% } %>
            
            <form action="UpdateProfileServlet" method="POST" onsubmit="return confirmUpdate();">
                <div class="form-container">
                    <div class="left">
                        <div class="form-group">
                            <label for="id">ID</label>
                            <input type="text" id="id" name="id" value="<%= custID %>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="first-name">First Name</label>
                            <input type="text" id="first-name" name="first-name" value="<%= firstName %>" required>
                        </div>
                        <div class="form-group">
                            <label for="last-name">Last Name</label>
                            <input type="text" id="last-name" name="last-name" value="<%= lastName %>" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="<%= email %>" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" value="<%= password %>" required>
                        </div>
                    </div>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">Update Profile</button>
                    <a href="myprofile.jsp" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </body>
</html>
