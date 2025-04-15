<%-- 
    Document   : editProdImg
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="model.Staff" %>
<%@ page import="model.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page import="java.sql.SQLException" %>

<jsp:useBean id="staff" class="model.Staff" scope="session" />
<%
    // Check if the staff object is set in the request
    if (staff == null || staff.getName() == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    // Get the product SKU from request parameter
    String sku = request.getParameter("sku");
    if (sku == null || sku.trim().isEmpty()) {
        response.sendRedirect("prodList.jsp");
        return;
    }

    // Initialize ProductDA and get the product
    ProductDA productDA = new ProductDA();
    Product product = productDA.getProduct(sku);
    
    if (product == null) {
        response.sendRedirect("prodList.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Product Image</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="css/aproduct.css">
        <style>
            #displayFiles {
                width: 375px;
                height: 200px;
                border: 1px solid #ccc;
                background-size: cover;
                background-position: center;
                margin: 10px 0;
                transform: translateX(28vh);
            }

            .product-form {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                max-width: 800px;
                margin: 0 auto;
            }

            .product-form label {
                display: inline-block;
                width: 120px;
                margin-bottom: 10px;
            }

            .product-form input[type="file"] {
                width: 300px;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .product-form button[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }

            .product-form button[type="submit"]:hover {
                background-color: #45a049;
            }

            button[name="sbm"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }   
            button[name="sbm"]:hover {
                background-color:rgb(45, 105, 48);
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
            </ul>
        </div>

        <div class="content">
            <div class="wrapper">
                <strong>Edit Product Image - <%= product.getSku().toUpperCase()%></strong>
            </div>
            <div class="main-content">
                <div class="product-form">
                    <div class="product-info" align="center">
                        <a href="prodList.jsp" class="button" style="display: block;text-align: left;text-decoration: underline;color: black;"><< Back to Product List</a>
                        <table class="prodTable">
                            <tr>
                                <th>SKU:</th>
                                <td><%= product.getSku()%></td>
                            </tr>
                            <tr>
                                <th>Name:</th>
                                <td><%= product.getName()%></td>
                            </tr>
                            <tr>
                                <th>Current Image:</th>
                                <td><img src="upload/<%= product.getFile() %>" width="100px" height="100px"></td>
                            </tr>
                        </table>
                    </div>
                    <div class="filefile-form">
                    <form method="POST" action="UploadServletSimple" enctype="multipart/form-data" align="center" id="uploadForm">
                    
                    <%-- Hidden fields --%>
                    <input type="hidden" name="sku" value="<%= product.getSku() %>">

                        <div class="file-form" style="margin-bottom: 0;">
                            
                            <label for="file">New Image:</label>
                            <input type="file" id="file" name="file" required>
                        </div>
                        <br><br>
                        <div id="displayFiles"></div>
                        <button type="button" name="sbm" onclick="confirmAndSubmit()">Submit</button>
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

            // Image preview function
            document.addEventListener('DOMContentLoaded', function () {
                const fileInput = document.querySelector('#file');
                const displayFiles = document.querySelector('#displayFiles');

                fileInput.addEventListener('change', function () {
                    displayFiles.innerHTML = '';

                    Array.from(fileInput.files).forEach(file => {
                        const reader = new FileReader();

                        reader.onload = function (e) {
                            const img = document.createElement('img');
                            img.alt = "Product Image Preview";
                            img.src = e.target.result;
                            img.style.width = '100px';
                            img.style.margin = '5px';
                            displayFiles.appendChild(img);
                        };

                        reader.readAsDataURL(file);
                    });
                });
            });

            function validateForm() {
                const fileInput = document.getElementById('file');
                
                // Check if files are selected
                if (!fileInput.files || fileInput.files.length === 0) {
                    alert("Please select at least one image file.");
                    return false;
                }

                // Check file types
                const allowedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
                for (let i = 0; i < fileInput.files.length; i++) {
                    const file = fileInput.files[i];
                    if (!allowedTypes.includes(file.type)) {
                        alert("Invalid file type. Please upload only image files (JPEG, PNG, JPG, GIF).");
                        return false;
                    }

                    // Check file size (max 10MB)
                    const maxSize = 10 * 1024 * 1024; // 10MB in bytes
                    if (file.size > maxSize) {
                        alert("File size too large. Maximum file size is 10MB.");
                        return false;
                    }
                }

                return true;
            }

            function confirmAndSubmit() {
                if (validateForm()) {
                    if (confirm("Are you sure you want to upload this image?")) {
                        document.getElementById('uploadForm').submit();
                    }
                }
            }
        </script>
    </body>
</html> 