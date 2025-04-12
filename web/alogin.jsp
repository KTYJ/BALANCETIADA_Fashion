<%-- 
    Document   : alogin
    Created on : Apr 1, 2025, 4:21:42 PM
    Author     : KTYJ
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%@ page import = "java.sql.*"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css" />
    <title>SuperUser Login</title>
    
    <script src="../JAVAs/jquery-1.9.1.js"></script>
    <script>
    $(document).ready(function() {
        $('#togglePassword').click(function() {
            const password = $('#pass');
            const type = password.attr('type') === 'password' ? 'text' : 'password';
            password.attr('type', type);

            $(this).toggleClass('bi-eye');
        });
    });
    </script>
    
    <style>
        body{
            margin:0;
            padding: 0;
            font-family: Tahoma, Geneva, Verdana, sans-serif;
            height: 100%;
            scrollbar-width: none;
            background: url(../Media/adminbg.jpg) repeat fixed;
        }

        body::-webkit-scrollbar{
            display: none;
        }

        p.error{
            color: red;
            font-weight: bold;
            animation: shake 0.3s;
            animation-iteration-count: 3;
        }
        @keyframes shake {
            0% { transform: translateX(0); color: red;}
            25% { transform: translateX(5px); color: white;}
            50% { transform: translateX(-5px); color: red;}
            75% { transform: translateX(5px); color: white;}
            100% { transform: translateX(0); color: red;}
        }
        .center{
            position: absolute;
            top: 50%;
            left: 50%;
            translate: -50% -50%;
            width: 500px;
            background: white;
        }

        .center h3{
            background-color: rgb(27, 91, 89);
            font-weight:90;
            font-size: 30px;
            color: white;
            text-align: center;
            margin: 0;
            padding: 50px 20px;
            border-bottom: 1px solid transparent;
            text-decoration: underline;
        }

        .center form{
            box-sizing: border-box;
            margin-top: 50px;
            padding: 0px 25px 30px 25px;
        }

        .txtfield{
            position: relative;
            border-bottom: 1.8px solid rgb(178, 178, 178);
            margin: 20px auto;
            width: 80%;
        }

        .txtfield input{
            width: 100%;
            height: 40px;
            font-size: 16px;
            border: none;
            background: none;
            outline: none;
            
        }
        .txtfield label{
            position: absolute;
            top: 50%;
            color: rgb(205, 203, 203);
            translate: 0 -40% ;
            transition: .5s all;
        }

        .txtfield i{
            position: absolute;
            cursor: pointer;
            margin: -30px 330px;
        }

        .txtfield span::before{
            content: '';
            position: absolute;
            top: 40px;
            left: 0px;
            width: 0%;
            height: 2.2px;
            background-color: rgb(66, 108, 147);
            transition: .5s all;
            translate: 0px 0.9px;
        }

        .txtfield input:focus ~ label,
        .txtfield input:not(:placeholder-shown) ~ label{
            top: -4px ;
            color: rgb(66, 108, 147);
        }
        .txtfield input:focus ~ span::before,
        .txtfield input:not(:placeholder-shown) ~ span::before{
            width: 100%;
        }

        .login input{
            background-color: rgb(2, 87, 87);
            border: none;
            border-radius: 10px;
            width: 100px;
            margin: auto;
            padding: 10px 30px;
            transition: 0.5s all;
            color: white;
        }

        .login input:hover{
            background-color: rgb(7, 179, 179);
        }

        .pass_txt a{text-decoration:none ;color: black; transition: 0.2s all;}
        .pass_txt a:hover{color: rgb(14, 152, 226); }
    </style>
</head>
<body>
    <div class="center">
        <h3>BALANCETIADA STAFF PORTAL</h3>
        <%
            // Handle login attempt
            String error = null;
            if(request.getMethod().equalsIgnoreCase("POST")) {
                String id = request.getParameter("id");
                String psw = request.getParameter("psw");
                
                if(id != null && !id.isEmpty() && psw != null && !psw.isEmpty()) {
                    // Hash the password
                    String spsw = org.apache.commons.codec.digest.DigestUtils.sha1Hex(psw);

                    
                    try {
                        Connection con = DriverManager.getConnection("jdbc:derby://localhost:3306/btd", "nbuser", "nbuser");
                        String sql = "SELECT * FROM admin WHERE adminID=? AND password=?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, id);
                        ps.setString(2, spsw);
                        ResultSet rs = ps.executeQuery();

                        if(rs.next()) {
                            session.setAttribute("admin_id", rs.getString("adminID"));
                            rs.close();
                            con.close();
                            response.sendRedirect("adminh.jsp");
                        } else {
                            error = "Incorrect ID or Password.";
                        }
                    } catch (SQLException ex) {
                        error = ex.getMessage();
                    }
                } else {
                    error = "Please fill in ALL FIELDS.";
                }
            }
        %>
        <%
            if (error != null) {
        %>
            <p align="center" class="error"><%= error %></p>
        <%
            }
        %>
        <form method="post">
            <div class="txtfield">
                <input type="text" id="id" name="id" placeholder=" " required>
                <span></span>
                <label for="id">user id</label>
            </div>
            <div class="txtfield">
                <input type="password" name="psw" id="pass" placeholder=" " required>
                <i class="bi bi-eye-slash" id="togglePassword"></i>
                <span></span>
                <label for="pass">password</label>
            </div>
            <div class="login" style="width:100%;text-align: center;margin: 30px 0px 20px 0px;">
                <input type="submit" value="login">
            </div>
            <div class="pass_txt" align="center" style="font-size: 11px;">
                If you are not an admin, <a href="Homepage.jsp?menu=login"><b>click here to return to user login.</b></a>
            </div>
        </form>
    </div>
</body>
</html>

