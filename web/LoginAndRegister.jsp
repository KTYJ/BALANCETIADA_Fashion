<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="model.Customer" %>

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
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">
        <title>Login And Signup</title>

        <!-- Additional CSS Files -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/font-awesome.css">
        <link rel="stylesheet" href="css/Products.css">
        <link rel="stylesheet" href="css/owl-carousel.css">
        <link rel="stylesheet" href="css/lightbox.css">

        <link rel="stylesheet" href="css/LoginAndRegister.css">
        <!-- End Additional CSS Files -->
        
        <style>
            /* Success Popup Styles */
            .success-popup {
                display: none;
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.2);
                z-index: 1000;
                text-align: center;
                min-width: 300px;
            }
            
            .success-popup h2 {
                color: #28a745;
                margin-bottom: 15px;
            }
            
            .success-popup p {
                margin-bottom: 20px;
                color: #666;
            }
            
            .success-popup button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }
            
            .success-popup button:hover {
                background-color: #218838;
            }
            
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                z-index: 999;
            }
        </style>
    </head>
    <body>
        <!-- Add Success Popup -->
        <div class="overlay" id="overlay"></div>
        <div class="success-popup" id="successPopup">
            <h2><i class="fa fa-check-circle"></i> Success!</h2>
            <p>Your account has been created successfully!</p>
            <button onclick="closeSuccessPopup()">Continue to Login</button>
        </div>
        
        <%
            // Check for success popup flag
            if (session.getAttribute("showSuccessPopup") != null && (Boolean)session.getAttribute("showSuccessPopup")) {
                session.removeAttribute("showSuccessPopup");
        %>
            <script>
                window.onload = function() {
                    document.getElementById('overlay').style.display = 'block';
                    document.getElementById('successPopup').style.display = 'block';
                }
                
                function closeSuccessPopup() {
                    document.getElementById('overlay').style.display = 'none';
                    document.getElementById('successPopup').style.display = 'none';
                    // Ensure the login form is shown
                    document.getElementById('reg-log').checked = false;
                }
            </script>
        <%
            }
        %>
        <%
            if (request.getMethod().equals("POST")) {
                String custID = request.getParameter("custid");
                String firstName = request.getParameter("fname");
                String lastName = request.getParameter("lname");
                String email = request.getParameter("email");
                String psw = request.getParameter("psw");

                Customer customer = new Customer(custID, firstName, lastName, email, psw);

                // Set the product attribute
                request.setAttribute("customer", customer);
        %>

        <form method="POST" action="SignupServlet" id="hiddenForm">
            <%-- Hidden fields --%>
            <input type="hidden" name="custid" value="<%= customer.getCustID()%>">
            <input type="hidden" name="fname" value="<%= customer.getFirstName()%>">
            <input type="hidden" name="lname" value="<%= customer.getLastName()%>">
            <input type="hidden" name="email" value="<%= customer.getEmail()%>">
            <input type="hidden" name="pwd" value="<%= customer.getPassword()%>">
            <br>
        </form>
        <% } %>
        <div class="login-and-register">
            <!-- ***** Preloader Start ***** -->
            <div id="preloader">
                <div class="jumper">
                    <div></div>
                    <div></div>
                    <div></div>
                </div>
            </div>  
            <!-- ***** Preloader End ***** -->

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
                                    <li><a href="Products.jsp">Products</a></li>
                                    <li><a href="about.jsp">About Us</a></li>
                                    </li>
                                    <div class="cart_btn">
                                        <li><a href="ViewCart.jsp"><ion-icon name="bag-handle-outline" style="font-size: 20px; vertical-align: text-top;"></ion-icon> CART (0)</a></li>
                                    </div>
                                    <div class="login_btn">
                                        <li><a href="LoginAndRegister.jsp"class="active">Login</a></li>
                                    </div>
                                </ul>
                                <!-- ** Menu End ** -->
                            </nav>
                        </div>
                    </div>
                </div>
            </header>
            <!-- ** Header Area End ** -->

            <!-- Main Content Area Start -->
            <div class="section background-img-set">
                <div class="container">
                    <div class="row full-height justify-content-center">
                        <div class="col-12 text-center align-self-center py-5">
                            <div class="section pb-5 pt-5 pt-sm-2 text-center">
                                <h6 class="mb-0 pb-3"><span class="word-login both-word">Click the bottom button to Switch Login & Signup</span></h6>
                                <input class="toggle-checkbox checkbox" type="checkbox" id="reg-log" name="reg-log" />
                                <label for="reg-log"></label>
                                <div class="card-3d-wrap mx-auto">
                                    <div class="card-3d-wrapper">
                                        <div class="card-front">
                                            <div class="center-wrap">
                                                <div class="section text-center">
                                                    <h4 class="mb-4 pb-3">Log In</h4>
                                                    <form action="LoginServlet" method="post">
                                                        <div class="form-group">
                                                            <input type="text" name="logemail" class="form-style" placeholder="Your Email" id="logemail" autocomplete="off">
                                                            <i class="input-icon uil uil-at"></i>
                                                        </div>	
                                                        <div class="form-group mt-2">
                                                            <input type="password" name="logpass" class="form-style" placeholder="Your Password" id="logpass" autocomplete="off">
                                                            <i class="input-icon uil uil-lock-alt"></i>
                                                        </div>
                                                        <button type="submit" class="btn mt-4">Login</button>
                                                    </form>
                                                    <p class="mb-0 mt-4 text-center"><a href="#0" class="link">Forgot your password?</a></p>
                                                    <% if (session.getAttribute("errorMessage") != null) { %>
                                                        <p style="color: red; margin-top: 10px;"><%= session.getAttribute("errorMessage") %></p>
                                                        <% session.removeAttribute("errorMessage"); %>
                                                    <% } %>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="card-back">
                                            <div class="center-wrap">
                                                <div class="section text-center">
                                                    <h4 class="mb-4 pb-3">Sign Up</h4>
                                                    <form action="SignupServlet" method="post" onsubmit="return validateSignupForm();">
                                                        <div class="form-container login-and-register">
                                                            <!-- Left Panel -->
                                                            <div class="form-column">
                                                                <div class="form-group">
                                                                    <input type="text" name="firstname" class="form-style" placeholder="First Name" id="firstname" autocomplete="off">
                                                                    <i class="input-icon uil uil-user"></i>
                                                                </div>
                                                                <div class="form-group mt-2">
                                                                    <input type="text" name="lastname" class="form-style" placeholder="Last Name" id="lastname" autocomplete="off">
                                                                    <i class="input-icon uil uil-user"></i>
                                                                </div>
                                                                <div class="form-group mt-2">
                                                                    <input type="text" name="email" class="form-style" placeholder="Email" id="email" autocomplete="off" >
                                                                    <i class="input-icon uil uil-at"></i>
                                                                </div>
                                                            </div>

                                                            <!-- Right Panel -->
                                                            <div class="form-column">
                                                                <div class="form-group">
                                                                    <input type="password" name="password" class="form-style" placeholder="Password" id="password" autocomplete="off" >
                                                                    <i class="input-icon uil uil-lock-alt"></i>
                                                                </div>
                                                                <div class="form-group mt-2">
                                                                    <input type="password" name="confirmpassword" class="form-style" placeholder="Confirm Password" id="confirmpassword" autocomplete="off" >
                                                                    <i class="input-icon uil uil-lock-alt"></i>
                                                                </div>
                                                                <div class="form-group mt-3 text-start">
                                                                    <label style="font-size: 13px; display: flex; align-items: center; gap: 8px;">
                                                                        <input type="checkbox" class="terms-and-conditions" required /> <span class="terms-and-conditions">Accept Terms and Conditions</span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <button type="submit" class="btn mt-4">Register</button>
                                                    </form>
                                                    <% if (session.getAttribute("errorMessage") != null) { %>
                                                        <p style="color: red; margin-top: 10px;"><%= session.getAttribute("errorMessage") %></p>
                                                        <% session.removeAttribute("errorMessage"); %>
                                                    <% } %>
                                                    <% if (session.getAttribute("successMessage") != null) { %>
                                                        <p style="color: green; margin-top: 10px;"><%= session.getAttribute("successMessage") %></p>
                                                        <% session.removeAttribute("successMessage"); %>
                                                    <% } %>
                                                </div>
                                            </div>                                      
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Content Area End -->

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

            <!-- jQuery -->
            <script src="js/jquery-2.1.0.min.js"></script>

            <!-- Bootstrap -->
            <script src="js/popper.js"></script>
            <script src="js/bootstrap.min.js"></script>

            <!-- Plugins -->
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

            <!-- Global Init -->
            <script src="js/custom.js"></script>

            <script>

                                                            $(function () {
                                                                var selectedClass = "";
                                                                $("p").click(function () {
                                                                    selectedClass = $(this).attr("data-rel");
                                                                    $("#portfolio").fadeTo(50, 0.1);
                                                                    $("#portfolio div").not("." + selectedClass).fadeOut();
                                                                    setTimeout(function () {
                                                                        $("." + selectedClass).fadeIn();
                                                                        $("#portfolio").fadeTo(50, 1);
                                                                    }, 500);

                                                                });
                                                            });

                                                            function submitHiddenForm() {
                                                                document.getElementById("hiddenForm").submit();
                                                            }

            </script>

            <script>
                function validateSignupForm() {
                    let isValid = true;
                    const errors = [];
                    
                    // Reset previous error states
                    document.querySelectorAll('.form-error').forEach(error => error.remove());
                    
                    // Validate First Name
                    const firstName = document.getElementById('firstname');
                    if (!/^[A-Za-z]{2,30}$/.test(firstName.value.trim())) {
                        showError(firstName, 'First name must be 2-30 characters long and contain only letters');
                        isValid = false;
                    }
                    
                    // Validate Last Name
                    const lastName = document.getElementById('lastname');
                    if (!/^[A-Za-z]{2,30}$/.test(lastName.value.trim())) {
                        showError(lastName, 'Last name must be 2-30 characters long and contain only letters');
                        isValid = false;
                    }
                    
                    // Validate Email
                    const email = document.getElementById('email');
                    if (!/^[A-Za-z0-9+_.-]+@(.+)$/.test(email.value.trim())) {
                        showError(email, 'Please enter a valid email address');
                        isValid = false;
                    }
                    
                    // Validate Password
                    const password = document.getElementById('password');
                    if (password.value.trim().length < 6) {
                        showError(password, 'Password must be at least 6 characters long');
                        isValid = false;
                    }
                    
                    // Validate Confirm Password
                    const confirmPassword = document.getElementById('confirmpassword');
                    if (password.value !== confirmPassword.value) {
                        showError(confirmPassword, 'Passwords do not match');
                        isValid = false;
                    }
                    
                    return isValid;
                }
                
                function showError(input, message) {
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'form-error';
                    errorDiv.style.color = '#ff6b6b';
                    errorDiv.style.fontSize = '12px';
                    errorDiv.style.marginTop = '5px';
                    errorDiv.textContent = message;
                    input.parentElement.appendChild(errorDiv);
                    input.style.borderColor = '#ff6b6b';
                }
            </script>
    
    </body>
</div>
</html>