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
        }
        .view-more button:hover {
            background-color: #ff6f61;
        }
        

        
    </style>
</head>

<body>
     <%
            //Checking whether admin in session or not
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
    <!--Header-->
    <jsp:include page="header.jsp"></jsp:include>



    <div class="welcome-section">
        <img src="https://img.freepik.com/premium-photo/minimalist-brown-gift-box-aesthetic-with-ribbon-flower-background-ai-generated_326414-1475.jpg" alt="Welcome to Gift Shop">
        <div class="overlay-text">Discover the Perfect Gift for Every Occasion!</div>
    </div>
    
    <!-- Gift Grid Section -->
    <div class="gift-grid">
        <!-- Sample Gift Items with Forms for Adding to Cart -->
        <%
    // Modified query to get top 10 products based on purchases
    String query = "SELECT p.id, p.name, p.product_category, p.image_name, p.price,p.mrp_price, COUNT(c.product_id) AS purchase_count " +
                   "FROM tblproduct p " +
                   "LEFT JOIN tblcart c ON p.id = c.product_id " +
                   "GROUP BY p.id " +
                   "ORDER BY purchase_count DESC " +
                   "LIMIT 10";
    
    ResultSet retriveProduct = DatabaseConnection.getResultFromSqlQuery(query);
    while (retriveProduct.next()) {
%>
    <div class = "gift-item">
        <form action="AddToCart" method="post">
            <div >
                <div >
                    <div >
                        <input type="hidden" name="productId" value="<%= retriveProduct.getInt("id") %>">
                        
                        <img src="uploads/products/<%= retriveProduct.getString("image_name") %>" alt="Gift Image" >
                         
                        
                    </div>
                    <div class="item-info-product">
                        <h4><%= retriveProduct.getString("name") %></h4>
                        <h5>Category: <%= retriveProduct.getString("product_category") %></h5>
                        <div class="price">
                            <input type="hidden" name="price" value="<%= retriveProduct.getString("price") %>">
                        </div>
                        
                        <input type="submit" value="Add to cart" class="btn btn-warning" onclick="return confirm('Are you sure Do you want to add this item in cart?');">
                    </div>
                </div>
            </div>
        </form>
    </div>
  <%
    }
%>

     <!More gift items here-->
    <div class="view-more">
        <a href ="products.jsp" >View More Gifts</a>
    </div>

    
    <%
            } else {
                response.sendRedirect("customer-login.jsp");
            }
        %>
</body>
</html>
