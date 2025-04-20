<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Product" %>
<%
    // Check if product is in session, if not redirect to servlet
    Product product = (Product) session.getAttribute("product");
    if (product == null) {
        String sku = request.getParameter("sku");
        if (sku != null && !sku.trim().isEmpty()) {
            response.sendRedirect("SingleProduct?sku=" + sku);
            return;
        }
        response.sendRedirect("Products.jsp");
        return;
    }
%>
<% if (product == null) { %>
<h2 style="text-align:center; margin-top: 50px;">Product not found.</h2>
<% } else { %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Product Detail Page</title>

        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" href="css/Products.css">
        <link rel="stylesheet" href="css/owl-carousel.css">
        <link rel="stylesheet" href="css/lightbox.css">
        
        <!-- Custom Dropdown CSS -->
        <style>
            .dropdown {
                position: relative;
                display: inline-block;
            }
            
            .dropdown-menu {
                display: none;
                position: absolute;
                right: 0;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1000;
                border-radius: 4px;
                padding: 8px 0;
            }
            
            .dropdown-menu.show {
                display: block;
            }
            
            .dropdown-menu li {
                padding: 8px 16px;
                list-style: none;
            }
            
            .dropdown-menu li:hover {
                background-color: #f1f1f1;
            }
            
            .dropdown-menu a {
                color: #333;
                text-decoration: none;
                display: block;
            }
            
            .dropdown-toggle::after {
                display: inline-block;
                margin-left: 5px;
                vertical-align: middle;
                content: "";
                border-top: 5px solid;
                border-right: 5px solid transparent;
                border-bottom: 0;
                border-left: 5px solid transparent;
            }
        </style>
    </head>
    <body>

        <!-- Preloader -->
        <div id="preloader">
            <div class="jumper">
                <div></div><div></div><div></div>
            </div>
        </div>

        <!-- ** Header Area Start ** -->
        <header class="header-area header-sticky">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav class="main-nav">
                            <!-- ** Logo Start ** -->
                            <a href="home.jsp" class="logo">
                                <img src="${pageContext.request.contextPath}/media/logo.png">
                            </a>
                            <!-- ** Logo End ** -->
                            <!-- ** Menu Start ** -->
                            <ul class="nav">
                                <li class="scroll-to-section"><a href="home.jsp">Home</a></li>
                                <li><a href="Products.jsp" class="active">Products</a></li>
                                <li><a href="about.jsp">About Us</a></li>
                                <div class="cart_btn">
                                    <li><a href="ViewCart.jsp"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon> CART (0)</a></li>
                                </div>
                                <div class="login_btn">
                                    <% if (session.getAttribute("firstName") != null && session.getAttribute("lastName") != null) { %>
                                        <li class="dropdown">
                                            <a class="dropdown-toggle">
                                                <i class="fa fa-user"></i> Welcome, <%= session.getAttribute("lastName") %> <%= session.getAttribute("firstName") %>
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

        <!-- Add logout confirmation script -->
        <script>
            function confirmLogout() {
                if (confirm("Are you sure you want to logout?")) {
                    window.location.href = "LogoutServlet";
                }
            }
        </script>

        <!-- Product Detail Area -->
        <section class="section" id="product">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="left-images">
                            <img src="<%= product.getFile() %>" alt="<%= product.getName() %>" style="max-width:100%">
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="right-content">
                            <%
                                String categoryName = "";
                                switch (product.getCatid()) {
                                    case 1: categoryName = "Trending"; break;
                                    case 2: categoryName = "Women"; break;
                                    case 3: categoryName = "Men"; break;
                                    case 4: categoryName = "Kids"; break;
                                    default: categoryName = "Unknown";
                                }
                            %>
                            <h5>Category: <%= categoryName %></h5>
                            <br>
                            <h4><%= product.getName() %></h4>

                            <span class="price">RM <%= String.format("%.2f", product.getPrice()) %></span>

                            <span><%= product.getDescription() %></span>
                            <div class="quote">
                                <i class="fa fa-quote-left"></i>
                                <p>In Stock: <%= product.getStock() %></p>
                            </div>

                            <div class="quantity-content" style="display: flex; align-items: center; gap: 20px;">
                                <form action="AddToCart" method="POST" style="width: 100%;">
                                    <input type="hidden" name="sku" value="<%= product.getSku() %>">
                                    <div style="display: flex; align-items: center;">
                                        <h6 style="margin: 0 10px 0 0;">Size:</h6>
                                        <select name="size" class="form-control" style="width: 80px;">
                                            <%
                                                String[] sizes = product.getSize().split("\\|");
                                                for (String size : sizes) {
                                                    out.println("<option value='" + size.trim() + "'>" + size.trim() + "</option>");
                                                }
                                            %>
                                        </select>
                                    </div>
                                    
                                    <div style="display: flex; align-items: center; margin-top: 15px;">
                                        <h6 style="margin: 0 10px 0 0;">Quantity:</h6>
                                        <div class="quantity buttons_added">
                                            <button type="button" class="minus">-</button>
                                            <input type="number" step="1" min="1" max="<%= product.getStock() %>" 
                                                   name="quantity" value="1" class="input-text qty text" 
                                                   id="quantityInput" data-price="<%= product.getPrice() %>">
                                            <button type="button" class="plus">+</button>
                                        </div>
                                    </div>

                                    <div class="total" style="margin-top: 20px;">
                                        <h4 id="totalPrice">Total: RM <%= String.format("%.2f", product.getPrice()) %></h4>
                                        <div class="main-border-button">
                                            <button type="submit" class="btn" style="background: none; border: 1px solid #000; padding: 10px 20px; cursor: pointer;">Add To Cart</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="errorMessageForAddToCartValidate" style="color: #dc3545; margin-top: 15px; text-align: center;">
                                <%
                                    String errorMessage = (String) session.getAttribute("errorMessage");
                                    if (errorMessage != null) {
                                        out.println("<div style='font-weight: bold; margin-bottom: 10px;'>" + errorMessage + "</div>");
                                        if (errorMessage.contains("LOG IN")) {
                                            out.println("<div><a href='LoginAndRegister.jsp' style='color: #007bff; text-decoration: underline;'>Register and Login Here</a></div>");
                                        }
                                        session.removeAttribute("errorMessage");
                                    }
                                    
                                    String successMessage = (String) session.getAttribute("successMessage");
                                    if (successMessage != null) {
                                        out.println("<div style='color: #28a745; font-weight: bold;'>" + successMessage + "</div>");
                                        session.removeAttribute("successMessage");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

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

        <!-- Scripts -->
        <script src="js/jquery-2.1.0.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl-carousel.js"></script>
        <script src="js/accordions.js"></script>
        <script src="js/datepicker.js"></script>
        <script src="js/scrollreveal.min.js"></script>
        <script src="js/waypoints.min.js"></script>
        <script src="js/jquery.counterup.min.js"></script>
        <script src="js/imgfix.min.js"></script>
        <script src="js/slick.js"></script>
        <script src="js/lightbox.js"></script>
        <script src="js/isotope.js"></script>
        <script src="js/quantity.js"></script>
        <script src="js/custom.js"></script>

        
        <!-- Quantity Logic -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const quantityInput = document.getElementById('quantityInput');
                const totalPriceElement = document.getElementById('totalPrice');
                const price = parseFloat(quantityInput.getAttribute('data-price'));
                const plusButton = document.querySelector('.plus');
                const minusButton = document.querySelector('.minus');
                
                function updateTotal() {
                    const quantity = parseInt(quantityInput.value) || 1;
                    const total = price * quantity;
                    totalPriceElement.textContent = 'Total: RM ' + total.toFixed(2);
                }
                
                // Update total for all possible quantity change events
                quantityInput.addEventListener('input', updateTotal);
                quantityInput.addEventListener('change', updateTotal);
                plusButton.addEventListener('click', function() {
                    setTimeout(updateTotal, 30); // Small delay to ensure quantity is updated
                });
                minusButton.addEventListener('click', function() {
                    setTimeout(updateTotal, 30); // Small delay to ensure quantity is updated
                });
                
                // Initial calculation
                updateTotal();
            });
        </script>

        <!-- Dropdown Menu JavaScript -->
        <script>
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
                        if (!dropdownToggle.contains(e.target) && !dropdownMenu.contains(e.target)) {
                            dropdownMenu.classList.remove('show');
                        }
                    });
                }
            });
        </script>

    </body>
    <% } %>
</html>
