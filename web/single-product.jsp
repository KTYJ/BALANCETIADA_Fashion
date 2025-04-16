<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
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
    </head>
    <body>

        <!-- Preloader -->
        <div id="preloader">
            <div class="jumper">
                <div></div><div></div><div></div>
            </div>
        </div>

        <!-- Header -->
        <header class="header-area header-sticky">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav class="main-nav">
                            <a href="home.html" class="logo"><img src="/media/logo.png"></a>
                            <ul class="nav">
                                <li><a href="home.html">Home</a></li>
                                <li><a href="products.html" class="active">Products</a></li>
                                <li><a href="about.html">About Us</a></li>
                                <div class="cart_btn">
                                    <li><a href="#"><ion-icon name="bag-handle-outline"></ion-icon> CART (0)</a></li>
                                </div>
                                <div class="login_btn">
                                    <li><a href="#">Login</a></li>
                                </div>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </header>

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

                            <span class="price">RM <%= product.getPrice() %></span>

                            <span><%= product.getDescription() %></span>
                            <div class="quote">
                                <i class="fa fa-quote-left"></i>
                                <p>Size: <%= product.getSize() %>, In Stock: <%= product.getStock() %></p>
                            </div>

                            <div class="quantity-content">
                                <div class="left-content"><h6>Quantity</h6></div>
                                <div class="right-content">
                                    <div class="quantity buttons_added">
                                        <button type="button" class="minus">-</button>
                                        <input type="number" step="1" min="1" name="quantity" value="1"
                                               class="input-text qty text"
                                               id="quantityInput"
                                               data-price="<%= product.getPrice() %>">
                                        <button type="button" class="plus">+</button>
                                    </div>
                                </div>
                            </div>

                            <div class="total">
                                <h4 id="totalPrice"> Total: RM <%= product.getPrice() %></h4>
                                <div class="main-border-button"><a href="#">Add To Cart</a></div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <div class="footer_section layout_padding">
            <div class="container">
                <div class="contact_section_2">
                    <div class="row">
                        <div class="col-sm-4">
                            <h3 class="address_text">Contact Us</h3>
                            <ul>
                                <li><a href="#"><i class="fa fa-phone"></i><span class="padding_left10">Call : +6012-3379156</span></a></li>
                                <li><a href="#"><i class="fa fa-envelope"></i><span class="padding_left10">Email : sjh@gmail.com</span></a></li>
                            </ul>
                        </div>
                        <div class="col-sm-4">
                            <div class="footer_1"><p>BALANCETIADA</p></div>
                            <p class="dummy_text">Balancetiada blends modern design with timeless values. Every piece is crafted to reflect balance, quality, and contemporary elegance.</p>
                        </div>
                        <div class="col-sm-4">
                            <h3 class="address_text">Visit Us</h3>
                            <p class="ipsum_text">Tanjung Malim</p>
                            <p class="ipsum_text">Rawang</p>
                            <p class="ipsum_text">Sungai Buloh</p>
                            <p class="ipsum_text">Cheras</p>
                            <p class="ipsum_text">Puncak Alam</p>
                        </div>
                    </div>
                </div>
                <div class="social_icon">
                    <ul>
                        <li><a href="https://www.facebook.com/"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="https://www.twitter.com/"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="https://www.instagram.com/"><i class="fa fa-instagram"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Copyright -->
        <div class="copyright_section">
            <div class="container">
                <p class="copyright_text">&copy; 2025 All Rights Reserved.</p>
            </div>
        </div>

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
            const quantityInput = document.getElementById("quantityInput");
            const totalPrice = document.getElementById("totalPrice");

            function updateTotal() {
                const price = parseFloat(quantityInput.dataset.price);
                const qty = parseInt(quantityInput.value) || 1;
                totalPrice.textContent = "Total: RM " + (price * qty).toFixed(2);
            }

            // Update when user changes the input manually
            quantityInput.addEventListener("input", updateTotal);

            // Update when "+" or "-" buttons are clicked
            document.querySelectorAll(".plus, .minus").forEach(btn => {
                btn.addEventListener("click", () => {
                    // Small timeout to ensure the input value has updated first
                    setTimeout(updateTotal, 50);
                });
            });
        </script>

    </body>
    <% } %>
</html>
