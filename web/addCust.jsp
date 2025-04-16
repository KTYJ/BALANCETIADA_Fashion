<%-- 
    Document   : addCust
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Customer" %>
<%@ page import="da.CustomerDA" %>
<%@ page import="domain.Toolkit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return;
    } else if (!staff.isManager()) { //staff bye bye
        request.setAttribute("error", "403 Access Denied");
        request.getRequestDispatcher("err403.jsp").forward(request, response);
        //response.sendRedirect("prodList.jsp");

    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Customer</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/aproduct.css">
        <style>
            .container {
                max-width: 600px;
                margin: 20px auto;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .btn {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                width: 100%;
            }
            .btn:hover {
                background-color: #45a049;
            }
            .error {
                border: 1px solid red;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(255, 196, 196);
                margin-bottom: 20px;
            }
            .error ul {
                list-style-position: inside;
                margin: 0;
                padding: 0;
            }
            .btn-secondary {
                background-color: #6c757d;
                margin: 10px auto;
                width: 50%;
            }
            #togglePassword {
                cursor: pointer;
                background-color: transparent;
                font-size: 1em;
                float: right;
            }
        </style>
        <script src="js/jquery-1.9.1.js"></script>
        <script>
            $(document).ready(function () {
                $('#togglePassword').click(function () {
                    const password = $('#psw');
                    const type = password.attr('type') === 'password' ? 'text' : 'password';
                    password.attr('type', type);

                    // Change the icon based on the password visibility
                    const icon = type === 'password' ? 'eye-outline' : 'eye-off-outline';
                    $('#eyeIcon').attr('name', icon);
                });
            });

            // Logout function
            function logOut() {
                if (confirm("Are you sure want to logout?")) {
                    window.location.href = "logout.jsp";
                }
            }
        </script>
    </head>
    <body>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <div class="sidebar">
            <ul class="menu">
                <div class="logo">
                    BALANCETIADA<br />
                    <span id="admintitle"><%= staff.getType().toUpperCase()%></span>
                </div>
                <div align="center">
                    <br />
                    <div class="date">
                        <span id="clock" class="time">10:30:45</span>
                        <br />
                        <span id="date1" class="time">Monday, 15 January</span>
                    </div>
                    <br />
                    <img src="media/staff.png" width="50vh" height="50vh">
                    <br />

                    Welcome,
                    <span id="aName"><%= staff.getName()%></span>
                    <br /><br />

                    <i class="fa fa-sign-out" aria-hidden="true" onclick="logOut()" style="cursor: pointer;"></i>
                </div>
                <li>
                    <a href="prodList.jsp">
                        <ion-icon name="shirt-outline" style="font-size: 1.2rem;"></ion-icon>
                        <span>Products</span>
                    </a>
                </li>
                <li>
                    <a href="custList.jsp">
                        <ion-icon name="people-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Customer List</span>
                    </a>
                </li>
                <%
                    if (staff.getType().equalsIgnoreCase("manager")) {
                %>
                <li>
                    <a href="reports.jsp">
                        <ion-icon name="document-text-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Reports</span>
                    </a>
                </li>
                <li>
                    <a href="staffList.jsp">
                        <ion-icon name="business-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Staff</span>
                    </a>
                </li>
                <%
                    }
                %>
                <li>
                    <a href="editStaffOwn.jsp">    
                        <ion-icon name="create-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Edit My Account</span>
                    </a>
                </li>
                <li>
                    <a href="staffOrders.jsp">    
                        <ion-icon name="cube-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Customer Orders</span>
                    </a>
                </li>
                <li>
                    <a href="discounts.jsp">    
                        <ion-icon name="pricetags-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Discounts & Vouchers</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="content">
            <div class="wrapper">
                <strong>Add New Customer</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <div class="button-container" align="center">
                        <button onclick="window.location.href = 'custList.jsp'" class="btn btn-secondary">Back to Customer List</button>
                    </div>

                    <%
                        if (request.getMethod().equals("POST")) {
                            String custId = "";
                            String fname = request.getParameter("fname");
                            String lname = request.getParameter("lname");
                            String email = request.getParameter("email");
                            String psw = request.getParameter("psw");
                            String cpsw = request.getParameter("cpsw");

                            ArrayList<String> errors = new ArrayList<>();

                            try {
                                boolean valid = false;
                                do {
                                    custId = Toolkit.generateUID();
                                    Customer existingCust = new CustomerDA().getCustomer(custId);
                                    valid = (existingCust == null); // Set valid to true if no existing customer is found
                                } while (!valid);
                            } catch (SQLException e) {
                                errors.add("Error checking customer ID: " + e.getMessage());
                            }

                            // Validate first name
                            if (fname == null || fname.trim().isEmpty()) {
                                errors.add("First name is required.");
                            } else if (!fname.matches("^[a-zA-Z\\s]+$")) {
                                errors.add("First name can only contain letters and spaces.");
                            }

                            // Validate last name
                            if (lname == null || lname.trim().isEmpty()) {
                                errors.add("Last name is required.");
                            } else if (!lname.matches("^[a-zA-Z\\s]+$")) {
                                errors.add("Last name can only contain letters and spaces.");
                            }

                            // Validate email
                            if (email == null || email.trim().isEmpty()) {
                                errors.add("Email is required.");
                            } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                                errors.add("Invalid email format.");
                            } else {
                                try {
                                    // Check if email already exists
                                    CustomerDA cda = new CustomerDA();
                                    Customer existingCust = cda.getCustomerByEmail(email);
                                    if (existingCust != null) {
                                        errors.add("Email already exists for another customer.");
                                    }
                                } catch (SQLException e) {
                                    errors.add("Error checking email: " + e.getMessage());
                                }
                            }

                            // Validate password
                            if (psw == null || psw.trim().isEmpty()) {
                                errors.add("Password is required.");
                            } else if (psw.length() < 5 || psw.length() > 15) {
                                errors.add("Password must be between 5 and 15 characters.");
                            } else if (!psw.matches("^[a-zA-Z0-9@$!%*?&]+$")) {
                                errors.add("Password can only contain letters, numbers, and special characters.");
                            } else if (cpsw == null || !psw.equals(cpsw)) {
                                errors.add("Passwords do not match.");
                            }

                            if (!errors.isEmpty()) {
                    %>
                    <div class="error">
                        <h3>Validation Errors:</h3>
                        <ul>
                            <% for (String error : errors) {%>
                            <li><%= error%></li>
                                <% } %>
                        </ul>
                    </div>
                    <%
                    } else {
                        try {
                            String hashedPassword = Toolkit.hashPsw(psw);
                            Customer newCustomer = new Customer(custId, fname, lname, email, hashedPassword);
                            request.setAttribute("newCustomer", newCustomer);
                            request.getRequestDispatcher("conCust.jsp").forward(request, response);
                        } catch (Exception e) {
                    %>
                    <div class="error">
                        <h3>Error creating customer:</h3>
                        <p><%= e.getMessage()%></p>
                    </div>
                    <%
                                }
                            }
                        }
                    %>

                    <form id="addCustomerForm" method="POST">
                        <div class="form-group">
                            <label for="fname">First Name:</label>
                            <input type="text" id="fname" name="fname" required>
                        </div>

                        <div class="form-group">
                            <label for="lname">Last Name:</label>
                            <input type="text" id="lname" name="lname" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required>
                        </div>

                        <div class="form-group">
                            <label for="psw">Password:
                                <button type="button" id="togglePassword" class="toggle-password">
                                    <ion-icon name="eye-outline" id="eyeIcon"></ion-icon>
                                </button>
                            </label>
                            <input type="password" id="psw" name="psw" required>
                        </div>

                        <div class="form-group">
                            <label for="cpsw">Confirm Password:</label>
                            <input type="password" id="cpsw" name="cpsw" required>
                        </div>

                        <button type="submit" class="btn">Add Customer</button>
                    </form>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            window.onload = startTime();
            function startTime() {
                const weekArr = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                const monthArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

                const today = new Date();
                let h = today.getHours();
                let m = today.getMinutes();
                let s = today.getSeconds();

                let day = today.getDate();
                var week = weekArr[today.getDay()];
                var month = monthArr[today.getMonth()];

                document.getElementById("date1").innerHTML = week + ", " + day + " " + month;
                h = checkTime(h);
                m = checkTime(m);
                s = checkTime(s);
                document.getElementById('clock').innerHTML = h + ":" + m + ":" + s;
                setTimeout(startTime, 1000);
            }

            function checkTime(i) {
                if (i < 10) {
                    i = "0" + i;
                }
                return i;
            }
        </script>
    </body>
</html> 