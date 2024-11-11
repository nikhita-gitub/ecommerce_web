<%-- 
    Document   : ProvideAddress.jsp
    Created on : Nov 11, 2024, 6:08:18 PM
    Author     : matur
--%>


<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Provide Address</title>
    <!-- Add necessary CSS and JS here -->
</head>
<body>

    <h2>Provide Your Address and Payment Information</h2>

    <!-- Address Form -->
    <form action="ProvideAddress" method="post">
        <div>
            <label for="name">Your Name:</label>
            <input type="text" name="name" required>
        </div>
        <div>
            <label for="phone">Phone Number:</label>
            <input type="text" name="phone" required>
        </div>
        <div>
            <label for="email">Email Address:</label>
            <input type="email" name="email" required>
        </div>
        <div>
            <label for="address">Address:</label>
            <input type="text" name="address" required>
        </div>
        <div>
            <label for="pincode">Pin Code:</label>
            <input type="text" name="pincode" required>
        </div>
        <div>
            <label for="addressType">Address Type:</label>
            <select name="addressType" required>
                <option value="Home">Home</option>
                <option value="Office">Office</option>
                <option value="Commercial">Commercial</option>
            </select>
        </div>
        <div>
            <label for="payment">Payment Method:</label>
            <select name="payment" required>
                <option value="COD">Cash On Delivery</option>
                <option value="Credit Card">Credit Card</option>
                <option value="Debit Card">Debit Card</option>
                <option value="Online Banking">Online Banking</option>
                <option value="UPI">UPI</option>
            </select>
        </div>
        <button type="submit">Place Order</button>
    </form>

</body>
</html>
