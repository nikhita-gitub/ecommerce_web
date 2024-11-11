<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<html>
    <head>
        <title>Online Shopping System</title>
        
        <!-- Required external JS libraries -->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/3.1.1/js/bootstrap.min.js"></script>
        
        <!-- Optional: Include jQuery easing if needed (already used in the original code) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        
        <!-- Additional Styles -->
        <style>
            /* Add minimal necessary styles here (if required) */
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
            }
            .checkout {
                margin-top: 20px;
            }
            .checkout table {
                width: 100%;
                border-collapse: collapse;
            }
            .checkout table th, .checkout table td {
                padding: 10px;
                border: 1px solid #ddd;
            }
            .checkout-left, .checkout-right-basket {
                margin-top: 20px;
            }
            /* CSS for the Proceed to Address Button */
.checkout-action {
    text-align: center;
    margin-top: 20px;
}

.checkout-action .btn {
    background-color: #ff6f61; /* pink background */
    color: white; /* White text */
    padding: 15px 32px; /* Padding for button */
    font-size: 18px; /* Larger font size */
    border: none; /* Remove border */
    border-radius: 8px; /* Rounded corners */
    text-decoration: none; /* Remove underline */
    display: inline-block;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

/* Button Hover Effect */
.checkout-action .btn:hover {
    background-color: #ff6f61; /* Darker pink */
    transform: translateY(-2px); /* Slight lift effect */
}

/* Button Focus Effect (for accessibility) */
.checkout-action .btn:focus {
    outline: none; /* Remove default outline */
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25); /* Add custom focus outline */
}

        </style>
        
        <script>
            // Custom JavaScript if needed
            $(document).ready(function() {
                // If any further custom JS needed, you can include it here
            });
        </script>
        
    </head>
    <body>
        <%
    if (session.getAttribute("name") != null && session.getAttribute("name") != "") {
%>

    <!-- Header inclusion -->
    

    <div class="page-head">
        <div class="container">
            <h3>Check Out</h3>
        </div>
    </div>

    <div class="checkout">
        <div class="container">
            <h3>My Shopping Bag</h3>
            <%
                int index = 0;
                int paymentId = 101;
                ResultSet rsCountCheck = DatabaseConnection.getResultFromSqlQuery("select count(*) from tblcart where customer_id='" + session.getAttribute("id") + "'");
                rsCountCheck.next();
                int cartItem = rsCountCheck.getInt(1);

                if (cartItem > 0) {
            %>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>SR.No</th>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Selling Price(Rs)</th>
                            <th>Total Price(Rs)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <%
                        ResultSet totalProduct = DatabaseConnection.getResultFromSqlQuery("select tblproduct.image_name,tblproduct.name,tblcart.quantity,tblcart.item_price,tblcart.total_price,tblcart.product_id from tblproduct,tblcart where tblproduct.id=tblcart.product_id and customer_id='" + session.getAttribute("id") + "'");
                        if(totalProduct != null){
                            while (totalProduct.next()) {
                                index++;
                    %>
                    <tr class="rem1">
                        <td class="invert"><%=index%></td>
                        <td class="invert">
                            <img src="uploads/products/<%=totalProduct.getString(1)%>" alt="" class="pro-image-front" style="width: 150px; height: 100px;">
                            <br><%=totalProduct.getString(2)%>
                        </td>
                        <td class="invert">
                            <div class="quantity">
                                <form action="UpdateProductQuantity" method="post">
                                    <input type="hidden" value="<%=totalProduct.getInt(6)%>" name="productId">
                                    <input type="number" name="quantity" value="<%=totalProduct.getInt(3)%>" style="width: 50px; height: 35px;">
                                    <input type="submit" class="btn btn-danger" value="Change">
                                </form>
                            </div>
                        </td>
                        <td class="invert"><%=totalProduct.getDouble(4)%>&nbsp;Rs.</td>
                        <td class="invert"><%=totalProduct.getDouble(5)%>&nbsp;Rs.</td>
                        <td class="invert">
                            <a href="removeProductFromCart.jsp?productId=<%=totalProduct.getInt(6)%>" onclick="return confirm('Are you sure you want to remove this item from cart?');">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                        }} else out.println("No products found in the cart.");
                    %>
                    <%
                        double finalBill = 0.0;
                        ResultSet totolAmount = DatabaseConnection.getResultFromSqlQuery("select sum(total_price) from tblcart where customer_id='" + session.getAttribute("id") + "'");
                        if (totolAmount.next()) {
                            finalBill = totolAmount.getDouble(1);
                        }
                    %>
                    <tr>
                        <td colspan="4"></td>
                        <td colspan="2"><strong><center>Total Amount.:&nbsp;<%=finalBill%> Rs.</center></strong></td>
                    </tr>
                </table>
            </div>
            <%
            // Continue the rest of your code here
            %>

        </div>
    </div>
            <div class="checkout-action">
               <a href="ProvideAddress.jsp" class="btn btn-primary" onclick="updatePurchasedCount()">Continue</a>
            </div>
            
 <!-- Footer inclusion -->
        <jsp:include page="footer.jsp"></jsp:include>
<%
    } else {
        
        out.println("<center><strong>No items in your Cart.</strong></center>");
    }

} else {
    response.sendRedirect("index.jsp");
}
%>


    </body>
</html>
