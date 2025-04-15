<%-- 
    Document   : logout
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="domain.Toolkit" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        // Redirect to home.html if no user is logged in
        response.sendRedirect("home.jsp");
        return; // Stop further processing
    }

    // Initialize ProductDA and get all products
    ProductDA productDA = new ProductDA();
    List<Product> products = new ArrayList<>();
    try {
        String search = request.getParameter("search");
        if (search != null && !search.isEmpty()) {
            // If search parameter exists and is not empty, use srcProduct method
            products = productDA.srcProduct(search.toLowerCase());
        } else {
            // If no search parameter, get all products
            products = productDA.getAllProduct();
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
        <title>BT Staff</title>
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
                display: inline-block;
                background-color:rgb(0, 0, 0);
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
            }
            .edit-btn:hover{
                background-color: rgb(254, 254, 254);
                color: rgb(0, 0, 0);
            }
            .delete-btn{
                display: inline-block;
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

            a[href='addProduct.jsp']{
                color: rgb(0, 128, 255);
                font-size: 20px;
                font-weight: bold;
            }
            a[href='addProduct.jsp']:hover{
                color: rgb(0, 53, 106);
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

                    <!--Name-->
                    <span id="aName"><%= staff.getName()%></span>
                    <br /><br />


                    <i class="fa fa-sign-out" aria-hidden="true" onclick="logOut()" style="cursor: pointer;"></i>
                    <script>
                        function logOut() {
                            if (confirm("Are you sure want to logout?")) {
                                window.location.href = "logout.jsp";
                            }
                        }
                    </script>
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
                    <a href="report.jsp">
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
            </ul>
        </div>
        <div class="content">
            <div class="wrapper">
                <strong>Product List</strong>
            </div>
            <div class="main-content">
                <%--
                <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="get">
                    <input type="text" placeholder="Search.." name="src">
                    <button type="submit"><i class="ri-search-line"></i></button>
                    <?php
                    if(isset($_GET['src'])&&(!empty($_GET['src']))){
                            echo 'Showing results for "'. $_GET['src'].'"';
                    }
                    ?>
                </form>
                
                
                
                --%>
                <form action="prodList.jsp" method="get">
                    <div class="search-bar">
                        <input type="text" placeholder="Search.." name="search">
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </div>
                    <%

                        String search = request.getParameter("search");
                        int rsCount = products.size();

                        if (search != null && !search.isEmpty()) {
                            out.println("<p style='text-align: center;'>Showing " + rsCount + " results for \"" + search + "\". <br><a href='addProduct.jsp'>+ Add Product</a></p>");
                        }
                        else{
                            out.println("<p style='text-align: center;'>Showing " + rsCount + " results. <br><a href='addProduct.jsp'>+ Add Product</a></p>");
                        }
                    %>
                </form>
                <%
                    if (products.size() == 0) {
                        out.println("<p class='no-results' style='text-align: center;'>No results found! :(</p>");
                    } else {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>SKU</th>
                            <th>Name</th>
                            <th>File</th>
                            <th>Stock per Size</th>
                            <th>Description</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Sold</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Product product : products) {%>
                        <tr>
                            <td class="always-highlight"><%= product.getSku()%></td>
                            <td class="always-highlight"><%= product.getName()%></td>
                            <td>
                                <img src="upload/<%= product.getFile()%>" alt="Product Image" style="width: 100px; height: 100px;">
                            </td>
                            <td>
                                <%
                                    StringBuilder stockDisplay = new StringBuilder();
                                    String[] sizes = product.getSize();
                                    int[] stocks = product.getStock();

                                    for (int i = 0; i < sizes.length; i++) {
                                        stockDisplay.append("<b>" + sizes[i] + "</b>").append(" - ").append(stocks[i]).append("<br>");
                                    }
                                %>
                                <%= stockDisplay.toString()%></td>
                            <td>
                                <%= product.getDescription()%>
                            </td>
                            <td><%= product.getCatName()%></td>

                            <td>RM <%= String.format("%.2f", product.getPrice())%></td>

                            <td><%= product.getSold()%></td>
                            <td class="details-link">
                                <a class="edit-btn" href="editProduct.jsp?sku=<%= product.getSku()%>">Edit</a>
                                <a class="delete-btn" href="deleteProduct.jsp?sku=<%= product.getSku()%>" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
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