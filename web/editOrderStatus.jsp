<%-- 
    Document   : editOrderStatus
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Orders" %>
<%@ page import="da.OrdersDA" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%!
    boolean isValidStatusTransition(String newStatus) {
        System.out.println("newStatus: " + newStatus);
        // Define valid statuses
        String[] validStatuses = {"0","1", "2", "3", "4"};
        
        // Strip and convert to lowercase for case-insensitive comparison
        newStatus = newStatus.strip().toLowerCase();
        
        // Check if the new status is in the valid statuses list
        for (String status : validStatuses) {
            if (status.equals(newStatus)) {
                return true;
            }
            System.out.println("status: " + status);
        }
        return false;
    }


%>

<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        response.sendRedirect("home.jsp");
        return;
    }
    else if (!staff.isManager()) {
        request.setAttribute("error", "403 Access Denied");
        request.getRequestDispatcher("err403.jsp").forward(request, response);
        //response.sendRedirect("prodList.jsp");

    }

    // Get the order ID from request parameter
    String orderId = request.getParameter("orderId");
    if (orderId == null || orderId.trim().isEmpty()) {
        response.sendRedirect("staffOrders.jsp");
        return;
    }

    // Initialize OrdersDA and get the order
    OrdersDA ordersDA = new OrdersDA();
    Orders order = ordersDA.getOrderByOrderId(orderId);

    if (order == null) {
        response.sendRedirect("staffOrders.jsp");
        return;
    }

    // Handle form submission
    if (request.getMethod().equals("POST")) {
        String newStatus = (String) request.getParameter("status");
        
        if (newStatus != null && !newStatus.isEmpty()) {
            try {
                // Validate the status
                System.out.println("newStatus: " + newStatus);
                if (!isValidStatusTransition(newStatus)) {
                    request.setAttribute("error", "Invalid status. Status must be one of: Packaging, Shipping, Delivery, Completed");
                } else {
                    ordersDA.updateOrderStatus(orderId, newStatus);
                    // Refresh order data after update
                    order = ordersDA.getOrderByOrderId(orderId);
                    request.setAttribute("updateSuccess", true);
                }
            } catch (Exception e) {
                request.setAttribute("error", e.getMessage());
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff - Edit Order Status</title>
        <link rel="stylesheet" href="css/aproduct.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <style>         
        
            .btn {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                width: 80%;
            }
            .error {
                border: 1px solid red;
                padding: 15px;
                border-radius: 5px;
                background-color: rgb(255, 196, 196);
                margin-bottom: 20px;
                text-align: left;
                display: flex;
                align-items: center;
            }

            .error p {
                margin: 0;
            }

            .error i {
                margin-right: 10px;
                color: red;
                font-size: 1.2em;
            }
            
            .main-content {
                padding-top:0;
            }

            .success {
                border: 1px solid green;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(196, 255, 196);
                margin-bottom: 20px;
                text-align: center;
            }

            .btn-secondary {
                background-color:rgb(107, 118, 128);
                color: white;
                width: 50%;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .btn-secondary:hover {
                background-color: rgb(156, 168, 189);
            }

            .status-form {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                padding-bottom: 0;
            }

            .radio-group {
                display: grid;
                grid-template-columns: repeat(2, 1fr); /* Creates 2 columns of equal width */
                gap: 15px;
                margin: 20px 0;
            }

            .radio-option {
                font-size: 1rem;
                display: flex;
                align-items: center;
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                background-color: rgb(40, 40, 40);
                height: 100%; /* Ensures equal height for all options */
            }
            .radio-option span{
                display: block;
                filter: blur(1px);
                margin-left: 5px;
            }


            .radio-option:hover {
                background-color: rgb(180, 180, 180);
                opacity: 1;
                filter: blur(0px);
                transform: scale(1.02); /* Slight zoom effect on hover */
            }

            .radio-option input[type="radio"] {
                margin-right: 15px;
                transform: scale(1.2);
            }

            .radio-option input[type="radio"]:checked {
                filter: hue-rotate(180deg) grayscale(100%); 
            }

            .radio-option.packaging {
                color: rgb(0, 140, 255);
            }
            .radio-option.shipping {
                color: orange;
            }
            .radio-option.delivery {
                color: purple;
            }
            .radio-option.completed {
                color: green;
            }

            .radio-option.selected {
                background-color:rgb(255, 255, 255);
                border: 1px solid rgb(66, 66, 66);

                font-weight: bold;
            }

            .radio-option.selected span{
                display: block;
                filter: blur(0px);
            }

            .order-info {
                background-color: #f8f9fa;
                padding: 10px;
                border-radius: 8px;
                margin-bottom: 20px;
                border: 3px solid rgb(195, 195, 195);
            }

            .order-info p {
                margin: 5px 0;
            }

            .table {
                width: 100%;
                border-collapse: collapse; /* Ensures borders are merged */
            }

            .table th, .table td {
                border: 1px solid #ddd; /* Light gray border */
                padding: 10px; /* Padding for cells */
                text-align: left; /* Align text to the left */
            }

            .table th {
                background-color: #f2f2f2; /* Light gray background for header */
                font-weight: bold; /* Bold text for header */
                font-family: 'Trebuchet MS', sans-serif;
            }

            td strong {
                font-family: 'Trebuchet MS', sans-serif;
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: #f9f9f9; /* Light background for odd rows */
            }

            .table-striped tbody tr:hover {
                background-color: #f1f1f1; /* Highlight row on hover */
            }

            .status-completed {
                color: green;
            }
            .status-shipping {
                color: orange;
            }
            .status-packaging {
                color: rgb(0, 140, 255);
            }
            .status-delivery {
                color: purple;
            }

            button[type="submit"]:hover {
                transition: background-color 0.3s ease;
                background-color:rgb(42, 150, 46);
            }
            
        </style>
        <script>
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
                    BALANCETIAsDA<br />
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

        <div class="content" style="overflow:hidden;">
            <div class="wrapper">
                <strong>Editing Order Status: <span style="color:rgb(255, 0, 0);"><%= order.getOrderId()%></span></strong>
            </div>
            <div class="main-content">
                <div class="status-form">
                    <div class="button-container" align="center">
                        <button onclick="window.location.href = 'staffOrders.jsp'" class="btn btn-secondary">Back to Orders List</button>
                    </div>
                    <br/>

                    <div class="order-info">
                        <% if (request.getAttribute("updateSuccess") != null) {%>
                        <div class="success">
                            <h3>Order status updated successfully!</h3>
                            <img src="media/hahayes.png" alt="Sucessful" width="100px" height="150px">
                        </div>
                        <% }%>
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td style="text-align: right; width: 30%;"><strong>Order ID:</strong></td>
                                    <td style="text-align: left; width: 70%;"><%= order.getOrderId() %></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><strong>Customer ID:</strong></td>
                                    <td><%= order.getCustId() %></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><strong>Order Date:</strong></td>
                                    <td><%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(order.getOrderDate()) %></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><strong>Total:</strong></td>
                                    <td>MYR <%= String.format("%.2f", order.getTotal()) %></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><strong>Shipping Method:</strong></td>
                                    <td><%= order.getShipping().substring(0, 1).toUpperCase() + order.getShipping().substring(1) %></td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;"><strong>Current Status:</strong></td>
                                    <td><span style="font-weight: bold;" class="status-<%= order.getStatusString().toLowerCase() %>"><%= order.getStatusString().substring(0, 1).toUpperCase() + order.getStatusString().substring(1) %></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <% if (request.getAttribute("error") != null) {%>
                    <div class="error">
                        <p><i class="fa fa-exclamation-circle"></i> Error: <%= request.getAttribute("error")%></p>
                    </div>
                    <% }%>

                    <% if (request.getAttribute("updateSuccess") == null) {%>
                    <form method="POST" onsubmit="return confirm('Are you sure you want to update the order status?')">
                        <div class="radio-group">
                            <label class="radio-option packaging <%= order.getStatusString().equalsIgnoreCase("packaging") ? "selected" : ""%>">
                                <input type="radio" name="status" value="1" 
                                       <%= order.getStatusString().equalsIgnoreCase("packaging") ? "checked" : ""%>>
                                <b style="font-size: 1.5rem;"> &#128230;</b><span>Packaging</span>
                            </label>
                            <label class="radio-option shipping <%= order.getStatusString().equalsIgnoreCase("shipping") ? "selected" : ""%>">
                                <input type="radio" name="status" value="2" 
                                       <%= order.getStatusString().equalsIgnoreCase("shipping") ? "checked" : ""%>>
                                <b style="font-size: 1.5rem;"> &#128674;</b><span>Shipping</span>
                            </label>
                            <label class="radio-option delivery <%= order.getStatusString().equalsIgnoreCase("delivery") ? "selected" : ""%>">
                                <input type="radio" name="status" value="3" 
                                       <%= order.getStatusString().equalsIgnoreCase("delivery") ? "checked" : ""%>>
                                <b style="font-size: 1.5rem;"> &#128666;</b><span>(Out for) Delivery</span>
                            </label>
                            <label class="radio-option completed <%= order.getStatusString().equalsIgnoreCase("completed") ? "selected" : ""%>">
                                <input type="radio" name="status" value="4" 
                                       <%= order.getStatusString().equalsIgnoreCase("completed") ? "checked" : ""%>>
                                <b style="font-size: 1.5rem;"> &#128175;</b><span>Completed</span>
                            </label>
                        </div>
                        <div align="center">
                            <button class="btn" type="submit" style="width: 100%;">Update Status</button>
                        </div>
                    </form>
                    <% }%>
                </div>
            </div>
        </div>

        <script>
            // Clock and date function
            window.onload = function () {
                startTime();
                setupRadioHighlight();
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

            function setupRadioHighlight() {
                const radioOptions = document.querySelectorAll('.radio-option');
                radioOptions.forEach(option => {
                    const radio = option.querySelector('input[type="radio"]');
                    radio.addEventListener('change', () => {
                        // Remove selected class from all options
                        radioOptions.forEach(opt => opt.classList.remove('selected'));
                        // Add selected class to checked option
                        if (radio.checked) {
                            option.classList.add('selected');
                        }
                    });
                });
            }
        </script>
    </body>
</html> 