<%-- 
    Document   : customer-login.jsp
    Created on : 07-Nov-2024, 4:07:01 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>e gift shopee</title>
    <style>
        body {
            font-family: "Comic Sans MS", "Comic Sans", cursive;
            background-image: url('https://images.unsplash.com/photo-1549465220-1a8b9238cd48?q=80&w=2880&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); /* Add a link to a suitable gift-themed image */
            background-size: cover;
            background-position: center;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 350px;
            text-align: center;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .login-btn {
            background-color: #f76c6c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            width: 100%;
        }

        .forgot-password {
            font-size: 0.9em;
            color: #f76c6c;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .remember-me {
            font-size: 0.9em;
            margin-bottom: 20px;
        }

        .website-name {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="website-name">e gift shopee</div>
        <h1>Login</h1>
        <form action ="customerLogin" method = "post">
        <p>Don't have an account yet? <a href="#">Sign Up</a></p>
        <input type="email" name ="email" class="input-field" placeholder="Email Address" required>
        <input type="password" name ="password"class="input-field" placeholder="Enter 6 characters or more" required>
        <a href="#" class="forgot-password">Forgot Password?</a>
        <div class="remember-me">
            <input type="checkbox"> Remember me
        </div>
        <button class="login-btn">LOGIN</button>
        </form>
    </div>
</body>
</html>