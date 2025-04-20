<%@ page import="java.util.*, model.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Initialize variables
    String custId = (String) session.getAttribute("custID");
    List<Cart> cartList = null;
    double total = 0.0;
    
    // Only try to get cart list if user is logged in
    if (custId != null) {
        cartList = (List<Cart>) session.getAttribute("cartList");
        if (cartList == null) {
            response.sendRedirect("ViewCart");
            return;
        }
    }
%>
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
            
            /* Updated close button styles */
            .closeButton {
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                padding: 0 !important;
            }
            
            .close {
                font-size: 20px !important;
                cursor: pointer;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                color: #dc3545 !important;
                transition: color 0.3s ease;
                margin: 0 !important;
                padding: 0 !important;
                width: 100% !important;
                text-align: center !important;
            }
            
            .close:hover {
                color: #c82333 !important;
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

        <div class="pusher">    
            <div class="card">
                <div class="row">
                    <div class="col-md-8 cart">
                        <!-- Error Message Display -->
                        <% if (session.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <%= session.getAttribute("errorMessage") %>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% session.removeAttribute("errorMessage"); %>
                        <% } %>
                        <!-- Message Display Section -->
                        <% if (session.getAttribute("successMessage") != null) { %>
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <%= session.getAttribute("successMessage") %>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <% session.removeAttribute("successMessage"); %>
                        <% } %>
                        <!-- End Message Display Section -->

                        <div class="title">
                            <div class="row">
                                <div class="col"><h4><b>Shopping Cart</b></h4></div>
                                <div class="col align-self-center text-right">
                                    <span class="text-muted"><%= (cartList != null) ? cartList.size() : 0 %> items</span>
                                </div>
                            </div>
                        </div>

                        <% 
                        if (custId == null) {
                        %>
                            <div class="text-center" style="padding: 40px;">
                                <div style="margin-bottom: 20px;">
                                    <h5 style="color: #dc3545;">Login to Access Your Cart</h5>
                                    <p style="color: #666;">Please login to view your cart items and proceed with shopping.</p>
                                </div>
                                <div class="text-center">
                                    <a href="LoginAndRegister.jsp" class="btn1">Login Now</a>
                                    <a href="Products.jsp" class="btn2">Continue Shopping</a>
                                </div>
                            </div>
                        <%
                        } else if (cartList == null || cartList.isEmpty()) {
                        %>
                            <div class="text-center" style="padding: 20px;">
                                <p>No items in cart.</p>
                                <div class="text-center">
                                    <a href="Products.jsp" class="btn2">Continue Shopping</a>
                                </div>
                            </div>
                        <% 
                        } else {
                        %>
                            <!-- Add the header row -->
                            <div class="row border-top border-bottom" style="background-color: #f8f9fa; font-weight: bold; padding: 10px 0;">
                                <div class="row main align-items-center" style="width: 100%;">
                                    <div class="col">
                                        Select
                                    </div>
                                    <div class="col-2">
                                        Image
                                    </div>
                                    <div class="col">
                                        Product Name
                                    </div>
                                    <div class="col">
                                        Size
                                    </div>
                                    <div class="col">
                                        Quantity
                                    </div>
                                    <div class="col">
                                        Price
                                    </div>
                                    <div class="col">
                                        Subtotal
                                    </div>
                                    <div class="col">
                                        
                                    </div>
                                    <div class="col">
                                        
                                    </div>
                                </div>
                            </div>
                            <%
                            for (Cart cart : cartList) {
                                double subtotal = cart.getPrice() * cart.getQty();
                                total += subtotal;
                        %>
                                <!-- Cart item display -->
                                <div class="row border-top border-bottom">
                                    <div class="row main align-items-center" 
                                         data-img="<%= cart.getFile() %>" 
                                         data-name="<%= cart.getProductName() %>" 
                                         data-size="<%= cart.getSize() %>" 
                                         data-qty="<%= cart.getQty() %>" 
                                         data-price="<%= cart.getPrice() %>" 
                                         data-sku="<%= cart.getSku() %>">
                                        <div class="col">
                                            <input type="checkbox" name="item" value="<%= cart.getUid() %>" checked onchange="updateTotals()" 
                                                   data-price="<%= cart.getPrice() %>" 
                                                   data-qty="<%= cart.getQty() %>">
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
                                            <span class="subtotal">RM <%= String.format("%.2f", cart.getPrice() * cart.getQty()) %></span>
                                        </div>
                                        <div class="col">
                                            <span class="edit-button">Edit</span>
                                        </div>                                      
                                        <div class="col closeButton">
                                            <span class="close" onclick="showDeleteConfirmation('<%= cart.getUid() %>', '<%= cart.getProductName() %>', '<%= cart.getSize() %>')" style="display: flex; justify-content: center; align-items: center;">&#10005;</span>
                                        </div> 
                                    </div>
                                </div>
                        <%
                            }
                        %>
                            <div class="back-to-shop">
                                <a href="Products.jsp">&leftarrow;</a>
                                <span class="text-muted">Back to shop</span>
                            </div>
                        <%
                        }
                        %>
                    </div>

                    <!-- SUMMARY SECTION -->
                    <div class="col-md-4 summary">
                        <div class="highlight"><h5><b>Summary</b></h5></div>
                        <hr>
                        <div class="row">
                            <div class="col" style="padding-left:0;">ITEMS <%= (cartList != null) ? cartList.size() : 0 %></div>
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
                            <div class="col text-right" id="shippingFee">RM 0.00</div>
                        </div>

                        <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                            <div class="col">SALES TAX (10%)</div>
                            <div class="col text-right" id="salesTax">RM 0.00</div>
                        </div>

                        <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                            <div class="col" style="font-size: 0.9rem;"><b>TOTAL PRICE</b></div>
                            <div class="col text-right" id="finalTotal" style="font-size: 1rem;"><b>RM <%= String.format("%.2f", total + (total * 0.10) + 25.00) %></b></div>
                        </div>

                        <button class="btn">CHECKOUT</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Modal Overlay Start -->
        <div id="editModal" class="modal-overlay" style="display: none;">
            <div class="modal-content">
                <span class="modal-close" onclick="closeModal()">&times;</span>
                <div class="modal-body">
                    <form method="POST" action="updateCartItem">
                        <input type="hidden" id="modal-uid" name="uid" />
                        <input type="hidden" id="modal-sku" name="sku" />
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
                                    <!-- Size options will be populated dynamically -->
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
        <!-- Edit Modal Overlay End -->

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteConfirmModalLabel">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to remove this item from your cart?
                        <p class="mt-2" id="deleteItemDetails"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="cancelDeleteBtn">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let itemToDelete = null;
            let deleteModal = null;
            
            document.addEventListener('DOMContentLoaded', function() {
                // Initialize the modal
                deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'), {
                    keyboard: true,
                    backdrop: true
                });
                
                // Add event listener for cancel button
                document.getElementById('cancelDeleteBtn').addEventListener('click', function() {
                    deleteModal.hide();
                });
                
                // Add event listener for close button
                document.querySelector('#deleteConfirmModal .btn-close').addEventListener('click', function() {
                    deleteModal.hide();
                });
            });
            
            function showDeleteConfirmation(uid, productName, size) {
                itemToDelete = uid;
                document.getElementById('deleteItemDetails').textContent = productName + ' (Size: ' + size + ')';
                if (!deleteModal) {
                    deleteModal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'), {
                        keyboard: true,
                        backdrop: true
                    });
                }
                deleteModal.show();
            }

            document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
                if (itemToDelete) {
                    fetch('deleteCartItem', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'uid=' + encodeURIComponent(itemToDelete)
                    })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(result => {
                        if (result === 'success') {
                            // Close the modal
                            deleteModal.hide();
                            
                            // Redirect to ViewCart.jsp which will refresh the page
                            window.location.href = 'ViewCart.jsp';
                        } else {
                            throw new Error('Failed to delete item');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        // Show error message in modal
                        const modalBody = document.querySelector('#deleteConfirmModal .modal-body');
                        const errorMessage = document.createElement('div');
                        errorMessage.className = 'alert alert-danger mt-2';
                        errorMessage.textContent = 'Failed to remove item from cart. Please try again.';
                        modalBody.appendChild(errorMessage);
                        
                        // Remove error message after 3 seconds
                        setTimeout(() => {
                            errorMessage.remove();
                        }, 3000);
                    });
                }
            });

            // Handle modal hidden event
            document.getElementById('deleteConfirmModal').addEventListener('hidden.bs.modal', function () {
                // Clear any error messages
                const modalBody = this.querySelector('.modal-body');
                const errorMessages = modalBody.querySelectorAll('.alert-danger');
                errorMessages.forEach(msg => msg.remove());
                
                // Reset itemToDelete
                itemToDelete = null;
            });
        </script>

        
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
            var totalItemPrice = parseFloat('<%= String.format("%.2f", total) %>');
            
            window.onload = function() {
                var shippingSelect = document.getElementById("shippingMethodSelect");
                if (shippingSelect) {
                    shippingSelect.addEventListener("change", updateSummary);
                }
                // Initial update of sales tax and totals
                updateSummary();
            };

            function updateSummary() {
                var shippingFee = 25.0;
                var selectedShipping = document.getElementById("shippingMethodSelect");
                
                if (selectedShipping) {
                    if (selectedShipping.value === "express") {
                        shippingFee = 35.0;
                    }
                    if (totalItemPrice > 1000) {
                        shippingFee = 0.0;
                    }

                    // Calculate sales tax (10% of total items price)
                    var salesTax = totalItemPrice * 0.10;
                    
                    var shippingFeeElement = document.getElementById("shippingFee");
                    var salesTaxElement = document.getElementById("salesTax");
                    var finalTotalElement = document.getElementById("finalTotal");
                    
                    if (shippingFeeElement && finalTotalElement && salesTaxElement) {
                        shippingFeeElement.innerText = (shippingFee === 0 ? "FREE" : "RM " + shippingFee.toFixed(2));
                        salesTaxElement.innerText = "RM " + salesTax.toFixed(2);
                        var finalTotal = totalItemPrice + salesTax + shippingFee;
                        finalTotalElement.innerHTML = "<b>RM " + finalTotal.toFixed(2) + "</b>";
                    }
                }
            }
        </script>

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

