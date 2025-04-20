<%-- 
    Document   : logout
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Orders" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.*,java.time.format.*"%>
<%-- JSTL --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="model.Staff" %>
<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    } else if (!staff.isManager()) { //staff bye bye
        request.setAttribute("error", "403 Access Denied");
        request.getRequestDispatcher("err403.jsp").forward(request, response);
    }

    // Generate a CSRF token and store it in the session
    String csrfToken = java.util.UUID.randomUUID().toString();
    session.setAttribute("csrfToken", csrfToken);

    // Default title
    String reportTitle = (String) request.getAttribute("reportTitle");
    if (reportTitle == null) {
        reportTitle = "Monthly Sales Report";
    }
    
    // Get attributes from the servlet
    String reportType = (String) request.getAttribute("reportType");
    String monthParam = (String) request.getAttribute("monthParam");
    String dateParam = (String) request.getAttribute("dateParam");
    List<Map<String, Object>> sortedProducts = (List<Map<String, Object>>) request.getAttribute("sortedProducts");
    String errorMessage = (String) request.getAttribute("errorMessage");
    
    // If reportType is null, default to month
    if (reportType == null) {
        reportType = "month";
    }
    
    // If sortedProducts is null, create an empty list to avoid null pointer exceptions
    if (sortedProducts == null) {
        sortedProducts = new ArrayList<>();
    }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BT Staff - Reports</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/order.css">
        <style>

            @import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Roboto:ital,wght@0,100..900;1,100..900&display=swap');

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

            a[name~='back'] {
                color: rgb(103, 103, 103);
                font-size: 15px;
                font-weight: normal;
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

            .search-bar input[type=month], .search-bar input[type=date]{
                padding: 6px;
                margin-top: 8px;
                font-size: 17px;
                border: 1px solid black;
                color:rgb(186, 186, 186);
                width:10vw;
            }

            .report-title {
                text-align: center;
                margin-top: 20px;
                font-size: 24px;
                font-weight: bold;
            }

            .product-rank {
                font-weight: bold;
                text-align: center;
            }

            .product-name {
                font-weight: bold;
            }

            /* Updated table styling */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            table th, table td {
                padding: 15px;
            }

            table td {
                color: black;
                background-color: white;
            }

            table th {
                background-color:rgb(255, 255, 255);
                font-family: 'Roboto', sans-serif;
                text-align: left;
            }

            /* Total row - sky blue background */
            .total-row td {
                background-color:rgb(185, 232, 251);
                font-weight: bold;
            }

            /* Make sure report summary table uses the same styling */
            .report-summary {
                margin-top: 15px;
                padding: 15px;
                background-color: transparent;
                /*border-radius: 5px;
                border: 1px solid #ddd;
                box-shadow: 0 3px 6px rgba(0,0,0,0.1);*/
                max-width: 85%;
                margin-left: auto;
                margin-right: auto;
                padding-bottom: 0px;
            }

            .report-summary-table {
                width: 60%;
                border-collapse: collapse;
                background-color: white;
                border: 1px solid #ddd;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin: 0 auto;
            }

            .report-summary-table strong{
                font-family: 'Roboto', sans-serif;
            }

            .report-summary-table td {
                font-size: 18px;
                background-color: white;
                color: black;
                padding: 12px;
            }

            .ranking-table{
                border: 2px solid rgb(224, 224, 224) !important;
                border-radius:10px;
            }

            /* Override hover styles from order.css */
            .report-summary-table tr,
            .report-summary-table tr:hover {
                background-color: white !important;
                color: black !important;
            }

            /* Style the colon separator */
            .report-summary-table td:nth-child(2) {
                width: 20px;
                text-align: center;
                font-weight: bold;
            }

            /* Style the values */
            .report-summary-table td:nth-child(3) {
                font-weight: bold;
                color: rgb(0, 114, 163);
            }

            td.always-highlight{
                color: black;
                letter-spacing: 0.05em;
            }

            thead tr:nth-child(1){
                border-bottom: 2px solid rgb(224, 224, 224) !important;
            }

        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#search').on('input', function () {
                    if ($(this).val()) {
                        $(this).css('color', 'black'); // Set text color to black if input is valid
                    } else {
                        $(this).css('color', '#808080'); // Reset to placeholder color if input is empty
                    }
                });
                $('#searchDay').on('input', function () {
                    if ($(this).val()) {
                        $(this).css('color', 'black'); // Set text color to black if input is valid
                    } else {
                        $(this).css('color', '#808080'); // Reset to placeholder color if input is empty
                    }
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
                        <span>Generate</span>
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
                <strong><%= reportTitle%></strong>
            </div>
            <div class="main-content">
                <!-- Search Type Selector -->
                <div class="search-type-selector" style="text-align: center; margin-bottom: 15px;">
                    <label style="margin-right: 15px;">
                        <input type="radio" name="searchType" value="month" <%= "month".equals(reportType) ? "checked" : "" %>> Search by Month
                    </label>
                    <label>
                        <input type="radio" name="searchType" value="date" <%= "date".equals(reportType) ? "checked" : "" %>> Search by Date
                    </label>
                </div>
                
                <!-- Month selector -->
                <form method="post" action="ReportServlet" id="monthForm" style="display: <%= "month".equals(reportType) ? "block" : "none" %>;">
                    <div class="search-bar">
                        <!-- session token -->
                        <input type="hidden" name="csrfToken" value="<%= csrfToken%>" />
                        <input type="hidden" name="reportType" value="month" />
                        <input type="month" id="search" name="search" title="Select a month to generate report" required 
                               min="<%=java.time.YearMonth.now().minusYears(2).toString()%>" 
                               <% if (monthParam != null) {%>value="<%= monthParam%>"<% }%>
                               />
                        <button type="submit">&#128195; Generate Monthly Report</button>
                    </div>
                </form>
                
                <!-- DATE SELECTOR -->
                <form method="post" action="ReportServlet" id="dateForm" style="display: <%= "date".equals(reportType) ? "block" : "none" %>;">
                    <div class="search-bar">
                        <!-- session token -->
                        <input type="hidden" name="csrfToken" value="<%= csrfToken%>" />
                        <input type="hidden" name="reportType" value="date" />
                        <input type="date" id="searchDay" name="searchDay" 
                               title="Select a date to generate report" required
                               min="<%= java.time.LocalDate.now().minusYears(2).toString()%>"
                               <% if (dateParam != null) {%>value="<%= dateParam%>"<% }%>
                               />
                        <button type="submit">&#128195; Generate Daily Report</button>
                    </div>
                </form>
                
                <!-- JavaScript to toggle form visibility based on selection -->
                <script>
                    document.addEventListener('DOMContentLoaded', function() {
                        const radioButtons = document.querySelectorAll('input[name="searchType"]');
                        const monthForm = document.getElementById('monthForm');
                        const dateForm = document.getElementById('dateForm');
                        
                        // Function to toggle form visibility
                        function toggleForms() {
                            const selectedValue = document.querySelector('input[name="searchType"]:checked').value;
                            if (selectedValue === 'month') {
                                monthForm.style.display = 'block';
                                dateForm.style.display = 'none';
                            } else {
                                monthForm.style.display = 'none';
                                dateForm.style.display = 'block';
                            }
                        }
                        
                        // Add event listeners to radio buttons
                        radioButtons.forEach(button => {
                            button.addEventListener('change', toggleForms);
                        });
                    });
                </script>
                
                <%
                    if (errorMessage != null) {
                        out.println("<p class='no-results'>" + errorMessage + "</p>");
                    } else if ((monthParam == null && dateParam == null) || 
                             (("month".equals(reportType) && (monthParam == null || monthParam.trim().isEmpty())) || 
                              ("date".equals(reportType) && (dateParam == null || dateParam.trim().isEmpty())))) {
                        out.println("<p class='no-results' style='color:rgb(103, 103, 103); font-size:15px;font-weight:normal;'>Please select a " + 
                                 ("month".equals(reportType) ? "month" : "date") + 
                                 " to generate the report.</p>");
                    } else if (sortedProducts.isEmpty()) {
                        String timeframe = "month".equals(reportType) ? "month" : "date";
                        out.println("<p class='no-results'>No product sales found for this " + timeframe + ". Keep trying! &#129322;</p>");
                    } else {
                %>

                <% if (!sortedProducts.isEmpty()) {
                        // Calculate total quantities and revenue
                        int totalQuantity = 0;
                        double totalRevenue = 0.0;

                        for (Map<String, Object> product : sortedProducts) {
                            totalQuantity += (Integer) product.get("quantity");
                            totalRevenue += (Double) product.get("totalPrice");
                        }
                %>
                <div class="report-summary">
                    <table class="report-summary-table" style="width: 60%; border-collapse: collapse;">
                        <tr>
                            <td><strong>Total Products Sold</strong></td>
                            <td>:</td>
                            <td><%= totalQuantity%> units</td>
                        </tr>
                        <tr>
                            <td><strong>Total Revenue</strong></td>
                            <td>:</td>
                            <td>RM <%= String.format("%.2f", totalRevenue)%></td>
                        </tr>
                        <tr>
                            <td><strong>Number of Different Products Sold</strong></td>
                            <td>:</td>
                            <td><%= sortedProducts.size()%></td>
                        </tr>
                    </table>
                </div>
                <% } %>

                <table class="ranking-table">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>SKU</th>
                            <th>Product Name</th>
                            <th>Unit Price (RM)</th>
                            <th>Quantity Sold</th>
                            <th>Total Revenue (RM)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int rank = 1;
                            for (Map<String, Object> product : sortedProducts) {
                                String rowClass = rank <= 3 ? "highlight-row" : "";
                        %>
                        <tr class="<%= rowClass%>">
                            <td class="product-rank"><%= rank%></td>
                            <td class="always-highlight"  style="font-family: 'Courier New', monospace;"><%= product.get("sku")%></td>
                            <td class="product-name"><%= product.get("name")%></td>
                            <td><%= String.format("%.2f", (Double) product.get("price"))%></td>
                            <td style="text-align: center;"><%= product.get("quantity")%></td>
                            <td style="text-align: right;">
                                <%= String.format("%.2f", (Double) product.get("totalPrice"))%>
                            </td>
                        </tr>
                        <%
                                rank++;
                            }

                            // Add total row if there are products
                            if (!sortedProducts.isEmpty()) {
                                int totalQuantity = 0;
                                double totalRevenue = 0.0;

                                for (Map<String, Object> product : sortedProducts) {
                                    totalQuantity += (Integer) product.get("quantity");
                                    totalRevenue += (Double) product.get("totalPrice");
                                }
                        %>
                        <tr class="total-row">
                            <td colspan="4" style="text-align: right;"><strong>TOTAL</strong></td>
                            <td style="text-align: center;"><strong><%= totalQuantity%></strong></td>
                            <td style="text-align: right;"><strong>RM <%= String.format("%.2f", totalRevenue)%></strong></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="container" align="center" style="margin-top: 20px;">
                    <p class="copyright_text"><i>BalanceTiada</i> &copy; 2025 All Rights Reserved.</p>
                </div>
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