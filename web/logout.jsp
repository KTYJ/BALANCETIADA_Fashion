<%-- 
    Document   : logout
    Created on : Apr 13, 2025, 8:12:00 PM
    Author     : KTYJ
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%
    // Invalidate the current session
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout SUCCESS</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    <style>

        @import url('https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&family=Special+Gothic+Condensed+One&display=swap');

        body {
            font-family: "Open Sans",sans-serif;
            text-align: center;
            margin-top: 50px;
            background-color: #f9f9f9;
        }
        .message {
            font-size: 20px;
            color: #333;
            margin-top: 20px;
          }
        .login-button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 18px;
            color: white;
            background-color:rgb(31, 31, 31);
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 1s ease;
        }
        .login-button:hover {
            background-color:rgb(191, 191, 191);
        }
        img {
            width: 45vh; /* Adjust size as needed */
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <a href="home.jsp.html"><img src="media/logout.jpg" alt="Logout Icon"></a>
    <div class="message">
        <h1>All done! Enjoy your day!</h1>
        <p>A bit more to do?</p>
        <a href="alogin.jsp" class="login-button">Login</a>
    </div>
</body>
</html>
