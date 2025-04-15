<%-- 
    Document   : staffList
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="da.StaffDA" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    }

    // Initialize StaffDA and get all staff members
    StaffDA staffDA = new StaffDA();
    List<Staff> staffList = new ArrayList<>();
    try {
        String search = request.getParameter("search");
        if (search != null && !search.isEmpty()) {
            // For now, get all staff since search not yet implemented in StaffDA
            //update: already dunnit
            staffList = staffDA.srcStaff(search);
        } else {
            staffList = staffDA.findAllStaff();
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff - Staff List</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/custlist.css">
        <style>
            td.button a {
                color: transparent;
            }
            .no-results{
                color: red;
                font-size: 30px;
                font-weight: bold;
                text-align: center;
                margin-top: 30px;
            }
            .edit-btn{
                margin-top: 0;
                display: inline-block;
                width: 30%;
                background-color:rgb(0, 0, 0);
                color: white;
                margin-right: 10px;
                padding: 10px 20px;
                border-radius: 5px;
            }
            .edit-btn:hover{
                background-color: rgb(254, 254, 254);
                color: rgb(0, 0, 0);
            }
            .delete-btn{
                text-align: center;
                margin-top: 0;
                display: inline-block;
                width: 50%;
                background-color: #dc3545;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
            }
            .delete-btn:hover{
                background-color: rgb(126, 0, 0);
                color: rgb(0, 0, 0);
            }

            td a{
                text-align: center;
                width: 100%;
                margin-top: 10px;
                font-size: 15px;
                text-decoration: none;
            }

            td a:hover{
                color: rgb(65, 65, 65);
            }

            a[href='addStaff.jsp']{
                color: rgb(0, 128, 255);
                font-size: 20px;
                display: block;
                font-weight: bold;
            }
            a[href='addStaff.jsp']:hover{
                color: rgb(0, 53, 106);
            }

            td, th{
                padding: 5px 10px;
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
                <strong>Staff List</strong>
            </div>
            <div class="main-content">
                <form action="staffList.jsp" method="get">
                    <div class="search-bar">
                        <input type="text" placeholder="Search.." name="search">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                    <%
                        String search = request.getParameter("search");

                        // Calculate visible staff count (excluding current user)
                        int visibleCount = 0;
                        for (Staff s : staffList) {
                            if (!s.getStaffid().equals(staff.getStaffid())) {
                                visibleCount++;
                            }
                        }
                    %>
                </form>
                <%
                    if (visibleCount == 0) {
                        out.println("<p class='no-results' style='text-align: center;'>No results found! :(</p>");
                        out.println("<br><div style='text-align: center;'><a href='addStaff.jsp'>+ Add Staff +</a></div>");
                    } else {
                        if (search != null && !search.isEmpty()) {
                            out.println("<p style='text-align: center;'>Showing " + visibleCount + " results for \"" + search + "\". <br><a href='addStaff.jsp'>+ Add Staff</a></p>");
                        }
                        else{
                            out.println("<p style='text-align: center;'>Showing " + visibleCount + " results. <br><a href='addStaff.jsp'>+ Add Staff</a></p>");
                        }
                    
                %>
                <table>
                    <thead>
                        <tr>
                            <th>Staff ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Type</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Staff s : staffList) {%>

                            <!-- Display staff members except the current staff member -->
                            <% if (!s.getStaffid().equals(staff.getStaffid())) { 
                                visibleCount++;
                            %>
                        <tr>
                            <td class="always-highlight"><%= s.getStaffid()%></td>
                            <td class="always-highlight"><%= s.getName()%></td>
                            <td><%= s.getEmail()%></td>
                            <td><%= s.getType().toUpperCase()%></td>
                            <td class="details-link">
                                <div class="button-container" align="center">
                                    <a class="edit-btn" href="editStaff.jsp?staffId=<%= s.getStaffid()%>">Edit</a>
                                    <a class="delete-btn" href="deleteStaff.jsp?staffId=<%= s.getStaffid()%>">Delete</a>
                                </div>
                                <% } %>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
                <%
                    }
                %>
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