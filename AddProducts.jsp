<%-- 
    Document   : AddProducts
    Created on : 08-Nov-2024, 11:46:22 am
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - e Gift Shopee</title>
    <style>
        body {
            font-family: "Comic Sans MS", "Comic Sans", cursive;
            background-color: #f5f5f5;
            margin: 0;
            overflow-x: hidden;
        }

        /* Sidebar styling */
        .sidebar {
            position: fixed;
            left: -250px; /* Hidden by default */
            top: 0;
            width: 250px;
            height: 100%;
            background-color: #333;
            color: white;
            padding-top: 60px;
            transition: left 0.3s;
            z-index: 100;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            font-size: 1.2rem;
        }

        .sidebar a:hover {
            background-color: #575757;
        }

        .sidebar .close-btn {
            position: absolute;
            top: 10px;
            right: 20px;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Sidebar toggle button */
        .sidebar-toggle {
            font-size: 2rem;
            cursor: pointer;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 101;
        }

        /* Container for the form */
        .container {
            max-width: 700px;
            margin: 100px auto;
            padding: 20px;
            background-color: #f8ebeb;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }

        .container h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #2c1515;
        }

        label {
            display: block;
            margin-top: 15px;
            font-size: 1.2rem;
        }

        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ffe9e9;
            border-radius: 5px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button-container button {
            padding: 10px 20px;
            font-size: 1rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 10px;
        }

        .button-container .save-btn {
            background-color: #28a745;
            color: white;
        }

        .button-container .cancel-btn {
            background-color: #dc3545;
            color: white;
        }
    </style>
    <script>
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            if (sidebar.style.left === '0px') {
                sidebar.style.left = '-250px';
            } else {
                sidebar.style.left = '0px';
            }
        }

        function handleCancel() {
            document.querySelector("form").reset();
        }
    </script>
</head>
<body>
    
    <%
    String message = (String) session.getAttribute("message");
    if (message != null) {
%>
    <div style="text-align: center; color: <%= message.contains("successfully") ? "green" : "red" %>; font-weight: bold;">
        <%= message %>
    </div>
<%
        session.removeAttribute("message"); // Remove message after displaying it
    }
%>

    
    
    
    
    <!-- Sidebar -->
    <div class="sidebar">
        <span class="close-btn" onclick="toggleSidebar()">&times;</span>
        <a href="update_admin.jsp">Update Password</a>
        <a href="#">Logout</a>
    </div>

    <!-- Sidebar toggle button -->
    <span class="sidebar-toggle" onclick="toggleSidebar()">&#9776;</span>

    <!-- Form container -->
    <div class="container">
        <h1>Add Product</h1>
        <form action="AddProducts" method="post" enctype="multipart/form-data">
            <label for="productName">Product Name</label>
            <input type="text" id="productName" name="productName" placeholder="Enter product name" required>

            <label for="price">Price</label>
            <input type="number" id="price" name="price" placeholder="Enter product price" required>

            <label for="description">Description</label>
            <textarea id="description" name="description" rows="4" placeholder="Enter product description"></textarea>

            <label for="status">Status</label>
            <input type="text" name="status">
            <!--<select id="status" name="status">
                <option value="active">Active</option>
            </select>-->

            <label for="category">Product Category</label>
            <select id="category" name="category">
                <option value="couple">Couple</option>
                <option value="kids">Kids</option>
                <option value="men">Men</option>
                <option value="women">Women</option>
            </select>

            <label for="image">Attach Product Image</label>
            <input type="file" id="image" name="image" required>

            <div class="button-container">
                <button type="submit" class="save-btn">Save</button>
                <button type="button" class="cancel-btn" onclick="handleCancel()">Cancel</button>
            </div>
        </form>
    </div>
</body>
</html>
