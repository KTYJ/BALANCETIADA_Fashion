<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Get user information from session
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    
    // For debugging
    System.out.println("First Name: " + firstName);
    System.out.println("Last Name: " + lastName);
%>
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
   <title>About</title>
   <!-- bootstrap css -->
   <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
   <!-- ionicons -->
   <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
   <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
   <!-- font css link -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
   <link rel="stylesheet" href="css/about.css">
</head>
<body>
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
                        <li><a href="about.jsp" class="active">About Us</a></li>
                        <div class="cart_btn">
                           <li><a href="ViewCart.jsp"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon> CART (0)</a></li>
                        </div>
                        <div class="login_btn">
                           <% if (firstName != null && lastName != null) { %>
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
                           <% } else { %>
                              <li><a href="LoginAndRegister.jsp">Login</a></li>
                           <% } %>
                        </div>
                     </ul>
                     <!-- ** Menu End ** -->
                  </nav>
            </div>
         </div>
      </div>
   </header>
   <!-- ** Header Area End ** -->
   <!-- about section start -->
   <div class="about_section layout_padding">
      <div class="container">
         <div class="about_section_main">
            <div class="row">
               <div class="col-md-6">
                  <div class="about_taital_main">
                     <h1 class="about_taital">About BALENCETIADA</h1>
                     <p class="about_text">BALANCETIADA was born from a vision — a vision held by our founder, Datuk Sri Tai Jin Le, who believed that Malaysia deserved a fashion label that could stand proudly on the global stage. With a deep-rooted passion for style, creativity, and quality, he set out to create more than just a clothing brand — he set out to create a movement.
                     </p>
                     <p class="about_text">
                        <br>Driven by the desire to elevate Malaysia's fashion landscape, Datuk Sri Tai Jin Le combined high fashion aesthetics with bold streetwear elements to form a new identity — one that balances luxury and edge, tradition and rebellion. Thus, BALANCETIADA was born — a name that reflects our mission to restore balance in fashion while embracing innovation.
                     </p>
                     <p class="about_text">
                        <br>From our first concept boutique to our growing presence, every piece we design carries the spirit of our founder's ambition: to offer refined, daring clothing for those who are unafraid to stand out, wherever they are in the world.
                     </p>
                     <p class="about_text">
                        <br>Join us on our journey — wear the balance, define your style.
                     </p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- about section end -->
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
   
   <!-- Dropdown and other functionality -->
   <script>
      // Add dropdown functionality script
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
         if (confirm("Are you sure you want to logout?")) {
            window.location.href = "LogoutServlet";
         }
      }

      function openNav() {
         document.getElementById("mySidenav").style.width = "100%";
      }
      
      function closeNav() {
         document.getElementById("mySidenav").style.width = "0";
      }
   </script>
</body>
</html>