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
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
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
            </ul>
        </div>

        <div class="content">

            <div class="wrapper">
                <strong>Add New Staff Member</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <%
                        if (request.getMethod().equals("POST")) {
                            String name = request.getParameter("name");
                            String email = request.getParameter("email");
                            String psw = null;
                            String staffId = null;

                            ArrayList<String> errors = new ArrayList<>();

                            // Validate name
                            if (name == null || name.trim().isEmpty()) {
                                errors.add("Name is required.");
                            } else if (!name.matches("^[a-zA-Z0-9\\s]+$")) {
                                errors.add("Name can only contain letters, numbers, and spaces.");
                            }

                            // Validate email
                            if (email == null || email.trim().isEmpty()) {
                                errors.add("Email is required.");
                            } else {
                                try {
                                    // Check if email already exists
                                    StaffDA staffDA = new StaffDA();
                                    Staff existingStaff = staffDA.findByEmail(email);
                                    if (existingStaff != null) {
                                        errors.add("Email already exists.");
                                    }
                                } catch (SQLException e) {
                                    errors.add("Error checking email: " + e.getMessage());
                                }
                            }
                            try {
                                staffId = Toolkit.generateUniqueStaffId();
                                psw = Toolkit.hashPsw(staffId);
                                
                            } catch (SQLException e) {
                                errors.add("Error generating staff ID: " + e.getMessage());
                            }

                    %>
                    <% if (!errors.isEmpty()) { %>
                    <div class="error" >
                        <h3>Validation Errors:</h3>
                        <ul>
                            <% for (String error : errors) {%>
                            <li><%= error%></li>
                                <% } %>
                        </ul>
                    </div>

                    <% } else { %>
                    <div class="success">
                        <h3>Staff member ok.</h3>
                    </div>
                    <%
                                Staff newStaff = new Staff(staffId, name, email, psw, "staff");
                                request.setAttribute("newStaff", newStaff);
                                request.getRequestDispatcher("conStaff.jsp").forward(request, response);

                            }

                        }%>
                    <form id="addStaffForm"  method="POST">
                        <div class="form-group">
                            <label for="name">Full Name:</label>
                            <input type="text" id="name" name="name" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required>
                        </div>

                        <div class="form-group">
                            <label style="font-size: 12px; color: grey; font-weight: normal;">Password will be generated automatically.</label>
                        </div>

                        <button type="submit" class="btn">Add Staff Member</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Form 

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