<script>
    document.querySelectorAll('.edit-button').forEach(btn => {
        btn.addEventListener('click', () => {
            const item = btn.closest('.main');
            const uid = item.querySelector('input[type="checkbox"]').value;
            const img = item.getAttribute('data-img');
            const name = item.getAttribute('data-name');
            const currentSize = item.getAttribute('data-size');
            const qty = item.getAttribute('data-qty');
            const price = item.getAttribute('data-price');
            const sku = item.getAttribute('data-sku');

            // Update form fields
            document.getElementById('modal-uid').value = uid;
            document.getElementById('modal-sku').value = sku;
            document.getElementById('modal-img').src = img;
            document.getElementById('modal-title').innerText = name;
            document.getElementById('modal-price').innerText = "RM " + parseFloat(price).toFixed(2);
            document.getElementById('modal-quantity').value = qty;

            // Fetch product sizes from the server
            fetch('GetProductSizes?sku=' + sku)
                .then(response => response.text())
                .then(sizes => {
                    const sizeSelect = document.getElementById('modal-size');
                    sizeSelect.innerHTML = ''; // Clear existing options
                    
                    // Split the sizes string and create options
                    sizes.split('|').forEach(size => {
                        const option = document.createElement('option');
                        option.value = size.trim();
                        option.textContent = size.trim();
                        if (size.trim() === currentSize) {
                            option.selected = true;
                        }
                        sizeSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error fetching sizes:', error);
                });

            modal.style.display = 'flex';
        });
    });

    function closeModal() {
        modal.style.display = 'none';
    }
</script>

<script>
    function updateTotals() {
        let total = 0;
        let checkedCount = 0;
        
        // Get all checkboxes
        document.querySelectorAll('input[type="checkbox"][name="item"]').forEach(checkbox => {
            if (checkbox.checked) {
                checkedCount++;
                const price = parseFloat(checkbox.getAttribute('data-price'));
                const qty = parseInt(checkbox.getAttribute('data-qty'));
                if (!isNaN(price) && !isNaN(qty)) {
                    total += price * qty;
                }
            }
        });
        
        // Update total in the summary section
        document.getElementById('itemsTotal').innerText = 'RM ' + total.toFixed(2);
        
        // Update selected items count
        document.querySelector('.col[style="padding-left:0;"]').innerText = 'ITEMS ' + checkedCount;
        
        // Update final total with shipping
        const shippingFee = parseFloat(document.getElementById('shippingFee').innerText.replace('RM ', '')) || 0;
        document.getElementById('finalTotal').innerHTML = '<b>RM ' + (total + shippingFee).toFixed(2) + '</b>';
        
        // Update the totalItemPrice variable used in shipping calculations
        totalItemPrice = total;
        updateSummary();
    }

    // Call updateTotals on page load to set initial values
    document.addEventListener('DOMContentLoaded', function() {
        updateTotals();
    });
</script>

    </body>
</html>
