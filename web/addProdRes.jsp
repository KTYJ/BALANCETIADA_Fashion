<%-- 
    Document   : addProduct
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.Toolkit" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />

<%
    // Check if the staff object is set in the session
    Staff staffObj = (Staff) session.getAttribute("staff");
    if (staffObj == null || staffObj.getName() == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Get messages
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    boolean containsImage = false;

    if (successMessage != null && successMessage.toLowerCase().contains("image")) {
        containsImage = true;
    }
    
    

    // If no message, means no data was submitted, redirect to addProduct.jsp
    if (successMessage == null && errorMessage == null) {
        response.sendRedirect("addProduct.jsp");
        return;
    }

    String dupError = "INTERNAL ERROR: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL0000000007-2c864112-0196-011e-57be-ffffae0df08f' defined on 'PRODUCT'.";
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff</title>
        <link rel="stylesheet" href="css/aproduct.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <script>
            // Logout function
            function logOut() {
                if (confirm("Are you sure want to logout?")) {
                    window.location.href = "logout.jsp";
                }
            }
        </script>
        <style>
            .error{
                border: 1px solid red;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(255, 196, 196);

            }

            .error ul, .success ul{
                list-style-position: inside;
            }
            .success{
                border: 1px solid green;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(196, 255, 196);

            }

            .back{
                border-radius: 5px;
                border: 1px solid black;
                padding: 5px;
                display: block; 
                background-color:rgb(255, 255, 255);
                text-decoration: none;
                color: black;
                text-align: center;
                width: 100px;
                margin: 0 auto;
                
                transition: 0.3s ease-in-out;
            }

            .back:hover{
                color: rgb(255, 255, 255);
                background-color: rgb(0, 0, 0);
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
                <li>
                    <a href="editStaffOwn.jsp">    
                        <ion-icon name="create-outline" style="font-size: 1.5rem;"></ion-icon>
                        <span>Edit My Account</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="content">
            <div class="wrapper">
                <strong><%= (containsImage)? "Edit Product" :"Add New Product"%></strong>
            </div>
            <div class="main-content" align="center">

                <div class="product-form">
                    <% if (successMessage != null && !successMessage.isEmpty()) { %>

                        <div align="center" class="success" style="text-align: center;">
                            <h3><%= successMessage %></h3>
                            <img src="media/hahayes.png" alt="Sucessfull" style="width: 150px; height: 200px;">
                            
                        </div>
                        <a class="back" href="prodList.jsp">Back</a>
                    <% } else if (errorMessage != null && !errorMessage.isEmpty()) { %>
                    <div align="center" class="error" style="text-align: center;">
                        <h3>Error:</h3>
                        <% if (errorMessage.contains(dupError)) { %>
                            <h3>Product already added!</h3>
                        <% } else { %>
                            <h3><%= errorMessage %></h3><a href="prodList.jsp">Back</a>
                        <% 
                        
                            } %>
                    </div>
                    <a class="back" href="prodList.jsp">Back</a>
                    <% } %>
                </div>
            </div>
        </div>

        <script>

            // Clock and date function
            document.addEventListener('DOMContentLoaded', function() {
                startTime();
            });

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