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
        <title>BT Staff</title>
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
                <strong>Enter New Product Details</strong>
            </div>
            <div class="main-content">

                <div class="product-form">
                    <%
                        if (request.getMethod().equals("POST")) {
                            String name = request.getParameter("name");
                            String stock = request.getParameter("stock");
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
                            }
                            else{
                                try{
                                    int categoryInt = Integer.parseInt(category);
                                    if(categoryInt < 1 || categoryInt > 3){
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
                                stockArray = new int[sizes.length]; // Initialize the stock array
                                int i = 0; // Initialize the index

                                for (String selectedSize : sizes) {

                                    String stockKey = "stock" + selectedSize;

                                    //get stock value from request parameter e.g. stockS, stockM, stockL, stockXL
                                    String stockValue = request.getParameter(stockKey);

                                    if (stockValue == null || stockValue.trim().isEmpty()) {
                                        errors.add("Stock for size " + selectedSize + " is required.");
                                    } else {
                                        try {
                                            int stockInt = Integer.parseInt(stockValue);
                                            if (stockInt < 0 || stockInt > 1000) {
                                                errors.add("Stock for size " + selectedSize + " must not exceed 1000 or be negative.");
                                            }
                                            else{//if stock is valid, add to stock array
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
                    <div class="error" >
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
                                // Process the form data (e.g., save to database)

                                //String sizesString = Toolkit.arrayToString(sizes);
                                //String stockString = Toolkit.arrayToString(stockArray);
                                
                                //no need to check as chances to collide are 1 in 10^16
                                String sku = Toolkit.generateUID();

                                Product product = new Product(sku,name, stockArray, description, Integer.parseInt(category), sizes, Double.parseDouble(price),0);
                                
                                // Set the product attribute
                                request.setAttribute("product", product);

                                // Forward the request to productImageUpload.jsp
                                RequestDispatcher dispatcher = request.getRequestDispatcher("productImageUpload.jsp");
                                dispatcher.forward(request, response);

                                    
                                out.println("<h3>Product submitted successfully!</h3>");
                                // Redirect or further processing can be done here
                            }
                        }
                    %>
                    <form method="POST">
                        <label for="name">Name:</label><br>
                        <input type="text" id="name" name="name" required><br><br>

                        <label for="description">Description:</label>
                        <textarea id="description" name="description" required rows="5" maxlength="100"></textarea><br><br>

                        <label for="catid">Category:</label>
                        <select id="catid" name="catid" required>
                            <option value="1">Men</option>
                            <option value="2">Women</option>
                            <option value="3">Kids</option>
                        </select><br><br>

                        <label for="size">Size:</label>
                        <div id="sizeContainer">
                            <div class="size-row">
                                <input type="checkbox" id="sizeS" name="size[]" value="S" onchange="toggleStockInput('S')">
                                <label for="sizeS">S</label>
                                <span id="stockInputS"></span>
                            </div>
                            <div class="size-row">
                                <input type="checkbox" id="sizeM" name="size[]" value="M" onchange="toggleStockInput('M')">
                                <label for="sizeM">M</label>
                                <span id="stockInputM"></span>
                            </div>
                            <div class="size-row">
                                <input type="checkbox" id="sizeL" name="size[]" value="L" onchange="toggleStockInput('L')">
                                <label for="sizeL">L</label>
                                <span id="stockInputL"></span>
                            </div>
                            <div class="size-row">
                                <input type="checkbox" id="sizeXL" name="size[]" value="XL" onchange="toggleStockInput('XL')">
                                <label for="sizeXL">XL</label>
                                <span id="stockInputXL"></span>
                            </div>
                        </div>

                        <label for="price">Price (RM):</label>
                        <input type="number" id="price" name="price" step="0.01" required min="0" max="1000"><br><br>

                        <button type="submit">Next</button>
                    </form>
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

            // Image preview function
            
        </script>
    </body>
</html>