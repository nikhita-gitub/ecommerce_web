
import com.connection.DatabaseConnection;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

@WebServlet("/GetProductOrders")
public class GetProductOrders extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Creating Session
        HttpSession hs = request.getSession();
        int order_no = 1000;
        int orderProducts = 0;
        //Getting all the parameters from the user
        int paymentId = Integer.parseInt(request.getParameter("payment_id"));
        String customerName = request.getParameter("name");
        
        String product_name = null;
        int quantity = 0;
        String product_price = null;
        
        String product_total_price = null;
        
        HttpSession session = request.getSession();
        //Storing payment attrbute in session
        session.setAttribute("paymentId", paymentId);

        try {
            //Getting maximium column of tblorders table
            ResultSet rsMaxOrderNo = DatabaseConnection.getResultFromSqlQuery("select max(order_no) from tblorders");
            if (rsMaxOrderNo.next()) {
                order_no = rsMaxOrderNo.getInt(1);
                order_no = 1000 + order_no;
            }
            //Getting all the orders from the database
            ResultSet totalProduct = DatabaseConnection.getResultFromSqlQuery("select tblproduct.image_name,tblproduct.name,tblcart.quantity,tblcart.total_price,tblcart.product_id,tblcart.item_price from tblproduct,tblcart where tblproduct.id=tblcart.product_id and customer_id='"
                    + session.getAttribute("id") + "' ");
            while (totalProduct.next()) {
                order_no++;
                String image_name = totalProduct.getString(1);
                product_name = totalProduct.getString(2);
                quantity = totalProduct.getInt(3);
                product_total_price = totalProduct.getString(4);
                product_price = totalProduct.getString(6);
                
                
                //Inserting product details inside the table
                String sql = "insert into tblorders(customer_name,image,product_name,quantity,product_price,product_total_price,order_no) " +
                            "VALUES(?, ?, ?, ?, ?, ?,?)";
                try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement(sql)) {
                    ps.setString(1, customerName);
                    ps.setString(2, image_name);
                    ps.setString(3, product_name);
                    ps.setInt(4, quantity);  // Full image path
                    ps.setString(5, product_price);  // Only the image name
                    ps.setString(6, product_total_price);
                    ps.setInt(7, order_no);
                    int rowsInserted = ps.executeUpdate();
                    
                    if (rowsInserted > 0) {
                        String message = "Thank you for your order.";
                        hs.setAttribute("success", message);
                        DatabaseConnection.insertUpdateFromSqlQuery("delete from tblcart where customer_id='" + session.getAttribute("id") + "'");

                        response.sendRedirect("checkout.jsp");
                    } else {
                        session.setAttribute("sucess", "Failed to add order.");
                        response.sendRedirect("checkout.jsp");
                    }
                    

            } catch (Exception ex) {
                ex.printStackTrace();
                session.setAttribute("message", "Error: " + ex.getMessage());
                response.sendRedirect("checkout.jsp");
            }

            }
            
           
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
