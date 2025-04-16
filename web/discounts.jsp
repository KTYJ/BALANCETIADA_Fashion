<%-- 
    Document   : discounts
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Discount" %>
<%@ page import="da.DiscountDA" %>
<%@ page import="java.util.List" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Initialize DiscountDA and get all discounts
    DiscountDA discountDA = new DiscountDA();
    List<Discount> discountList;
    try {
        String search = request.getParameter("search");
        if (search != null && !search.isEmpty()) {
            discountList = discountDA.searchDiscounts(search);
        } else {
            discountList = discountDA.getAllDiscount();
        }
    } catch (Exception e) {
        e.printStackTrace();
        discountList = List.of(); // Empty list if error occurs
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff - Discount Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/custlist.css">
        <style>
            .no-results {
                color: red;
                font-size: 30px;
                font-weight: bold;
                text-align: center;
                margin-top: 30px;
            }
            .edit-btn {
                margin-top: 0;
                display: inline-block;
                width: 30%;
                background-color: rgb(0, 0, 0);
                color: white;
                margin-right: 10px;
                padding: 10px 20px;
                border-radius: 5px;
            }
            .edit-btn:hover {
                background-color: rgb(254, 254, 254);
                color: rgb(0, 0, 0);
            }
            .delete-btn {
                text-align: center;
                margin-top: 0;
                display: inline-block;
                width: 50%;
                background-color: #dc3545;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
            }
            .delete-btn:hover {
                background-color: rgb(126, 0, 0);
                color: rgb(0, 0, 0);
            }
            td a {
                text-align: center;
                width: 100%;
                margin-top: 10px;
                font-size: 15px;
                text-decoration: none;
            }
            td a:hover {
                color: rgb(65, 65, 65);
            }
            a[href='addDiscount.jsp'] {
                color: rgb(0, 128, 255);
                font-size: 20px;
                display: block;
                font-weight: bold;
            }
            a[href='addDiscount.jsp']:hover {
                color: rgb(0, 53, 106);
            }
            td, th {
                padding: 5px 10px;
            }
            .type-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 15px;
                font-weight: bold;
                text-align: center;
                min-width: 80px;
            }
            .type-percentage {
                background-color: #e3fcef;
                color: #00a854;
            }
            .type-amount {
                background-color: #fff7e6;
                color: #fa8c16;
            }
            .value-cell {
                font-weight: bold;
                text-align: right;
            }
        </style>
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
                <strong>Discount Management</strong>
            </div>
            <div class="main-content">
                <form action="discounts.jsp" method="get">
                    <div class="search-bar">
                        <input type="text" placeholder="Search discounts..." name="search">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </form>

                <%
                    if (discountList.isEmpty()) {
                %>
                <p class="no-results">No discounts found! :(</p>
                <br><div style="text-align: center;"><a href="addDiscount.jsp">+ Add Discount +</a></div>
                <%
                } else {
                    String search = request.getParameter("search");
                    if (search != null && !search.isEmpty()) {
                        out.println("<p style='text-align: center;'>Showing " + discountList.size() + " results for \"" + search + "\". <br><a href='addDiscount.jsp'>+ Add Discount +</a></p>");
                    } else {
                        out.println("<p style='text-align: center;'>Showing " + discountList.size() + " discounts. <br><a href='addDiscount.jsp'>+ Add Discount +</a></p>");
                    }
                %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Code</th>
                            <th>Type</th>
                            <th>Value</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Discount discount : discountList) { %>
                        <tr>
                            <td class="always-highlight"><%= discount.getId() %></td>
                            <td class="always-highlight"><%= discount.getCode() %></td>
                            <td>
                                <span class="type-badge <%= discount.getType().equals("P") ? "type-percentage" : "type-amount" %>">
                                    <%= discount.getType().equals("P") ? "Percentage" : "Amount" %>
                                </span>
                            </td>
                            <td class="value-cell">
                                <%= discount.getValue() %><%= discount.getType().equals("P") ? "%" : " RM" %>
                            </td>
                            <td><%= discount.getDescription() %></td>
                            <td class="details-link">
                                <div class="button-container" align="center">
                                    <a class="edit-btn" href="editDiscount.jsp?id=<%= discount.getId() %>">Edit</a>
                                    <a class="delete-btn" href="deleteDiscount.jsp?id=<%= discount.getId() %>">Delete</a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } %>
            </div>
        </div>

        <script>
            // Logout function
            function logOut() {
                if (confirm("Are you sure want to logout?")) {
                    window.location.href = "logout.jsp";
                }
            }

            // Clock and date function
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