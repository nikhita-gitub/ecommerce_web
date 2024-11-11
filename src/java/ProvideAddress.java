
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
//import java.util.logging.Level;
//import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProvideAddress")  // URL mapping for the servlet
public class ProvideAddress extends HttpServlet {

    // Handle POST request to update cart items, place the order, and redirect to confirmation page
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Step 1: Fetch customer ID from session
        
        Object sessionId = request.getSession().getAttribute("id");
        HttpSession hs = request.getSession();

        if ((String) hs.getAttribute("name") != null) {
            // Step 2: Retrieve address and payment details from the form
            String customerId =  String.valueOf(sessionId);
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String pincode = request.getParameter("pincode");
            String addressType = request.getParameter("addressType");
            String paymentMethod = request.getParameter("payment");

            // Step 3: Process the order
            try (Connection conn = DatabaseConnection.getConnection()) {
                // Fetch the cart items for this customer
                

                // Step 5: Insert the order into tblorders
                String insertOrderQuery = "INSERT INTO tblorders (customer_id, name, phone, email, address, pincode, address_type, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement orderStmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS)) {
                    orderStmt.setString(1, customerId);
                    orderStmt.setString(2, name);
                    orderStmt.setString(3, phone);
                    orderStmt.setString(4, email);
                    orderStmt.setString(5, address);
                    orderStmt.setString(6, pincode);
                    orderStmt.setString(7, addressType);
                    orderStmt.setString(8, paymentMethod);
                    orderStmt.executeUpdate();

                    // Get the generated order ID
                    ResultSet generatedKeys = orderStmt.getGeneratedKeys();
                    int orderId = 0;
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }

                    // Step 6: Insert order items into tblorder_items
                    String insertOrderItemsQuery = "INSERT INTO tblorder_items (order_id, product_id, quantity, price) SELECT ?, product_id, quantity, price FROM tblcart WHERE customer_id = ?";
                    try (PreparedStatement orderItemsStmt = conn.prepareStatement(insertOrderItemsQuery)) {
                        orderItemsStmt.setInt(1, orderId);
                        orderItemsStmt.setString(2, customerId);
                        orderItemsStmt.executeUpdate();
                    }

                    // Step 7: Clear the cart after placing the order
                    String clearCartQuery = "DELETE FROM tblcart WHERE customer_id = ?";
                    try (PreparedStatement clearCartStmt = conn.prepareStatement(clearCartQuery)) {
                        clearCartStmt.setString(1, customerId);
                        clearCartStmt.executeUpdate();
                    }

                    // Step 8: Redirect to the order confirmation page
                    response.sendRedirect("orderConfirmation.jsp");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing your order.");
            }
        } else {
            // If the user is not logged in, redirect to the login page
            response.sendRedirect("login.jsp");
        }
    }
}
