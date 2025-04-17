<%-- 
    Document   : logout
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Orders" %>
<%@ page import="da.OrdersDA" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException" %>

<%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    }

    // Initialize OrdersDA and get all orders
    OrdersDA ordersDA = new OrdersDA();
    ArrayList<Orders> ordersList = new ArrayList<>();
    try {
        String search = request.getParameter("search");
        if (search != null && !search.isEmpty()) {
            // TODO: Implement search functionality if needed
            ordersList = ordersDA.getAllOrder(); // For now, show all orders
        } else {
            ordersList = ordersDA.getAllOrder();
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle error appropriately
        out.println("<div class='error-message'>Error loading orders: " + e.getMessage() + "</div>");
    }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff - Orders</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/custlist.css">
        <style>
            td.button a {
                color: transparent;
            }
            .no-results {
                color: red;
                font-size: 30px;
                font-weight: bold;
                text-align: center;
                margin-top: 30px;
            }

            [class^="status-"] a{
                min-width: 8vw;
                margin: 0;
                display: inline-block;
                background-color: white;
                padding: 5px 10px;
                border-radius: 15px;
                font-weight: bold;
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
  
        </style>
        <script>
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
                <strong>Customer Orders</strong>
            </div>
            <div class="main-content">
                <form action="staffOrders.jsp" method="get">
                    <div class="search-bar">
                        <input type="text" placeholder="Search.." name="search">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </form>

                <%
                    if (ordersList == null || ordersList.isEmpty()) {
                        out.println("<p class='no-results'>No orders found! :(</p>");
                    } else {
                        String search = request.getParameter("search");
                        String message = (search != null && !search.isEmpty())
                                ? "Showing " + ordersList.size() + " results for \"" + search + "\"."
                                : "Showing " + ordersList.size() + " order(s).";
                        out.println("<p style='text-align: center;'>" + message + "</p>");
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer ID</th>
                            <th>Order Date</th>
                            <th>Total</th>
                            <th style="text-align: right;">Shipping</th>
                            <th style="text-align: center;">Status</th>
                            <th colspan="2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Orders order : ordersList) {%>
                        <tr>
                            <td class="always-highlight"><%= order.getOrderId()%></td>
                            <td class="always-highlight"><%= order.getCustId()%></td>
                            <td>  
                                <%= new java.text.SimpleDateFormat("yy-MM-dd HH:mm").format(order.getOrderDate())%>
                            </td>
                            <td>MYR <%= String.format("%.2f", order.getTotal())%></td>
                            <td style="text-align: right;" class="always-highlight"><%= order.getShipping().substring(0, 1).toUpperCase() + order.getShipping().substring(1)%></td>
                            <td style="text-align: center;" class="status-<%= order.getStatus().toLowerCase()%>"><a><%= order.getStatus()%></a></td>
                            <td class="details-link" title="View Order Details">
                    <ion-icon name="cube-outline" style="font-size: 1.5rem; cursor: pointer;" onclick="window.location.href = 'viewOrder.jsp?orderId=<%= order.getOrderId()%>'"></ion-icon>
                    </td>
                    <td class="details-link" title="Edit Status">
                    <ion-icon name="create-outline" style="font-size: 1.5rem; cursor: pointer;" onclick="window.location.href = 'editOrderStatus.jsp?orderId=<%= order.getOrderId()%>'"></ion-icon>
                    </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% }%>
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
                i = "0" + i
            }
            ;  // add zero in front of numbers < 10
            return i;
        }
    </script>
</body>

</html>