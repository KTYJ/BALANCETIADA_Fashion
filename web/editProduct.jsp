<%-- 
Document   : editProduct
Created on : Apr 13, 2025, 8:12:00 PM
Author     : KTYJ
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="model.Staff" %>
<%@ page import="model.Product" %>
<%@ page import="da.ProductDA" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="domain.Toolkit" %>

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
        <title>BT Staff - Edit Product</title>
        <link rel="stylesheet" href="css/aproduct.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <style>
            .error{
                border: 1px solid red;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(255, 196, 196);
            }

            .error ul{
                list-style-position: inside;
            }

            .success {
                border: 1px solid green;
                padding: 10px;
                border-radius: 5px;
                background-color: rgb(196, 255, 196);
                margin-bottom: 20px;
                text-align: center;
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
                width: 50%;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .btn-secondary:hover {
                background-color:rgb(111, 193, 255);
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
                <strong>Editing Product: <span style="color:rgb(255, 0, 0);"><%= product.getSku().toUpperCase()%></span></strong>
            </div>
            <div class="main-content">
                <div class="product-form">
                    <div class="button-container" align="center">
                        <button onclick="window.location.href = 'prodList.jsp'" class="btn btn-secondary">Back to Product List</button>
                    </div>
                    <%
                        if (request.getMethod().equals("POST")) {
                            String name = request.getParameter("name");
                            String description = request.getParameter("description");
                            String category = request.getParameter("catid");
                            String[] sizes = request.getParameterValues("size[]");
                            String price = request.getParameter("price");

                            ArrayList<String> errors = new ArrayList<>();
                            int[] stockArray = {};

                            // Validate name
                            if (name == null || name.trim().isEmpty()) {
                                errors.add("Name is required.");
                            } else if (!name.matches("^[a-zA-Z0-9\\s]+$")) {
                                errors.add("Name can only contain letters, numbers, and spaces.");
                            }

                            // Validate description
                            if (description == null || description.trim().isEmpty()) {
                                errors.add("Description is required.");
                            }

                            // Validate category
                            if (category == null || category.trim().isEmpty()) {
                                errors.add("Category is required.");
                            } else {
                                try {
                                    int categoryInt = Integer.parseInt(category);
                                    if (categoryInt < 1 || categoryInt > 3) {
                                        errors.add("Category must be a valid number.");
                                    }
                                } catch (NumberFormatException e) {
                                    errors.add("Category must be a valid number.");
                                }
                            }

                            // Validate size
                            if (sizes == null || sizes.length == 0) {
                                errors.add("At least one size must be selected.");
                            }

                            // Validate price
                            if (price == null || price.trim().isEmpty()) {
                                errors.add("Price is required.");
                            } else {
                                try {
                                    double priceValue = Double.parseDouble(price);
                                    if (priceValue < 0 || priceValue > 1000) {
                                        errors.add("Price must be a positive number and not exceed 1000.");
                                    }
                                } catch (NumberFormatException e) {
                                    errors.add("Price must be a valid number.");
                                }
                            }

                            // Validate stock for each size
                            if (sizes != null) {
                                stockArray = new int[sizes.length];
                                int i = 0;

                                for (String selectedSize : sizes) {
                                    String stockKey = "stock" + selectedSize;
                                    String stockValue = request.getParameter(stockKey);

                                    if (stockValue == null || stockValue.trim().isEmpty()) {
                                        errors.add("Stock for size " + selectedSize + " is required.");
                                    } else {
                                        try {
                                            int stockInt = Integer.parseInt(stockValue);
                                            if (stockInt < 0 || stockInt > 1000) {
                                                errors.add("Stock for size " + selectedSize + " must not exceed 1000 or be negative.");
                                            } else {
                                                stockArray[i] = stockInt;
                                                i++;
                                            }
                                        } catch (NumberFormatException e) {
                                            errors.add("Stock for size " + selectedSize + " must be a valid number.");
                                        }
                                    }
                                }
                            }

                            if (!errors.isEmpty()) {
                    %>
                    <div class="error">
                        <h3>Validation Errors:</h3>
                        <ul>
                            <%
                                for (String error : errors) {
                                    out.println("<li>" + error + "</li>");
                                }
                            %>
                        </ul>
                    </div>
                    <%
                            } else {
                                // Update the product
                                product.setName(name);
                                product.setDescription(description);
                                product.setCatId(Integer.parseInt(category));
                                product.setSize(sizes);
                                product.setStock(stockArray);
                                product.setPrice(Double.parseDouble(price));

                                System.out.println(product);

                                String uploadErr = "";
                                try {
                                    productDA.updateProduct(product);
                                    request.setAttribute("updateSuccess", true);
                                } catch (SQLException e) {
                                    uploadErr = e.getMessage();
                                    request.setAttribute("uploadErr", uploadErr);
                                }
                                //response.sendRedirect("prodList.jsp");
                            }
                        }
                    %>

                    <% if (request.getAttribute("updateSuccess") != null) {
                            if (request.getAttribute("updateSuccess").equals(true)) {

                    %>
                    <div class="success">
                        <h3>Product <%= product.getSku().toUpperCase()%> updated successfully!</h3>
                    </div>
                    <div align="center">
                        <img src="media/hahayes.png" alt="Sucessfull" style="width: 150px; height: 200px;">
                    </div>
                    <% } else if (request.getAttribute("uploadErr") != null) {
                    %>
                    <div class="error">
                        <h3>Error updating product: <%= request.getAttribute("uploadErr")%></h3>
                    </div>
                    <%
                        }
                    %>
                    <% } else {%>
                    <form method="POST" onsubmit="return confirm('Are you sure you want to update THIS INFORMATION?')">
                        <div style="display:flex; justify-content:center; align-items:center; margin: 0 auto;">
                            <img src="upload/<%= product.getFile()%>" width="200px" height="200px">
                        </div>
                        <br/>
                        <div>
                            <input type="hidden" id="sku" name="sku" value="<%= product.getSku()%>" readonly><br><br>
                            <label for="name">Name:</label><br>
                            <input type="text" id="name" name="name" value="<%= product.getName()%>" required><br><br>

                            <label for="description">Description:</label>
                            <textarea id="description" name="description" required rows="5" maxlength="100"><%= product.getDescription()%></textarea><br><br>

                            <label for="catid">Category:</label>
                            <select id="catid" name="catid" required>
                                <option value="1" <%= product.getCatId() == 1 ? "selected" : ""%>>Men</option>
                                <option value="2" <%= product.getCatId() == 2 ? "selected" : ""%>>Women</option>
                                <option value="3" <%= product.getCatId() == 3 ? "selected" : ""%>>Kids</option>
                            </select><br><br>

                            <label for="size">Size:</label>
                            <div id="sizeContainer">
                                <%
                                    String[] existingSizes = product.getSize();
                                    int[] existingStock = product.getStock();
                                    String[] allSizes = {"S", "M", "L", "XL"};

                                    for (int i = 0; i < allSizes.length; i++) {
                                        String currentSize = allSizes[i];
                                        boolean isChecked = false;
                                        int stockValue = 0;

                                        // Find if this size exists in the product's sizes
                                        for (int j = 0; j < existingSizes.length; j++) {
                                            if (existingSizes[j].equals(currentSize)) {
                                                isChecked = true;
                                                stockValue = existingStock[j];
                                                break;
                                            }
                                        }
                                %>
                                <div class="size-row">
                                    <input type="checkbox" id="size<%= currentSize%>" name="size[]" value="<%= currentSize%>" 
                                           onchange="toggleStockInput('<%= currentSize%>')" <%= isChecked ? "checked" : ""%>>
                                    <label for="size<%= currentSize%>"><%= currentSize%></label>
                                    <span id="stockInput<%= currentSize%>">
                                        <% if (isChecked) {%>
                                        <input type="number" id="stock<%= currentSize%>" name="stock<%= currentSize%>" 
                                               value="<%= stockValue%>" min="0" max="1000" required>
                                        <% } %>
                                    </span>
                                </div>
                                <%
                                    }
                                %>
                            </div>

                            <label for="price">Price (RM):</label>
                            <input type="number" id="price" name="price" step="0" required min="0" max="1000" 
                                   value="<%= product.getPrice()%>"><br><br>

                            <button type="submit">Update Product</button>
                    </form>
                    <% }%>
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
            document.addEventListener('DOMContentLoaded', function () {
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

            function toggleStockInput(size) {
                const checkbox = document.getElementById('size' + size);
                const stockContainer = document.getElementById('stockInput' + size);

                if (checkbox.checked) {
                    // Create new stock input
                    const stockInput = document.createElement('input');
                    stockInput.type = 'number';
                    stockInput.id = 'stock' + size;
                    stockInput.name = 'stock' + size;
                    stockInput.min = '0';
                    stockInput.max = '1000';
                    stockInput.required = true;
                    stockInput.placeholder = 'Stock for ' + size;

                    // Add the input to the container
                    stockContainer.appendChild(stockInput);
                } else {
                    // Remove the stock input
                    stockContainer.innerHTML = '';
                }
            }
        </script>
    </body>
</html> 