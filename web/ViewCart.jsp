<%@ page import="java.util.*, model.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" href="css/Products.css">
        <link rel="stylesheet" href="css/owl-carousel.css">
        <link rel="stylesheet" href="css/lightbox.css">
        <link rel="stylesheet" href="css/viewcart.css">

        <title>Your Cart</title>
    </head>
    
    <body>

        <!-- HEADER -->
        <div id="header-placeholder"></div>

        <div class="pusher">    
            <div class="card">
                <div class="row">
                    <div class="col-md-8 cart">
                        <div class="title">
                            <div class="row">
                                <div class="col"><h4><b>Shopping Cart</b></h4></div>

                                <% 
                                    List<Cart> cartList = (List<Cart>) request.getAttribute("cartList");
                                    int itemCount = (cartList != null) ? cartList.size() : 0;
                                %>
                                <div class="col align-self-center text-right text-muted"><%= itemCount %> items</div>
                            </div>
                        </div>

                        <% 
                        double total = 0;
                        if (cartList != null) {
                            for (Cart cart : cartList) {
                                double subtotal = cart.getPrice() * cart.getQty();
                                total += subtotal;
                        %>

                        <div class="row border-top border-bottom">
                            <div class="row main align-items-center" 
                                 data-img="<%= cart.getFile() %>" 
                                 data-name="<%= cart.getProductName() %>" 
                                 data-size="<%= cart.getSize() %>" 
                                 data-qty="<%= cart.getQty() %>" 
                                 data-price="<%= cart.getPrice() %>">
                                <div class="col">
                                    <input type="checkbox" name="item" value="<%= cart.getUid() %>">
                                </div>
                                <div class="col-2">
                                    <img class="img-fluid" src="<%= cart.getFile() %>">
                                </div>
                                <div class="col">
                                    <div class="row"><%= cart.getProductName() %></div>
                                </div>
                                <div class="col">
                                    <div class="clothing-size"><%= cart.getSize() %></div>
                                </div>
                                <div class="col">
                                    <span class="border quantity"><%= cart.getQty() %></span>
                                </div>
                                <div class="col">RM <%= String.format("%.2f", cart.getPrice()) %></div>
                                <div class="col">
                                    <span class="edit-button">Edit</span>
                                    <span class="close">&#10005;</span>
                                </div>
                            </div>
                        </div>

                        <%
                            }
                        } else {
                        %>
                        <p>No items in cart.</p>
                        <% 
                        }
                        %>

                        <div class="back-to-shop"><a href="products.html">&leftarrow;</a><span class="text-muted">Back to shop</span></div>      
                    </div>

                    <!-- SUMMARY SECTION -->
                    <div class="col-md-4 summary">
                        <div class="highlight"><h5><b>Summary</b></h5></div>
                        <hr>
                        <div class="row">
                            <div class="col" style="padding-left:0;">ITEMS <%= itemCount %></div>
                            <div class="col text-right" id="itemsTotal">RM <%= String.format("%.2f", total) %></div>
                        </div>

                        <form id="cartForm">
                            <p class="paymentmethod">PAYMENT METHOD</p>
                            <select name="paymentMethod">
                                <option class="text-muted">Touch 'n Go E-Wallet</option>
                                <option class="text-muted">Visa</option>
                                <option class="text-muted">GrabPay</option>
                                <option class="text-muted">Boost</option>
                            </select>

                            <div id="visa-fields" style="margin-top: 5px;"></div>

                            <p class="address" style="border-top: 2px solid black; padding-top: 30px;">ADDRESS DETAILS</p>
                            <textarea name="address" placeholder="Full Address" rows="5" style="width: 100%; resize: none; overflow: hidden; margin-bottom: 25px;"></textarea>

                            <p style="border-top: 2px solid black; padding-top: 30px;">SHIPPING METHOD</p>
                            <select id="shippingMethodSelect" name="shippingMethod">
                                <option value="standard">Standard-Delivery - RM 25.00</option>
                                <option value="express">Express Delivery - RM 35.00</option>
                            </select>

                            <p>GIVE CODE</p>
                            <input id="code" placeholder="Enter your code" name="discountCode">
                        </form>

                        <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                            <div class="col">SHIPPING</div>
                            <div class="col text-right" id="shippingFee">RM 25.00</div>
                        </div>

                        <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                            <div class="col"><b>TOTAL PRICE</b></div>
                            <div class="col text-right" id="finalTotal"><b>RM <%= String.format("%.2f", total + 25.00) %></b></div>
                        </div>

                        <button class="btn">CHECKOUT</button>
                    </div>

                </div>
            </div>
        </div>

        <!-- Modal Overlay Start -->
        <div id="editModal" class="modal-overlay" style="display: none;">
            <div class="modal-content">
                <span class="modal-close" onclick="closeModal()">&times;</span>
                <div class="modal-body">
                    <form method="POST" action="updateCartItem">
                        <input type="hidden" id="modal-uid" name="uid" />
                        <input type="hidden" id="customer-id" name="custid" value="<%= request.getParameter("custid") %>" />

                        <!-- Top Panel -->
                        <div class="modal-top-panel">
                            <div class="modal-img">
                                <img id="modal-img" class="img-fluid" src="" alt="Product Image">
                            </div>
                            <div class="modal-info">
                                <p id="modal-title">Product Name</p>
                                <p>Price: <b id="modal-price">RM 0.00</b></p>
                            </div>
                        </div>

                        <!-- Bottom Panel -->
                        <div class="modal-bottom-panel">
                            <div class="form-group">
                                <label for="modal-size">Size:</label>
                                <select id="modal-size" name="size">
                                    <option>S</option>
                                    <option>M</option>
                                    <option>L</option>
                                    <option>XL</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="modal-quantity">Quantity:</label>
                                <input type="number" id="modal-quantity" name="qty" min="1" value="1">
                            </div>
                        </div>

                        <button type="submit">Save</button>
                    </form>
                </div>
            </div>
        </div>
        <!-- Modal Overlay End -->

        <!-- FOOTER -->
        <div id="footer-placeholder"></div>

        <!-- SCRIPTS -->
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
        <script src="js/viewcartmodal.js"></script>
        <script src="js/custom.js"></script>

        <script>
            fetch('header.html')
                    .then(response => response.text())
                    .then(data => document.getElementById('header-placeholder').innerHTML = data);

            fetch('footer.html')
                    .then(response => response.text())
                    .then(data => document.getElementById('footer-placeholder').innerHTML = data);

            const totalItemPrice = <%= total %>;

            window.onload = function () {
                const shippingSelect = document.getElementById("shippingMethodSelect");
                shippingSelect.addEventListener("change", function () {
                    updateSummary();
                });
            };

            function updateSummary() {
                let shippingFee = 25.0;
                let selectedShipping = document.getElementById("shippingMethodSelect").value;
                if (selectedShipping === "express") {
                    shippingFee = 35.0;
                }
                if (totalItemPrice > 1000) {
                    shippingFee = 0.0;
                }

                document.getElementById("shippingFee").innerText = (shippingFee === 0 ? "FREE" : "RM " + shippingFee.toFixed(2));
                let finalTotal = totalItemPrice + shippingFee;
                document.getElementById("finalTotal").innerHTML = "<b>RM " + finalTotal.toFixed(2) + "</b>";
            }


        </script>

    </body>
</html>
