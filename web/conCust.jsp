<%-- 
    Document   : conCust
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
<jsp:useBean id="newCustomer" class="model.Customer" scope="request" />

<%
    //after confirm weed need this 
    String finalId = (String) request.getParameter("custId");
    String confirmed = request.getParameter("confirmed");

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

    // Check if we have either a new customer object or confirmation data
    if (newCustomer == null && finalId == null) {
        response.sendRedirect("addCust.jsp");
        return;
    }

    String dupError = "SQL0000000000-e8afc026-0196-011e-57be-ffffae0df08f";
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Confirm Customer Details</title>
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
            .table {
                width: 80vh;
                font-size: 1.2em;
                border-collapse: collapse;
                margin: 20px 0;
                border: 1px solid #ddd;
            }
            .table th {
                text-align: right;
                padding: 8px;
                margin: 20px 0;
            }
            .table td {
                text-align: left;
                padding: 8px;
                margin: 20px 0;
            }
            .error {
                border: 1px solid red;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(255, 196, 196);
                margin-bottom: 20px;
            }
            .success {
                border: 1px solid green;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(196, 255, 196);
                margin-bottom: 20px;
                text-align: center;
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
                <strong>Confirm Customer Details</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <%
                        if (request.getMethod().equals("POST") && "true".equals(confirmed)) {
                            try {
                                String fname = request.getParameter("fname");
                                String lname = request.getParameter("lname");
                                String email = request.getParameter("email");
                                String psw = request.getParameter("psw");

                                if (fname == null || lname == null || email == null || psw == null) {
                                    throw new SQLException("Missing required fields");
                                }

                                //at this point new customer may be null so we need to use
                                Customer nCustomer = new Customer(finalId, fname, lname, email, psw);
                                CustomerDA cda = new CustomerDA();
                                cda.addCustomer(nCustomer);
                    %>
                    <div class="success">
                        <h3>Customer <%= finalId%> added successfully!</h3>
                        <img src="media/hahayes.png" alt="Successful" style="width: 150px; height: 200px; margin: 10px 0;">
                        <br>
                        <button onclick="window.location.href = 'custList.jsp'" class="btn">Return to Customer List</button>
                    </div>
                    <%
                    } catch (SQLException e) {
                        String errorMsg = e.getMessage();
                        if (errorMsg.contains(dupError)) {
                            errorMsg = "Customer " + finalId + " ALREADY added.";
                        }
                    %>
                    <div class="error">
                        <h3>Error adding customer:</h3>
                        <p><%= errorMsg%></p>
                        <button onclick="window.location.href = 'addCust.jsp'" class="btn" style="margin-top:10px;">Try Again</button>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <table class="table">
                        <tr>
                            <th>Customer ID:</th>
                            <td><%= newCustomer.getCustid()%> <span style="font-size: 0.8em; color: #666;">(This cannot be changed!)</span></td>
                        </tr>
                        <tr>
                            <th>First Name:</th>
                            <td><%= newCustomer.getFname()%></td>
                        </tr>
                        <tr>
                            <th>Last Name:</th>
                            <td><%= newCustomer.getLname()%></td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td><%= newCustomer.getEmail()%></td>
                        </tr>
                    </table>

                    <form method="POST" id="confirmForm" action="conCust.jsp">
                        <input type="hidden" name="confirmed" value="true">
                        <input type="hidden" name="custId" value="<%= newCustomer.getCustid()%>">
                        <input type="hidden" name="fname" value="<%= newCustomer.getFname()%>">
                        <input type="hidden" name="lname" value="<%= newCustomer.getLname()%>">
                        <input type="hidden" name="email" value="<%= newCustomer.getEmail()%>">
                        <input type="hidden" name="psw" value="<%= newCustomer.getPsw()%>">
                        <button type="submit" class="btn">Confirm and Add Customer</button>
                    </form>
                    <br>
                    <button onclick="window.location.href = 'addCust.jsp'" class="btn" style="background-color: #6c757d;">Back to Edit</button>
                    <%
                        }
                    %>
                </div>
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