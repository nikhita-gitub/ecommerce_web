<%-- 
    Document   : kidsgifts
    Created on : Nov 11, 2024, 11:44:39 PM
    Author     : matur
--%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gift Shop - Home</title>
    <style>
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }
        body {
            background-color: #f3f4f6;
            color: #333;
        }

        /* Welcome Section */
        .welcome-section {
            position: relative;
            text-align: center;
            color: white;
            background-color: #ff8367;
            padding: 50px 0;
        }
        .welcome-section img {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
            opacity: 0.8;
            border-radius: 8px;
        }
        .welcome-section .overlay-text {
            position: absolute;
            top: 20%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 2rem;
            font-weight: bold;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        /* Header Styling */
        .page-head {
            background-color: #ff6f61;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
        }
        
        .page-head h3 {
            margin: 0;
        }

        /* Gift Grid */
        .gift-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            padding: 20px;
        }
        .gift-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }
        .gift-item:hover {
            transform: scale(1.05);
        }
        .gift-item img {
            width: 100%;
            height: auto;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .gift-item h4 {
            margin: 10px 0;
            font-size: 1rem;
            color: #333;
        }
        .gift-item .price {
            color: #ff6f61;
            font-weight: bold;
            margin: 10px 0;
        }

        /* Product Section Header */
        .products-heading {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            color: #ff6f61;
            margin-top: 30px;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        /* View More Gifts */
        .view-more {
            text-align: center;
            margin: 20px 0;
        }
        .view-more button {
            background-color: #ff6f61;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            font-size: 1rem;
        }
        .view-more button:hover {
            background-color: #ff9a8b;
        }

        /* Error message style */
        .error-message {
            color: red;
            font-size: 1rem;
            text-align: center;
            margin: 20px 0;
        }

    </style>
</head>

<body>
    <%
        // Checking whether admin is in session or not
        if (session.getAttribute("name") != null && session.getAttribute("name") != "") {
    %>
    <% 
    // Retrieve the error message from the session
    String message = (String) session.getAttribute("added");
    if (message != null) {
        out.println("<p class='error-message'>" + message + "</p>");
        // Remove the message after displaying it so that it doesn't show on the next request
        session.removeAttribute("added");
    }
    %>
    <!-- Header -->
    <jsp:include page="header.jsp"></jsp:include>

    <div class="page-head">
        <div class="container">
            <h3>Products</h3>
        </div>
    </div>

    <br/>

    <div class="products-heading">
        Kids' Gifts
    </div>

    <div class="gift-grid">
        <%
            ResultSet retriveProduct = DatabaseConnection.getResultFromSqlQuery("SELECT * FROM tblproduct WHERE product_category = 'Best Kid Gift'");
            while (retriveProduct.next()) {
        %>
            <div class="gift-item">
                <form action="AddToCart" method="post">
                    <div>
                        <div>
                            <div>
                                <input type="hidden" name="productId" value="<%= retriveProduct.getInt("id") %>">
                                <img src="uploads/products/<%= retriveProduct.getString("image_name") %>" alt="Gift Image">
                            </div>
                            <div class="item-info-product">
                                <h4><%= retriveProduct.getString("name") %></h4>
                                <h5>Category: <%= retriveProduct.getString("product_category") %></h5>
                                <div class="price">
                                    <h7>Rs.<%= retriveProduct.getString("price") %></h7>
                                    <input type="hidden" name="price" value="<%= retriveProduct.getString("price") %>">
                                </div>
                                <input type="submit" value="Add to cart" class="view-more" onclick="return confirm('Are you sure Do you want to add this item in cart?');">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        <%
            }
        %>
    </div>

    <%
        } else {
            response.sendRedirect("customer-login.jsp");
        }
    %>
</body>
</html>

