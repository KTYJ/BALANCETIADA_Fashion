<%-- 
    Document   : deleteCustomer
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Customer" %>
<%@ page import="da.CustomerDA" %>
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

    // Get the customer ID to delete from the request parameter
    String deleteCustId = request.getParameter("custId");
    String confirmDelete = request.getParameter("confirm");
    
    if (deleteCustId != null && confirmDelete != null && confirmDelete.equals("true")) {
        try {
            CustomerDA customerDA = new CustomerDA();
            
            // Check if customer exists before deletion    
            Customer customerToDelete = customerDA.getCustomer(deleteCustId);
            if (customerToDelete == null) {
                request.setAttribute("error", "Customer not found.");
                request.getRequestDispatcher("custList.jsp").forward(request, response);
                return;
            }
            
            // Perform the deletion
            customerDA.deleteCustomer(deleteCustId);
            response.sendRedirect("custList.jsp");
            return;
            
        } catch (SQLException e) {
            request.setAttribute("error", "Error deleting customer: " + e.getMessage());
            request.getRequestDispatcher("custList.jsp").forward(request, response);
            return;
        }
    } else if (deleteCustId != null) {
        // If no confirmation, show confirmation page
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete Customer</title>
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
                text-align: center;
            }
            .btn-group {
                margin-top: 20px;
            }
            .btn {
                padding: 10px 20px;
                margin: 0 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .warning-text {
                color: #dc3545;
                font-weight: bold;
                margin: 20px 0;
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
                <strong>Delete Customer</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <%
                        try {
                            CustomerDA customerDA = new CustomerDA();
                            Customer customerToDelete = customerDA.getCustomer(deleteCustId);
                            if (customerToDelete != null) {
                    %>
                    <h2>Confirm Deletion</h2>
                    <p class="warning-text">Are you sure you want to delete the following customer?</p>
                    <p><strong>Name:</strong> <%= customerToDelete.getFname() %> <%= customerToDelete.getLname() %></p>
                    <p><strong>Email:</strong> <%= customerToDelete.getEmail() %></p>
                    <p><strong>Customer ID:</strong> <%= customerToDelete.getCustid() %></p>
                    
                    <div class="btn-group">
                        <form action="deleteCustomer.jsp" method="POST" style="display: inline;">
                            <input type="hidden" name="custId" value="<%= deleteCustId %>">
                            <input type="hidden" name="confirm" value="true">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                        <button onclick="window.location.href='custList.jsp'" class="btn btn-secondary">Cancel</button>
                    </div>
                    <%
                            } else {
                    %>
                    <p class="warning-text">Customer not found.</p>
                    <button onclick="window.location.href='custList.jsp'" class="btn btn-secondary">Back to Customer List</button>
                    <%
                            }
                        } catch (SQLException e) {
                    %>
                    <p class="warning-text">Error: <%= e.getMessage() %></p>
                    <button onclick="window.location.href='custList.jsp'" class="btn btn-secondary">Back to Customer List</button>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <script>
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
<% } else {
    // No customer ID provided
    response.sendRedirect("custList.jsp");
} %> 