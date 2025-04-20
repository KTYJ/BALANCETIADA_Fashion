<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

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
   <title>BalanceTiada</title>
   <!-- bootstrap css -->
   <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
   <!-- style css -->
   <link rel="stylesheet" type="text/css" href="css/home.css">
   <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
   <!-- ionicons -->
   <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
   <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
   <!-- font css link -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
</head>
<body>
   <!-- ** Header Area Start ** -->
<header class="header-area header-sticky">
   <div class="container">
      <div class="row">
         <div class="col-12">
            <nav class="main-nav">
               <a href="home.jsp" class="logo">
                  <img src="media/logo.png">
               </a>
               <ul class="nav">
                  <li class="scroll-to-section">
                     <a href="#top" class="active">Home</a>
                  </li>
                  <li>
                     <a href="Products.jsp">Products</a>
                  </li>
                  <li>
                     <a href="about.jsp">About Us</a>
                  </li>
                  <div class="cart_btn">
                     <li>
                        <a href="ViewCart.jsp"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon> CART (0)</a>
                     </li>
                  </div>
                  <div class="login_btn">
                     <% if (session.getAttribute("firstName") == null) { %>
                        <li>
                           <a href="LoginAndRegister.jsp">Login</a>
                        </li>
                     <% } %>
                  </div>
               </ul>
            </nav>
         </div>
      </div>
   </div>
</header>
<!-- ** Header Area End ** -->

<!-- Success Popup -->
<div id="successPopup" class="modal fade" style="display: none;">
   <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title">Welcome!</h5>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
         </div>
         <div class="modal-body">
            <% if (session.getAttribute("successMessage") != null) { %>
               <p><%= session.getAttribute("successMessage") %></p>
               <% session.removeAttribute("successMessage"); %>
            <% } else { %>
               <p>Registration successful! Welcome to BALANCETIADA.</p>
            <% } %>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-success" data-dismiss="modal">Continue Shopping</button>
         </div>
      </div>
   </div>
</div>

<!-- Replace the login button with user info when logged in -->
<script>
   // Function to handle logout confirmation
   function confirmLogout() {
      if (confirm("Are you sure you want to logout?")) {
            window.location.href = "LogoutServlet";
      }
   }

   // Function to update header based on login status
   function updateHeader() {
      const userDiv = document.querySelector('.login_btn');
      const firstName = '<%= session.getAttribute("firstName") %>';
      const lastName = '<%= session.getAttribute("lastName") %>';
      
      if (firstName !== 'null') {
         // User is logged in
         userDiv.innerHTML = `
            <li class="dropdown">
               <a class="dropdown-toggle">
                  <i class="fa fa-user"></i> Welcome, ${lastName} ${firstName}
               </a>
               <ul class="dropdown-menu">
                  <li><a href="myprofile.jsp">My Profile</a></li>
                  <li><a href="checkOrder.jsp">My Order</a></li>
                  <li><a href="ViewCart.jsp">My Cart</a></li>
                  <li><a href="voucher.jsp">My Voucher</a></li>
                  <li><a href="javascript:void(0);" onclick="confirmLogout()">Logout</a></li>
               </ul>
            </li>
         `;

         // Add click event listener for dropdown
         const dropdownToggle = userDiv.querySelector('.dropdown-toggle');
         const dropdownMenu = userDiv.querySelector('.dropdown-menu');
         
         dropdownToggle.addEventListener('click', function(e) {
            e.preventDefault();
            dropdownMenu.classList.toggle('show');
         });

         // Close dropdown when clicking outside
         document.addEventListener('click', function(e) {
            if (!userDiv.contains(e.target)) {
               dropdownMenu.classList.remove('show');
            }
         });
      }
   }

   // Call updateHeader when page loads
   window.onload = function() {
      updateHeader();
      
      // Check for registration success
      const urlParams = new URLSearchParams(window.location.search);
      if (urlParams.get('registration') === 'success') {
         $('#successPopup').modal('show');
         // Remove the parameter from URL without refreshing
         window.history.replaceState({}, document.title, window.location.pathname);
      }
   }
</script>


<!-- banner section start -->
<div class="banner_section layout_padding">
   <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
         <div class="carousel-item active">
            <div class="container">
               <div class="row">
                  <div class="col-sm-6">
                     <p class="banner_text">Where bold design meets tranquil luxury — BALANCETIADA redefines high fashion with a unique blend of elegance, innovation, and streetwear sophistication, all set against serene surroundings that inspire timeless style.</p>
                     <div class="read_bt">
                        <a href="#">Buy Now</a>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<!-- banner section end -->

<!-- product section start -->
<%
    // Database connection details
    String url = "jdbc:derby://localhost:1527/btdb";
    String user = "nbuser";
    String pass = "nbuser";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection(url, user, pass);
        stmt = conn.createStatement();
        String sql = "SELECT * FROM PRODUCT";
        rs = stmt.executeQuery(sql);

        int count = 0;
%>

<div class="product_section layout_padding">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <h1 class="product_taital">Trending Now</h1>
                <p class="product_text">“Our best of the season collection.”</p>
            </div>
        </div>
        <div class="product_section_2 layout_padding">
            <div class="row">
                <%
                    while (rs.next() && count < 4) {
                        String sku = rs.getString("sku");
                        String name = rs.getString("name");
                        count++;
                %>
                <div class="col-lg-3 col-sm-6">
                    <div class="product_box">
                        <h4 class="bursh_text"><%= sku %></h4>
                        <p class="lorem_text"><%= name %></p>
                        <img src="images/img-1.png" class="image_1">
                        <div class="btn_main">
                            <div class="buy_bt">
                                <ul>
                                    <li><a href="product.jsp">EXPLORE</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

               <div class="seemore_bt"><a href="#">See More</a></div>
               <div class="promo_row">
                  <div class="row">
                     <div class="promo_box1">
                        <a href="voucher.jsp"> <img src="media/promo-img.png" class="image_1"></a>
                     </div>
                     <div class="promo_box2">
                        <a href="myprofile.jsp"> <img src="media/join-member.png" class="image_1"></a>
                     </div>
                  </div>
                </div>
         </div>
   </div>
</div>
<!-- product section end -->
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
            <div class="col-sm-4">
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
   function openNav() {
   document.getElementById("mySidenav").style.width = "100%";
   }
   
   function closeNav() {
   document.getElementById("mySidenav").style.width = "0";
   }
</script>
</body>
</html>