<%-- 
    Document   : addStaff
    Created on : Apr 11, 2025, 12:10:41 PM
    Author     : KTYJ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Staff Member</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input{
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .password-requirements {
            font-size: 0.8em;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add New Staff Member</h1>
        <form id="addStaffForm" action="../src/java/balancetiada/AddStaff.java" method="POST">
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="psw">Password:</label>
                <input type="password" id="psw" name="psw" placeholder="Must be at least 7 characters long" required minlength="7">
            </div>
            
            <div class="form-group">
                <label for="confirm-psw">Confirm Password:</label>
                <input type="password" id="confirm-psw" name="confirm-psw" required>
            </div>
            
            <button type="submit" class="btn">Add Staff Member</button>
        </form>
    </div>

    <script>
        document.getElementById('addStaffForm').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value;
            const password = document.getElementById('psw').value;
            const confirmPassword = document.getElementById('confirm-psw').value;
            
            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                e.preventDefault();
            }else{

                        // If confirmed, submit the form
            if (confirm('Are you sure you want to add staff member ' + name + '?')) {
                this.submit();
            }
        }
        });
    </script>
</body>
</html>
