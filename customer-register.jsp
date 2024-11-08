<%-- 
    Document   : customer-register.jsp
    Created on : 07-Nov-2024, 4:06:23 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - e gift shopee</title>
    <style>
        body {
            font-family: "Comic Sans MS", "Comic Sans", cursive;
            background-image: url('https://images.unsplash.com/photo-1549465220-1a8b9238cd48?q=80&w=2880&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-position: center;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .signup-container {
            background-color: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #444;
        }

        .input-field {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .signup-btn {
            background-color: #f76c6c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
            width: 100%;
        }

        .welcome-section {
            background-color: #f76c6c;
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 20px;
        }

        .welcome-section h2 {
            margin: 0;
            font-size: 1.8em;
        }

        .welcome-section p {
            font-size: 0.9em;
            margin: 10px 0;
        }

        .sign-in-link {
            color: #f76c6c;
            text-decoration: none;
            font-weight: bold;
        }

        .sign-in-link:hover {
            text-decoration: underline;
        }

        .existing-account {
            margin-top: 15px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    
    
    <div class="signup-container">
        <div class="welcome-section">
            <h2>Welcome Back!</h2>
            <p>To keep connected, please sign up with your personal info.</p>
        </div>
        
        <!-- Display success or failure messages from the session -->
        
        <%
            String successmsg =(String) session.getAttribute("success-message");
            String failmsg = (String)session.getAttribute("fail-message");
            if(successmsg!=null){
        %>
            
            <p style ="color:green;"><%= successmsg %></p>
        <%    
            session.removeAttribute("success-message");
            } 
            if(failmsg!=null){
  %>           

  <p style =" "color:red;"><%=failmsg%></p>
  <%  session.removeAttribute("fail-message");
      }
%>
  
  
  

       
        
        <h1>Create Account</h1>
        
        <form action ="AddCustomer" method ="post">
        <input type="text" class="input-field" name = "name" placeholder="Name" required>
        <input type="email" class="input-field" name = "email" placeholder="Email" required>
        <input type="password" class="input-field" name = "password" placeholder="Password" required>
        <input type="password" class="input-field" name = "password1" placeholder="Re-enter Password" required>
        <button class="signup-btn">Sign Up</button>
        </form>
        <div class="existing-account">
            Already have an account? <a href="customer-login.jsp" class="sign-in-link">Sign in</a>
        </div>
    </div>
</body>
</html>