<%-- 
    Document   : editStaff
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

    // Use the staff bean directly instead of looking up by ID
    Staff staffToEdit = staff;
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit My Account</title>
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
            .success {
                border: 1px solid green;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(196, 255, 196);
                margin-bottom: 20px;
                text-align: center;
            }

            #conpsw {
                display: none;
                transition: all 10s ease;
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
                <strong>Edit My Account</strong>
            </div>
            <div class="main-content">
                <div class="container">
                    <div class="button-container" align="center">
                        <button onclick="window.location.href = 'staffList.jsp'" class="btn btn-secondary">Back to Staff List</button>
                    </div>

                    <%
                        if (request.getMethod().equals("POST")) {
                            Boolean newPsw = false;
                            String hashednewPsw = "";
                            String staffId = staffToEdit.getStaffid();

                            String name = request.getParameter("name");
                            String email = request.getParameter("email");
                            String psw = request.getParameter("psw");
                            String npsw = request.getParameter("npsw");
                            String cpsw = request.getParameter("cpsw");

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
                            } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                                errors.add("Invalid email format.");
                            } else {
                                try {
                                    // Check if email already exists for other staff members
                                    StaffDA staffDA = new StaffDA();
                                    Staff existingStaff = staffDA.findByEmail(email);
                                    if (existingStaff != null && !existingStaff.getStaffid().equals(staffToEdit.getStaffid())) {
                                        errors.add("Email already exists for another staff member.");
                                    }
                                } catch (SQLException e) {
                                    errors.add("Error checking email: " + e.getMessage());
                                }
                            }

                            // Validate current password
                            String hashedPsw = "";
                            if (psw == null || psw.trim().isEmpty()) {
                                errors.add("Current password is required.");
                            } else {
                                hashedPsw = Toolkit.hashPsw(psw);
                                
                                try {
                                    StaffDA staffDA = new StaffDA();
                                    Staff staffQ = staffDA.findbyIdAndPassword(staffToEdit.getStaffid(), hashedPsw);
                                    
                                    if (staffQ == null) {
                                        errors.add("Current password is incorrect. Try again.");
                                    }
                                } catch (SQLException e) {
                                    errors.add("Error checking current password: " + e.getMessage());
                                }
                            }

                            // Validate new password if provided
                            if (npsw != null && !npsw.trim().isEmpty()) {
                                if (cpsw == null || !npsw.equals(cpsw)) {
                                    errors.add("New password and confirmation do not match.");
                                } else {
                                    try {
                                        hashednewPsw = Toolkit.hashPsw(npsw);
                                        newPsw = true;
                                    } catch (Exception e) {
                                        errors.add("Error processing new password: " + e.getMessage());
                                    }
                                }
                            }
                    %>
                    <% if (!errors.isEmpty()) { %>
                    <div class="error">
                        <h3>Validation Errors:</h3>
                        <ul>
                            <% for (String error : errors) {%>
                            <li><%= error%></li>
                            <% } %>
                        </ul>
                    </div>
                    <% } else {
                        try {
                            String finalPassword = newPsw ? hashednewPsw : staffToEdit.getPsw();
                            Staff updatedStaff = new Staff(staffId, name, email, finalPassword, staffToEdit.getType());
                            StaffDA staffDA = new StaffDA();
                            staffDA.updateStaff(updatedStaff);
                            
                            // Update the session bean with new information
                            staff.setName(name);
                            staff.setEmail(email);
                            staff.setPsw(finalPassword);
                            
                            request.setAttribute("updateSuccess", true);
                    %>
                    <div class="success">
                        <h3>Account Information updated successfully!</h3>
                    </div>
                    <%
                        } catch (SQLException e) {
                    %>
                    <div class="error">
                        <h3>Error updating account:</h3>
                        <p><%= e.getMessage() %></p>
                    </div>
                    <%      
                        }
                    }
                }
                
                // Only show the form if update was not successful
                if (request.getAttribute("updateSuccess") == null) {
                %>
                    <form id="editStaffForm" method="POST" onsubmit="return confirm('Are you sure you want to update your account information?')">
                        <input type="hidden" name="staffId" value="<%= staffToEdit.getStaffid()%>">

                        <div class="form-group">
                            <label for="name">Full Name:</label>
                            <input type="text" id="name" name="name" value="<%= staffToEdit.getName()%>" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" value="<%= staffToEdit.getEmail()%>" required>
                        </div>

                        <div class="form-group">
                            <label for="psw">Current Password:</label>
                            <input type="password" id="curpsw" name="psw" required>
                        </div>

                        <div class="form-group">
                            <label for="npsw">New Password:</label>
                            <input type="password" id="npsw" name="npsw">
                            <small>(Leave blank to keep current password)</small>
                        </div>

                        <div class="form-group" id="conpsw">
                            <label for="cpsw">Confirm New Password:</label>
                            <input type="password" id="cpsw" name="cpsw">
                        </div>

                        <button type="submit" class="btn">Update My Account</button>
                    </form>
                <% } %>
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
        </script>
        <script>
            const newPasswordInput = document.getElementById("npsw");
            const confirmPassword = document.getElementById("conpsw");

            function toggleConfirmPasswordField() {
                if (newPasswordInput.value.trim() === "") {
                    confirmPassword.style.display = "none";
                } else {
                    confirmPassword.style.display = "block";
                }
            }

            // Initial state
            toggleConfirmPasswordField();

            // Listen for input changes
            newPasswordInput.addEventListener("input", toggleConfirmPasswordField);
        </script>
    </body>
</html> 