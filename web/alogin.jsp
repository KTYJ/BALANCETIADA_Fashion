<%-- 
    Document   : alogin
    Created on : Apr 1, 2025, 4:21:42 PM
    Author     : KTYJ
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true"%>

<jsp:useBean id="staff" class="model.Staff" scope="session" />

<%
    if (staff.getName() != null) {
        response.sendRedirect("custList.jsp"); // Redirect to login if logged in
        return; // Exit the page processing
    }

%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Special+Gothic+Condensed+One&display=swap" rel="stylesheet">

    <title>BALANCETIADA STAFF</title>

    <script src="js/jquery-1.9.1.js"></script>
    <script>
        $(document).ready(function () {
            $('#togglePassword').click(function () {
                const password = $('#pass');
                const type = password.attr('type') === 'password' ? 'text' : 'password';
                password.attr('type', type);

                $(this).toggleClass('bi-eye');
            });
        });
    </script>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Verdana, sans-serif;
            height: 100%;
            scrollbar-width: none;
            background:rgba(0, 0, 0, 0.27) url('media/adminbg.png') no-repeat ;
            background-size: cover;
            background-blend-mode: darken;
        }


        body::-webkit-scrollbar {
            display: none;
        }

        p.error {
            color: rgb(255, 84, 84);
            letter-spacing: 1.5px;
            font-family: 'Special Gothic Condensed One', sans-serif;
            font-weight: bold;
            animation: shake 0.8s;
            animation-iteration-count: 1;
        }

        @keyframes shake {
            0% {
                transform: translateX(0);
                color: red;
            }

            25% {
                transform: translateX(5px);
                color: white;
            }

            50% {
                transform: translateX(-5px);
                color: red;
            }

            75% {
                transform: translateX(5px);
                color: white;
            }

            100% {
                transform: translateX(0);
                color: red;
            }
        }

        .center {
            position: absolute;
            top: 50%;
            left: 50%;
            translate: -50% -50%;
            width: 500px;
            background: rgb(32, 31, 31);
        }

        .center h1 {
            font: 400 normal 50px 'Special Gothic Condensed One', sans-serif;
            color: rgb(255, 255, 255);
            text-align: center;
            margin: 0;
            padding: 20px 20px 0 20px;
            border-bottom: 1px solid transparent;
            text-decoration: none;
        }

        .center h2 {
            font: 400 normal 20px sans-serif;
            color: rgb(255, 255, 255);
            text-align: center;
            margin:0;
            text-decoration: none;
        }

        .center form {
            box-sizing: border-box;
            margin-top: 50px;
            padding: 0px 25px 30px 25px;
        }

        .txtfield {
            position: relative;
            border-bottom: 1.8px solid rgb(74, 72, 72);
            margin: 20px auto;
            width: 80%;
        }

        .txtfield input {
            width: 100%;
            height: 40px;
            font-size: 16px;
            border: none;
            background: none;
            outline: none;
            color: rgb(255, 255, 255);
            font-family: Georgia, 'Times New Roman', Times, sans-serif;


        }

        .txtfield label {
            position: absolute;
            top: 50%;
            color: rgb(92, 92, 92);
            translate: 0 -40%;
            transition: .5s all;
        }

        .txtfield i {
            color: rgb(255, 255, 255);
            position: absolute;
            cursor: pointer;
            margin: -30px 330px;
        }

        .txtfield span::before {
            content: '';
            position: absolute;
            top: 40px;
            left: 0px;
            width: 0%;
            height: 2.2px;
            background-color: rgb(255, 255, 255);
            transition: .5s all;
            translate: 0px 0.9px;
        }

        .txtfield input:focus~label,
        .txtfield input:not(:placeholder-shown)~label {
            top: -4px;
            color: rgb(255, 255, 255);
        }

        .txtfield input:focus~span::before,
        .txtfield input:not(:placeholder-shown)~span::before {
            width: 100%;
        }

        .login input {
            letter-spacing: 1px;
            font: 400 normal 20px 'Special Gothic Condensed One', sans-serif;
            background-color: rgb(0, 15, 15);
            border: none;
            border-radius: 10px;
            width: 100px;
            margin: auto;
            padding: 10px 10px;
            transition: 0.2s all;
            color: white;
        }

        .login input:hover {
            background-color: rgb(255, 255, 255);
            color: rgb(0, 0, 0);
        }

        .pass_txt {
            color: rgb(91, 91, 91);
        }

        .pass_txt a {
            text-decoration: none;
            color: rgb(91, 91, 91);
            transition: 0.2s all;
        }

        .pass_txt a:hover {
            color: rgb(255, 255, 255);
        }
    </style>
</head>

<body>
    <div class="center">
        <h1>BALANCETIADA</h1>
        <h2>STAFF PORTAL</h2>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
                <p align="center" class="error">${errorMessage}</p>
            <% } %>
        <form autocomplete="off" method="post" action="ALogin">
            <div class="txtfield">
                <input type="text" id="id" name="id" placeholder=" " required>
                <span></span>
                <label for="id">STAFF ID</label>
            </div>
            <div class="txtfield">
                <input type="password" name="psw" id="pass" placeholder=" " required>
                <i class="bi bi-eye-slash" id="togglePassword"></i>
                <span></span>
                <label for="pass">PASSWORD</label>
            </div>
            <div class="login" style="width:100%;text-align: center;margin: 30px 0px 20px 0px;">
                <input type="submit" value="LOGIN">
            </div>
            <div class="pass_txt" align="center" style="font-size: 11px;">
NOT AN ADMIN? <a href="Homepage.jsp"><b>CLICK HERE TO RETURN TO USER LOGIN</b></a>.            </div>
        </form>
    </div>
</body>

</html>