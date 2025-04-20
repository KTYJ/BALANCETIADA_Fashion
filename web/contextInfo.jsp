<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Servlet Context Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .context-info {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .info-item {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h1>Servlet Context Information</h1>
    
    <div class="context-info">
        <%
            ServletContext context = request.getServletContext();
            
            // Get context attributes
            java.util.Enumeration<String> attributeNames = context.getAttributeNames();
        %>
        
        <h2>Context Path</h2>
        <div class="info-item">
            <%= context.getContextPath() %>
        </div>
        
        <h2>Server Info</h2>
        <div class="info-item">
            <%= context.getServerInfo() %>
        </div>
        
        <h2>Servlet Context Name</h2>
        <div class="info-item">
            <%= context.getServletContextName() != null ? context.getServletContextName() : "Not specified" %>
        </div>
        
        <h2>Major Version</h2>
        <div class="info-item">
            <%= context.getMajorVersion() %>
        </div>
        
        <h2>Minor Version</h2>
        <div class="info-item">
            <%= context.getMinorVersion() %>
        </div>
        
        <h2>Context Attributes</h2>
        <div class="info-item">
            <% while(attributeNames.hasMoreElements()) {
                String name = attributeNames.nextElement();
                Object value = context.getAttribute(name);
            %>
                <p><strong><%= name %>:</strong> <%= value != null ? value.toString() : "null" %></p>
            <% } %>
        </div>
        
        <h2>Real Path</h2>
        <div class="info-item">
            <%= context.getRealPath("/") %>
        </div>
    </div>
</body>
</html> 