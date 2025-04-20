package domain;

import da.OrdersDA;
import java.io.IOException;
import java.time.Month;
import java.sql.*;
import java.time.YearMonth;
import java.time.format.DateTimeParseException;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Orders;
import model.Product;

public class ReportServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                 
        // Initialize error message and default report title
        String errorMessage = null;
        String reportTitle = "Sales Report";
                 
        // Check for valid session first
        if (request.getSession(false) == null || request.getSession().getAttribute("staff") == null) {
            response.sendRedirect("home.jsp");
            return;
        }
        
        try {
            // Check if this is a valid session (basic CSRF protection)
            String csrfToken = request.getParameter("csrfToken");
            String sessionCsrfToken = (String) request.getSession().getAttribute("csrfToken");
    
            // Validate CSRF token
            if (csrfToken == null || sessionCsrfToken == null || !csrfToken.equals(sessionCsrfToken)) {
                errorMessage = "Invalid session token. Please try again.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("reportTitle", reportTitle);
                request.getRequestDispatcher("reports.jsp").forward(request, response);
                return;
            }
            
            // Get the report type (month or date)
            String reportType = request.getParameter("reportType");
            
            // Validate report type
            if (reportType == null || (!reportType.equals("month") && !reportType.equals("date"))) {
                errorMessage = "Invalid report type. Please use the form to generate a report.";
                request.setAttribute("errorMessage", errorMessage);
                request.setAttribute("reportType", "month");  // Default to month
                request.setAttribute("reportTitle", reportTitle);
                request.getRequestDispatcher("reports.jsp").forward(request, response);
                return;
            }
            
            // Get the current year and month as defaults
            final int CURRENT_YR = YearMonth.now().getYear();
            final int CURRENT_MTH = YearMonth.now().getMonthValue();
    
            int year = CURRENT_YR;
            int month = CURRENT_MTH;
            
            // Initialize collections for data
            ArrayList<Orders> ordersList = new ArrayList<>();
            Map<String, Map<String, Object>> productCountMap = new HashMap<>();
            
            OrdersDA ordersDA = new OrdersDA();
            
            // Process by report type (month or date)
            if ("month".equals(reportType)) {
                // Get the month parameter from the request
                String monthParam = request.getParameter("search");
                
                if (monthParam != null && !monthParam.trim().isEmpty()) {
                    try {
                        // Parse the year-month parameter
                        YearMonth inputYearMonth = YearMonth.parse(monthParam);
                        year = inputYearMonth.getYear();
                        month = inputYearMonth.getMonthValue();
                        
                        // Format the month name for display
                        reportTitle = Month.of(month).getDisplayName(TextStyle.FULL, Locale.getDefault()) 
                                      + " " + year + " Top Sales Product Report";
                        
                        // Get orders for the selected month/year
                        ordersList = ordersDA.getOrdersByMthYr(month, year);
                        
                        // Store the month parameter for form retention
                        request.setAttribute("monthParam", monthParam);
                    } catch (DateTimeParseException e) {
                        // Invalid format
                        errorMessage = "Invalid month format. Please select a valid month.";
                    }
                } else {
                    errorMessage = "Please select a month to generate the report.";
                }
            } else if ("date".equals(reportType)) {
                // Get the date parameter from the request
                String dateParam = request.getParameter("searchDay");
                
                if (dateParam != null && !dateParam.trim().isEmpty()) {
                    try {
                        // Parse the date parameter
                        java.time.LocalDate selectedDate = java.time.LocalDate.parse(dateParam);
                        
                        // Format title for display (e.g., "January 15, 2025 Daily Sales Report")
                        java.time.format.DateTimeFormatter formatter = 
                            java.time.format.DateTimeFormatter.ofPattern("MMMM d, yyyy", Locale.getDefault());
                        String formattedDate = selectedDate.format(formatter);
                        reportTitle = formattedDate + " Daily Sales Report";
                        
                        // Get orders for the selected date
                        ordersList = ordersDA.getOrdersByDate(dateParam);
                        
                        // Store the date parameter for form retention
                        request.setAttribute("dateParam", dateParam);
                    } catch (DateTimeParseException e) {
                        // Invalid format
                        errorMessage = "Invalid date format. Please select a valid date.";
                    }
                } else {
                    errorMessage = "Please select a date to generate the report.";
                }
            }
            
            // Process orders to count products (common for both month and date)
            for (Orders order : ordersList) {
                ArrayList<Product> products = order.getProducts();
                if (products != null) {
                    for (Product product : products) {
                        String sku = product.getSku().toUpperCase();
                        String name = product.getName();
                        int quantity = product.getStock()[0];
                        double totalPrice = product.getPrice() * quantity;
                        
                        // Add to map or update existing entry
                        if (productCountMap.containsKey(sku)) {
                            Map<String, Object> productInfo = productCountMap.get(sku);
                            int currentCount = (Integer) productInfo.get("quantity");
                            double currentTotal = (Double) productInfo.get("totalPrice");
                            
                            productInfo.put("quantity", currentCount + quantity);
                            productInfo.put("totalPrice", currentTotal + totalPrice);
                        } else {
                            Map<String, Object> productInfo = new HashMap<>();
                            productInfo.put("sku", sku);
                            productInfo.put("name", name);
                            productInfo.put("quantity", quantity);
                            productInfo.put("price", product.getPrice());
                            productInfo.put("totalPrice", totalPrice);
                            
                            productCountMap.put(sku, productInfo);
                        }
                    }
                }
            }
            
            // Sort products by quantity (most purchased first)
            List<Map<String, Object>> sortedProducts = new ArrayList<>(productCountMap.values());
            sortedProducts.sort(new Comparator<Map<String, Object>>() {
                @Override
                public int compare(Map<String, Object> o1, Map<String, Object> o2) {
                    Integer q1 = (Integer) o1.get("quantity");
                    Integer q2 = (Integer) o2.get("quantity");
                    return q2.compareTo(q1); // Descending order
                }
            });
            
            // Set attributes for the JSP
            request.setAttribute("reportTitle", reportTitle);
            request.setAttribute("reportType", reportType);
            request.setAttribute("sortedProducts", sortedProducts);
            if (errorMessage != null) {
                request.setAttribute("errorMessage", errorMessage);
            }
            
            // Forward to the reports.jsp page
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            
        } catch (ClassNotFoundException | SQLException e) {
            // Handle database errors
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.setAttribute("reportType", "month"); // Default to month
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        } catch (NullPointerException e) {
            // Handle null pointer exceptions (which could happen with invalid parameters)
            request.setAttribute("errorMessage", "Invalid request parameters. Please use the form to generate a report.");
            request.setAttribute("reportType", "month"); // Default to month
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        } catch (Exception e) {
            // Handle all other exceptions
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            request.setAttribute("reportType", "month"); // Default to month
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                doPost(request, response);
                // Do nothing
    }
} 