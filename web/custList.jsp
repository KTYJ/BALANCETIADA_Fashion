<%-- 
    Document   : logout
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Customer" %>
<%@ page import="da.CustomerDA" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    }

    // Initialize CustomerDA and get all customers or search results
    CustomerDA customerDA = new CustomerDA();
    List<Customer> customerList = null;
    try {
        String search = request.getParameter("search");
        if (search != null && !search.isEmpty()) {
            customerList = customerDA.srcCustomer(search.toLowerCase());
            System.out.println("Customer List: " + customerList);
        } else {
            customerList = customerDA.getAllCust();
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle error appropriately
    }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff</title>
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

            a[href='addCust.jsp']{
                color: rgb(0, 128, 255);
                font-size: 20px;
                font-weight: bold;
            }


            a[name='back']{
                color: rgb(103, 103, 103);
                font-size: 15px;
                font-weight: normal;
            }

            a[href='addCust.jsp']:hover{
                color: rgb(0, 53, 106);
            }
        </style>
        <script src="js/jquery-1.9.1.js"></script>
        <script>
            $(document).ready(function () {
                $('#togglePassword').click(function () {
                    const password = $('#pass');
                    const type = password.attr('type') === 'password' ? 'text' : 'password';
                    password.attr('type', type);

                    $(this).toggleClass('bi-eye');
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
                <strong>Customer List</strong>
            </div>
            <div class="main-content">
                <form action="custList.jsp" method="get">
                    <div class="search-bar">
                        <input type="text" placeholder="Search.." name="search">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                </form>

                <%
                    if (customerList == null || customerList.isEmpty()) {
                        out.println("<p class='no-results'>No customers found! :(</p>");
                        out.println("<div><a name='back' href='custList.jsp'><< Customer List</a></div>");
                        if (staff.getType().equalsIgnoreCase("manager")) {
                            out.println("<br><div style='text-align: center;'><a href='addCust.jsp'>+ Add Customer +</a></div>");
                        }
                    } else {
                        String search = request.getParameter("search");
                        String message = (search != null && !search.isEmpty())
                                ? "Showing " + customerList.size() + " results for \"" + search + "\"." //if search is set
                                : "Showing " + customerList.size() + " customer(s)."; //else

                        if (staff.getType().equalsIgnoreCase("manager")) {
                            message += "<br><a href='addCust.jsp'>+ Add Customer +</a>";
                        }

                        //build the whole message
                        out.println("<p style='text-align: center;'>" + message + "</p>");
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th style="text-align: center;"<% if (staff.getType().equalsIgnoreCase("manager")) { %> colspan="3" <% } %>>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Customer customer : customerList) {%>
                        <tr>
                            <td class="always-highlight"><%= customer.getCustid().toUpperCase()%></td>
                            <td class="always-highlight"><%= customer.getFname()%>
                                <span class="subtext"><%= customer.getLname()%> </span>
                            </td>
                            <td><%= customer.getEmail()%></td>
                            <td class="details-link" title="Check Orders" onclick="window.location.href = 'staffOrders.jsp?search=<%= customer.getCustid()%>'"><ion-icon name="cube-outline" style="font-size: 1.5rem;cursor: pointer;"></ion-icon></td>


                    <%
                        if (staff.getType().equalsIgnoreCase("manager")) {
                    %>
                    <!-- Manager Actions -->
                    <td style="color: rgb(1, 158, 237);" class="details-link" title="Edit Profile" onclick="window.location.href = 'editCustomer.jsp?custId=<%= customer.getCustid()%>'"><ion-icon name="create-outline" style="font-size: 1.5rem;cursor: pointer;"></ion-icon></td>
                    <td class="details-link" title="Delete" style="color:red" onclick="window.location.href = 'deleteCustomer.jsp?custId=<%= customer.getCustid()%>'"><ion-icon name="trash-outline" style="font-size: 1.5rem;cursor:pointer;"></ion-icon></td>
                        <%
                            }
                        %>
                    </tr>
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