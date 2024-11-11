<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shopping Cart - e gift shopee</title>

        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            /* Cart container should start below the header */

            body {
                font-family: "Comic Sans MS", "Comic Sans", cursive;
                background-color: #f8f8f8;
                color: #333;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                padding: 20px;
            }

            .cart-container {
                display: flex;
                background-color: rgba(255, 255, 255, 0.95);
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 1200px;
                overflow: hidden;
            }

            .cart-items-section {
                width: 65%;
                padding: 30px;
                border-right: 1px solid #ddd;
            }

            .summary-section {
                width: 35%;
                padding: 30px;
                background-color: #f7e3e1;
            }

            h1 {
                font-size: 2em;
                text-align: center;
                margin-bottom: 20px;
            }

            .cart-items {
                list-style-type: none;
                margin-bottom: 30px;
            }

            .cart-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                border-bottom: 1px solid #ddd;
            }

            .item-details {
                display: flex;
                align-items: center;
            }

            .item-image {
                width: 100px;
                height: 100px;
                border-radius: 5px;
                margin-right: 15px;
                object-fit: cover;
            }

            .item-name {
                font-size: 1.2em;
                font-weight: bold;
            }

            .item-price {
                font-size: 1.1em;
                margin-left: 20px;
            }

            .remove-item {
                cursor: pointer;
                color: #f76c6c;
                font-size: 1.2em;
                margin-left: 10px;
            }

            .quantity-controls {
                display: flex;
                align-items: center;
                margin-left: 50px;
            }

            .quantity-controls button {
                background-color: #ddd;
                border: none;
                padding: 5px;
                font-size: 1em;
                cursor: pointer;
            }

            .quantity-controls input {
                width: 40px;
                text-align: center;
                border: 1px solid #ddd;
                margin: 0 5px;
                font-size: 1em;
            }

            .coupon-section {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                font-size: 1.2em;
            }

            .coupon-section input {
                flex-grow: 1;
                padding: 5px;
                margin-right: 10px;
                font-size: 1em;
            }

            .quantity-controls {
                display: flex;
                align-items: center; /* Vertically center items */
            }

            .quantity-input {
                display: flex;
                align-items: center; /* Align number input and button side by side */
            }

            .quantity-input input[type="number"] {
                width: 50px;
                height: 35px;
                margin-right: 10px; /* Space between the number input and the submit button */
            }

            .apply-btn {
                background-color: #f76c6c;
                color: white;
                border: none;
                padding: 6px 15px; /* Adjust padding */
                border-radius: 5px;
                cursor: pointer;
                font-size: 1em;
                display: inline-block;
                text-align: center;
                white-space: nowrap; /* Prevent text from wrapping */
                min-width: 100px; /* Optional: Ensures button has a minimum width */
            }


            .apply-btn::before {
                content: "change";
                font-size: 1.2em;
            }

            .discount-section, .total-section {
                font-size: 1.2em;
                margin-bottom: 40px;
            }

            .checkout-btn {
                display: block;
                background-color: #f76c6c;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 1.2em;
                cursor: pointer;
                width: 100%;
                text-align: center;
                margin-top: 40px;
            }

            .back-to-shop {
                display: block;
                text-align: center;
                color: #f76c6c;
                text-decoration: none;
                margin-top: 30px;
                font-size: 1em;
            }
        </style>
    </head>

    <body>
        <% 
    // Retrieve the error message from the session
    String message = (String) session.getAttribute("sucess");
    if (message != null) {
        out.println("<p class='error-message'>" + message + "</p>");
        // Remove the message after displaying it so that it doesn't show on the next request
        session.removeAttribute("sucess");
    }
    %>
      
        <%
            
            if (session.getAttribute("name") != null && session.getAttribute("name") != "") {
        %>
        
        <div class="cart-container">
            
            <div class="cart-items-section">
                <h1>Shopping Cart</h1>
                <ul class="cart-items">
                    <%
                        int index = 0;
                        int paymentId = 101;
                        ResultSet rsCountCheck = DatabaseConnection.getResultFromSqlQuery("select count(*) from tblcart where customer_id='" + session.getAttribute("id") + "'");
                        rsCountCheck.next();
                        int cartItem = rsCountCheck.getInt(1);

                        if (cartItem > 0) {
                            ResultSet totalProduct = DatabaseConnection.getResultFromSqlQuery("select tblproduct.image_name,tblproduct.name,tblcart.quantity,tblcart.item_price,tblcart.total_price,tblcart.product_id from tblproduct,tblcart where tblproduct.id=tblcart.product_id and customer_id='" + session.getAttribute("id") + "'");
                            while (totalProduct.next()) {
                                index++;
                    %>
                    <li class="cart-item">
                        <div class="item-details">
                            <img src="uploads/products/<%=totalProduct.getString(1)%>" alt="<%=totalProduct.getString(2)%>" class="item-image">
                            <span class="item-name"><%=totalProduct.getString(2)%></span>
                            <div class="quantity-controls">
                                <form action="UpdateProductQuantity" method="post">
                                    <input type="hidden" value="<%=totalProduct.getInt(6)%>" name="productId">
                                    <div class="quantity-input">
                                        <input type="number" name="quantity" value="<%=totalProduct.getInt(3)%>" style="width: 50px; height: 35px;">
                                        <input type="submit" class="apply-btn" value="Change">
                                    </div>
                                </form>
                            </div>

                        </div>
                        <span class="item-price"><%=totalProduct.getDouble(4)%>&nbsp;Rs.</span>
                        <span class="remove-item"><a href="removeProductFromCart.jsp?productId=<%=totalProduct.getInt(6)%>" onclick="return confirm('Are you sure you want to remove this item from cart?');">remove</a></span>
                    </li>
                    <%
                            }
                        } else {
                            out.println("<center><strong>No products found in your cart.</strong></center>");
                        }
                    %>
                </ul>
            </div>

            <div class="summary-section">
    <div class="total-section">
        <strong>Total Items Selected:</strong> <%=cartItem%>
    </div>

    <div class="total-section">
        <%
            double finalBill = 0.0;
            ResultSet totolAmount = DatabaseConnection.getResultFromSqlQuery("select sum(total_price) from tblcart where customer_id='" + session.getAttribute("id") + "'");
            if (totolAmount.next()) {
                finalBill = totolAmount.getDouble(1);
            }
        %>
        <strong>Order Subtotal: Rs. <%=finalBill%></strong>
    </div>
    
    <!-- Form for order details -->
    <form action="GetProductOrders" method="post">
        <input type="hidden" name="payment_id" value="<%= paymentId %>">
        
        <div class="coupon-section">
            <label for="name">Customer Name:</label>
            <input type="text" id="name" name="name" required placeholder="Enter your name" style="width: 100%; padding: 5px;">
        </div>
        
        <input type="submit" class="checkout-btn" value="Place Order">
    </form>
    
    <a href="index.jsp" class="back-to-shop">Back to Shop</a>
</div>


        <%
            } else {
                response.sendRedirect("customer-login.jsp");
            }
        %>

    </body>

</html>