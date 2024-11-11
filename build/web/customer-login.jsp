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
            background-image: url('https://images.pexels.com/photos/3309659/pexels-photo-3309659.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'); /* Add a link to a suitable gift-themed image */
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
            background-color: #f09595;
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
            margin-top: 20px;
        }

        .website-name {
            font-size: 2em;
            font-weight: bold;
            margin-bottom: 10px;
        }
.sign-up-message {
            font-size: 0.9em;
            margin-top: 20px; 
        }
        .sign-up-link {
            color: #f76c6c;
            text-decoration: none;
            font-weight: bold;
        }
        .admin-login {
            font-size: 0.9em;
            color: #f76c6c;
            text-decoration: none;
            margin-top: 15px;
            display: inline-block;
        }

        .admin-login:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            font-size: 0.85em;
            display: none;
            margin: -5px 0 10px;
        }

    </style>


</head>
<body>
    
    <% 
    // Retrieve the error message from the session
    String message = (String) session.getAttribute("credential");
    if (message != null) {
        out.println("<p class='error-message'>" + message + "</p>");
        // Remove the message after displaying it so that it doesn't show on the next request
        session.removeAttribute("credential");
    }
%>

    <div class="container">
        <div class="website-name">E gift shopee</div>
        <h1>Login</h1>
        <form action ="CustomerLogin" method = "post" >
        
        <input type="email" name ="email" class="input-field" placeholder="Email Address" required id="email">
        <div id="email-error" class="error-message">Please enter a valid email address.</div>

        <input type="password" id="password"  name ="password"class="input-field" placeholder="Enter 6 characters or more" required>
        <div id="empty-field-error" class="error-message">Both fields are required.</div>
        <a href="forgot_pass.jsp" class="forgot-password">Forgot Password?</a>
        <div class="remember-me">
            <input type="checkbox"> Remember me
        </div>
        <button class="login-btn">LOGIN</button>
        </form>
        <p class="sign-up-message">Don't have an account yet? <a href="customer-register.jsp">Sign Up</a></p>
        <a href="admin-login.jsp" class="admin-login">Login as Admin</a>
    </div>
    
</body>
</html>
