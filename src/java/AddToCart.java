
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.DatabaseConnection;
import java.io.File;
import java.sql.PreparedStatement;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = 0;

        //Getting all the parameters from the user
        int productId = Integer.parseInt(request.getParameter("productId"));
        String price = request.getParameter("price");
        
        HttpSession hs = request.getSession();
        try {
            //If user session is null user have to re-login
            if ((String) hs.getAttribute("name") == null) {
                response.sendRedirect("customer-login.jsp");
                //Inserting cart details to the database
            } else {
                int customerId = (int) hs.getAttribute("id");
                //Querying to the database.
                //int addToCart = DatabaseConnection.insertUpdateFromSqlQuery("insert into tblcart values('" + id + "','" + price + "',1,'" + price + "','" + customerId + "','" + productId  + "')");
                
                
                // Insert the product into the database using a PreparedStatement
                String insertSQL = "INSERT INTO tblcart (item_price,quantity,total_price,customer_id,product_id) "
                        + "VALUES ( ?, ?, ?, ?, ?)";
                
                try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement(insertSQL)) {
                    
                    ps.setDouble(1, Double.parseDouble(price));
                    ps.setInt(2, 1);
                    ps.setDouble(3, Double.parseDouble(price)); 
                    ps.setInt(4, customerId); 
                    ps.setInt(5, productId);
                    
                    int addToCart = ps.executeUpdate();
                    
                    if (addToCart > 0) {
                        String message = "Product added sucessfully!";
                     String referer = request.getHeader("referer");
                     hs.setAttribute("added", message);
                     if (referer != null && !referer.isEmpty()) {
                        response.sendRedirect(referer);
                    } else {
                        // If referer is not available, redirect to a default page
                        response.sendRedirect("index.jsp");
                    }
                    } 
                } catch (Exception e) {
                      e.printStackTrace();
                      response.sendRedirect("error.jsp"); 

                    }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
        }
