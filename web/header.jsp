<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>

<!-- Header-specific styles -->
<head>
    <!-- Font Awesome CDN for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

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

        /* Header */
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #ffdde1; /* Softer pink for a warm tone */
            padding: 10px 20px;
            color: #333;
        }

        .header .logo {
            font-size: 1.8rem;
            font-weight: bold;
            color: #ff6f61; /* Slightly darker shade for contrast */
        }

        .header input[type="text"] {
            width: 40%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ffc2c2; /* Light border */
            color: #333;
        }

        .header .icons {
            display: flex;
            align-items: center;
        }

        .header .icon, .header select {
            margin-left: 10px;
            background-color: #ff6f61; /* Unified color */
            padding: 8px 12px;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            cursor: pointer;
            transition: background 0.3s;
            border: none;
            font-size: 0.9rem;
        }

        .header .icon:hover, .header select:hover {
            background-color: #ff8367; /* Softer hover effect */
        }

        /* Cart Section Styles */
        .cart-section {
            display: flex;
            align-items: center;
            margin-left: 15px;
            position: relative;
        }

        .cart-section i {
            font-size: 1.5rem;
        }

        .cart-section .item-count {
            font-size: 1rem;
            font-weight: bold;
            color: white;
            margin-left: 5px;
        }

        /* Tooltip for Cart Count */
        .cart-section:hover .item-count {
            color: #ffdde1;
            background-color: #ff6f61;
            border-radius: 5px;
            padding: 5px;
        }

        /* Dropdown for Category Selection */
        .header select {
            appearance: none;
            color: white;
            font-size: 0.9rem;
        }
    </style>
</head>

<!-- Header Section -->
<div class="header">
    <!-- Logo -->
    <div class="logo">E-GiftShopee</div>

    <!-- Search Bar -->
    <form action="filter.jsp" method="get">
    <input type="text" name="search" placeholder="Search best gift for your best ones" />
    <button type="submit" class="icon">Search</button>
    </form>

    <!-- Navigation Icons -->
    <div class="icons">
        <a href="index.jsp" class="icon">Home</a>

        <!-- Category Dropdown -->
        <select id="categorySelect" onchange="redirectToCategory()">
            <option value="all">Select Category</option>
            <option value="men">Best Men Gifts</option>
            <option value="women">Best Women Gifts</option>
            <option value="couple">Best Couple Gifts</option>
            <option value="kids">Best Kids Gifts</option>
            <option value="family">Best Family Gifts</option>
        </select>
        
       

<script>
    function redirectToCategory() {
        var category = document.getElementById("categorySelect").value;
        
        // Define the base URL
        var baseUrl = "gifts.jsp";
        
        // Redirect based on the selected category
        if (category !== "all") {
            window.location.href =category+ baseUrl ;
        } else {
            window.location.href = "index.jsp"; // Redirect to the base page (all products)
        }
    }
</script>


        <!-- Cart Section with Item Count -->
        <div class="cart-section">
            <a href="checkout.jsp" class="icon">
                <i class="fas fa-shopping-cart" aria-hidden="true"></i>
                Add to Cart
                <span class="item-count">
                    <%
                        // Retrieve the item count from the cart for the current user
                        ResultSet resultCount = DatabaseConnection.getResultFromSqlQuery("SELECT count(*) FROM tblcart WHERE customer_id='" + session.getAttribute("id") + "'");
                        resultCount.next();
                        int count = resultCount.getInt(1);
                    %>
                    (<%= count %> items)
                </span>
            </a>
        </div>

        <!-- Other Navigation Links -->
        <a href="my-orders.jsp" class="icon">Ordered Items</a>
        <a href="logout.jsp" class="icon">Logout</a>
    </div>
</div>
