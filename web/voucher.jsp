<%-- 
    Document   : voucher
    Created on : Apr 14, 2025, 5:03:48 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Discount" %>
<%@page import="da.DiscountDA" %>
<%@page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%
    // Get user information from session
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    
    // Redirect if not logged in
    if (firstName == null || lastName == null) {
        response.sendRedirect("LoginAndRegister.jsp");
        return;
    }

    // Get voucher list from request attribute or fetch from database
    List<Discount> voucherList = (List<Discount>) request.getAttribute("voucherList");
    if (voucherList == null) {
        DiscountDA discountDA = new DiscountDA();
        voucherList = discountDA.getAllDiscount();
    }
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
        <title>Voucher</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- Responsive-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="${pageContext.request.contextPath}/images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.mCustomScrollbar.min.css">
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <!-- fonts -->
        <link href="https://fonts.googleapis.com/css?family=Great+Vibes|Open+Sans:400,700&display=swap&subset=latin-ext" rel="stylesheet">
        <!-- owl stylesheets --> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <!-- style css -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/voucher.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
        <script>
            function showCode(button, code) {
                const redeemDiv = button.closest('.redeem');
                const p = redeemDiv.querySelector('p');
                if (p.innerText === 'Get Code') {
                    p.innerText = code;
                    redeemDiv.style.backgroundColor = '#28a745'; // Change to green when showing code
                } else {
                    p.innerText = 'Get Code';
                    redeemDiv.style.backgroundColor = 'rgb(255, 77, 77)'; // Change back to original color
                }
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
                margin-left: 50px;
                border-radius: 4px;
            }
            
            .dropdown-menu.show {
                display: block;
            }
            
            .dropdown-menu li {
                padding: 0;
                margin: 0;
                list-style: none;
            }
            
            .dropdown-menu li a {
                color: #000000;
                text-decoration: none;
                display: block;
                text-align: left;
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

<!-- Add dropdown functionality script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const dropdownToggle = document.querySelector('.dropdown-toggle');
        const dropdownMenu = document.querySelector('.dropdown-menu');
        
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
    });

    // Logout confirmation
    function confirmLogout() {
        if (confirm("Are you sure you want to logout?")) {
            window.location.href = "LogoutServlet";
        }
    }
</script>

        <div class="head-text">
            <h1>VOUCHER</h1><br>
            <p>Enjoy Shopping With Our Voucher</p>
        </div>
        
        <div class="container-1">
            <%
                if (voucherList != null && !voucherList.isEmpty()) {
                    for (Discount v : voucherList) {
                        if (v != null) {
            %>
            <div class="card">
                <div class="wrap-1">
                    <div class="box-1">
                        <div class="discount">
                            <h3>
                                <%
                                    String type = v.getType();
                                    String value = v.getValue();
                                    if (type != null && value != null) {
                                        if ("P".equals(type)) {
                                            out.print(value + "%");
                                        } else if ("A".equals(type)) {
                                            out.print("RM " + value);
                                        }
                                    }
                                %>
                                <br>OFF
                            </h3>
                        </div>
                        <div class="description">
                            <p><%= v.getDescription() != null ? v.getDescription() : ""%></p>
                        </div>
                        <div class="redeem" onclick="showCode(this, '<%= v.getCode()%>')">
                            <p>Get Code</p>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            } else {
            %>
            <div class="card">
                <div class="wrap-1">
                    <div class="box-1">
                        <div class="description">
                            <p>No vouchers available at the moment.</p>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
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

