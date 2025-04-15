<%-- 
    Document   : logout
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null||staff.getName() == null) {
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
    <title>BT Staff</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="css/custlist.css">
    <style>
        td.button a {
            color: transparent;
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
            <strong>Customer List</strong>
        </div>
        <div class="main-content">
            <div class="search-bar">
                <input type="text" placeholder="Search.." name="search">
                <button type="submit"><i class="fa fa-search"></i></button>
            </div>
            <table>
                <thead>
                  <tr>
                    <th>CUST ID</th>
                    <th>FullName</th>
                    <th>LastName</th>
                    <th>EMAIL</th>
                    <th>PASSWORD</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="always-highlight">1392</td>
                    <td class="always-highlight">James Yates</td>
                    <td>
                      Web Designer
                      <span class="subtext">Far far away, behind the word mountains</span>
                    </td>
                    <td>+63 983 0962 971</td>
                    <td>NY University</td>
                    <td class="details-link">Details</td>
                  </tr>
                  <tr>
                    <td class="always-highlight">4616</td>
                    <td class="always-highlight">Matthew Wasil</td>
                    <td>
                      Graphic Designer
                      <span class="subtext">Far far away, behind the word mountains</span>
                    </td>
                    <td>+02 020 3994 929</td>
                    <td>London College</td>
                    <td class="details-link">Details</td>
                  </tr>
                </tbody>
              </table>
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
            if (i < 10) { i = "0" + i };  // add zero in front of numbers < 10
            return i;
        }
    </script>
</body>

</html>