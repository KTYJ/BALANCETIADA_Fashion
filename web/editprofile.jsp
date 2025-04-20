<%-- 
    Document   : editprofile
    Created on : Apr 14, 2025, 7:54:34 PM
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
    <title>Edit Profile</title>
    <!-- bootstrap css -->
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <!-- style css -->
    <link rel="stylesheet" type="text/css" href="css/editprofile.css">
    <!-- icons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- font css link -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
    
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
        
        <form action="${pageContext.request.contextPath}/UpdateProfileServlet" method="POST" onsubmit="return validateForm();">
            <div class="wrapper">
                <input type="hidden" id="id" name="id" value="<%= custID %>">
                <div class="input-box">
                    <label for="first-name">First Name&nbsp;:</label>
                    <input type="text" id="first-name" name="first-name" value="<%= firstName %>" required>
                    <div class="form-error"></div>
                </div>
                <div class="input-box">
                    <label for="last-name">Last Name&nbsp;:</label>
                    <input type="text" id="last-name" name="last-name" value="<%= lastName %>" required>
                    <div class="form-error"></div>
                </div>
                <div class="input-box">
                    <label for="email">Email&nbsp;:</label>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                    <div class="form-error"></div>
                </div>
                <div class="input-box">
                    <label for="password">Enter Password to Confirm Changes&nbsp;:</label>
                    <input type="password" id="password" name="password" required>
                    <div class="form-error"></div>
                </div>
            </div>
            <p style="text-align: center;">
                Note : If you want to change your password, please contact the customer service.
            </p>
            <div class="btn-box">
                <button type="submit" class="btn">Update Profile</button>
                <a href="myprofile.jsp" class="btn">Cancel</a>
            </div>
        </form>
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

    <script>
    // Logout confirmation
        function confirmLogout() {
            if (confirm("Are you sure you want to logout?")) {
            window.location.href = "LogoutServlet";
            }
        }
    </script>
</html>
