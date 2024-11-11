<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.connection.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Online Shopping System</title>
        <!-- Importing the necessary styles -->
        <link href="assets/css/font-awesome.css" rel="stylesheet" />
        <link href="assets/css/style.css" rel="stylesheet" />
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script src="js/simpleCart.min.js"></script>
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script>
        <script src="js/jquery.easing.min.js"></script>
    </head>
    <body>
        <%
            // Checking whether the customer is in session or not
            if (session.getAttribute("name") != null && session.getAttribute("name") != "") {
        %>

        <body>
            <!-- Header -->
            <jsp:include page="header.jsp"></jsp:include>
            
            <div class="page-head">
                <div class="container">
                    <h3 style="font-size: 2rem; font-weight: bold; color: #ff6f61; background-color: #ffdde1; padding: 10px;">My Orders</h3>

                </div>
            </div>
            
            <div class="checkout">
                <div class="container">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>SR.No</th>
                                    <th>Order No</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Selling Price($)</th>
                                    <th>Total Price($)</th>
                                </tr>
                            </thead>
                            <%
                                int index = 0;
                                // Getting all products
                                ResultSet totalProduct = DatabaseConnection.getResultFromSqlQuery("SELECT * FROM tblorders WHERE customer_name='" + session.getAttribute("name") + "'");
                                while (totalProduct.next()) {
                            %>
                            <tr class="rem1">
                                <td class="invert"><%=totalProduct.getInt("id")%></td>
                                <td class="invert"><%=totalProduct.getInt("order_no")%></td>
                                <td class="invert"><img src="uploads/products/<%=totalProduct.getString("image")%>" style="width: 150px; height: 100px;"><br><%=totalProduct.getString("product_name")%></td>
                                <td class="invert"><%=totalProduct.getString("quantity")%></td>
                                <td class="invert"><%=totalProduct.getString("product_price")%></td>
                                <td class="invert"><%=totalProduct.getString("product_total_price")%></td>
                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp"></jsp:include>
        </body>

        <%
            } else {
                response.sendRedirect("index.jsp");
            }
        %>
    </body>
</html>
