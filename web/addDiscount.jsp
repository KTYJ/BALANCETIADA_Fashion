<%-- 
    Document   : addDiscount
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Discount" %>
<%@ page import="da.DiscountDA" %>
<%@ page import="domain.Toolkit" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        response.sendRedirect("home.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Discount</title>
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
            input[type="text"],
            input[type="number"],
            textarea {
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
            .radio-group {
                display: flex;
                gap: 20px;
                margin: 10px 0;
            }
            .radio-group label {
                display: flex;
                align-items: center;
                font-weight: normal;
                cursor: pointer;
            }
            .radio-group input[type="radio"] {
                margin-right: 5px;
                cursor: pointer;
            }
            #valueInput {
                width: 150px;
            }
            .value-suffix {
                display: inline-block;
                margin-left: 5px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

        <div class="sidebar">
            <!-- Same sidebar as discounts.jsp -->
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
                <strong>Add New Discount</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <div class="button-container" align="center">
                        <button onclick="window.location.href='discounts.jsp'" class="btn btn-secondary">Back to Discounts</button>
                    </div>

                    <%
                        if (request.getMethod().equals("POST")) {
                            String code = request.getParameter("code");
                            String type = request.getParameter("type");
                            String value = request.getParameter("value");
                            String description = request.getParameter("description");
                            String id = null;

                            ArrayList<String> errors = new ArrayList<>();

                            // Validate code
                            if (code == null || code.trim().isEmpty()) {
                                errors.add("Discount code is required.");
                            } else {
                                try {
                                    DiscountDA discountDA = new DiscountDA();
                                    Discount existingDiscount = discountDA.findByCode(code);
                                    if (existingDiscount != null) {
                                        errors.add("Discount code already exists.");
                                    }
                                } catch (SQLException e) {
                                    errors.add("Error checking discount code: " + e.getMessage());
                                }
                            }

                            // Validate type
                            if (type == null || (!type.equals("P") && !type.equals("A"))) {
                                errors.add("Invalid discount type.");
                            }

                            // Validate value
                            if (value == null || value.trim().isEmpty()) {
                                errors.add("Discount value is required.");
                            } else {
                                try {
                                    int numValue = Integer.parseInt(value);
                                    if (numValue <= 0) {
                                        errors.add("Discount value must be greater than 0.");
                                    } else if (type != null && type.equals("P") && numValue > 100) {
                                        errors.add("Percentage discount cannot exceed 100%.");
                                    }
                                } catch (NumberFormatException e) {
                                    errors.add("Invalid discount value format. Please enter a whole number.");
                                }
                            }

                            // Generate unique ID
                            try {
                                id = Toolkit.generateUID();
                            } catch (Exception e) {
                                errors.add("Error generating discount ID: " + e.getMessage());
                            }

                            if (!errors.isEmpty()) {
                    %>
                    <div class="error">
                        <h3>Validation Errors:</h3>
                        <ul>
                            <% for (String error : errors) { %>
                            <li><%= error %></li>
                            <% } %>
                        </ul>
                    </div>
                    <%
                    } else {
                        try {
                            Discount newDiscount = new Discount(id, code, type, Integer.parseInt(value), description != null ? description : "");
                            DiscountDA discountDA = new DiscountDA();
                            discountDA.addDiscount(newDiscount);
                            response.sendRedirect("discounts.jsp");
                            return;
                        } catch (SQLException e) {
                    %>
                    <div class="error">
                        <h3>Error adding discount:</h3>
                        <p><%= e.getMessage() %></p>
                    </div>
                    <%
                            }
                        }
                    }
                    %>

                    <form id="addDiscountForm" method="POST" onsubmit="return validateForm()">
                        <div class="form-group">
                            <label for="code">Discount Code:</label>
                            <input type="text" id="code" name="code" required>
                        </div>

                        <div class="form-group">
                            <label>Discount Type:</label>
                            <div class="radio-group">
                                <label>
                                    <input type="radio" name="type" value="P" checked onchange="updateValueSuffix()">
                                    Percentage
                                </label>
                                <label>
                                    <input type="radio" name="type" value="A" onchange="updateValueSuffix()">
                                    Amount (RM)
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="value">Value:</label>
                            <div style="display: flex; align-items: center;">
                                <input type="number" id="value" name="value" step="1" min="1" required>
                                <span class="value-suffix" id="valueSuffix">%</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea id="description" name="description" rows="3"></textarea>
                        </div>

                        <button type="submit" class="btn">Add Discount</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Update value suffix based on discount type
            function updateValueSuffix() {
                const suffix = document.querySelector('input[name="type"]:checked').value === 'P' ? '%' : ' RM';
                document.getElementById('valueSuffix').textContent = suffix;
            }

            // Form validation
            function validateForm() {
                const value = document.getElementById('value').value;
                const type = document.querySelector('input[name="type"]:checked').value;
                const numValue = parseInt(value);

                if (isNaN(numValue) || numValue <= 0) {
                    alert('Value must be a positive whole number');
                    return false;
                }

                if (type === 'P' && numValue > 100) {
                    alert('Percentage discount cannot exceed 100%');
                    return false;
                }

                if (value.includes('.')) {
                    alert('Please enter a whole number without decimal places');
                    return false;
                }

                return true;
            }

            // Logout function
            function logOut() {
                if (confirm("Are you sure want to logout?")) {
                    window.location.href = "logout.jsp";
                }
            }

            // Clock and date function
            window.onload = function() {
                startTime();
                updateValueSuffix();
            };
            
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