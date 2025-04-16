<%-- 
    Document   : addStaff
    Created on : Apr 11, 2025, 12:10:41 PM
    Author     : KTYJ
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.Toolkit" %>
<%@ page import="da.StaffDA" %>
<%@ page import="java.sql.SQLException" %>


<jsp:useBean id="staff" class="model.Staff" scope="session" />
<jsp:useBean id="newStaff" class="model.Staff" scope="request" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    }
    if (newStaff == null || newStaff.getName() == null) {
        response.sendRedirect("addStaff.jsp");
        return; // Stop further processing
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Staff Member</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/aproduct.css">
        <style>
            /* Preserve original form styles */
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
            .password-requirements {
                font-size: 0.8em;
                color: #666;
                margin-top: 5px;
            }

            /* Additional styles for error messages */
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

            .table{
                width: 80vh;
                font-size: 1.2em;
                border-collapse: collapse;
                margin: 20px 0;
                border: 1px solid #ddd;
            }

            .table th{
                text-align: right;
                padding: 8px;
                margin: 20px 0;
            }

            .table td{
                text-align: left;
                padding: 8px;
                margin: 20px 0;
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
                        if(staff.getType().equalsIgnoreCase("manager")){
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
                <strong>Are these details correct?</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <table class="table">
                        <tr>
                            <th>Staff ID:</th>
                            <td><%= newStaff.getStaffid() + "  "%><span style="font-size: 0.8em; color: #666;">(This cannot be changed!)</span></td>
                        </tr>
                        <tr>
                            <th>Name:</th>
                            <td><%= newStaff.getName()%></td>
                        </tr>
                        <tr>     
                            <th>Email:</th>
                            <td><%= newStaff.getEmail()%></td>
                        </tr>
                    </table>
                    <%-- Hidden fields --%>
                    <form method="POST" action="AddStaffServlet" id="uploadForm">
                        <input type="hidden" name="staffid" value="<%= newStaff.getStaffid()%>">
                        <input type="hidden" name="name" value="<%= newStaff.getName()%>">
                        <input type="hidden" name="email" value="<%= newStaff.getEmail()%>">
                        <input type="hidden" name="psw" value="<%= newStaff.getPsw()%>">
                        <input type="hidden" name="type" value="<%= newStaff.getType()%>">

                        <button type="submit" class="btn">Confirm and Add Staff Member</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
        

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
            a
        </script>
    </body>
</html>
