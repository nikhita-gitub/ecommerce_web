import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import com.connection.DatabaseConnection;
import java.sql.PreparedStatement;

@WebServlet("/AddProducts")
public class AddProducts extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "C:\\Users\\matur\\Downloads\\OnlineShoppingSystem\\web\\uploads\\products";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Creating session
        HttpSession session = request.getSession();
        
        if (ServletFileUpload.isMultipartContent(request)) {
            try {
                //Parsing the request for multipart data
                List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                
                String imageName = null;
                String productName = null;
                String productQuantity = null;
                String productPrice = null;
                String description = null;
                String mrpPrice = null;
                String status = null;
                String category = null;

                // Generating unique code for the product
                String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
                StringBuilder salt = new StringBuilder();
                Random rnd = new Random();
                while (salt.length() < 3) { 
                    int index = (int) (rnd.nextFloat() * SALTCHARS.length());
                    salt.append(SALTCHARS.charAt(index));
                }
                String code = salt.toString();

                // Loop through all form items to retrieve values
                for (FileItem item : multiparts) {
                    if (!item.isFormField()) {
                        // Process the image file
                        imageName = new File(item.getName()).getName();
                        item.write(new File(UPLOAD_DIRECTORY + File.separator + imageName));
                    } else {
                        // Process form fields (not file uploads)
                        if (item.getFieldName().equals("productname")) {
                            productName = item.getString();
                        } else if (item.getFieldName().equals("price")) {
                            productPrice = item.getString();
                        } else if (item.getFieldName().equals("description")) {
                            description = item.getString();
                        } else if (item.getFieldName().equals("status")) {
                            status = item.getString();
                        } else if (item.getFieldName().equals("category")) {
                            category = item.getString();
                        }
                    }
                }

                // Set the MRP price to be the same as the product price if not provided
                if (productPrice != null) {
                    mrpPrice = productPrice;  // You can adjust this if needed.
                }

                // Insert the product into the database using a PreparedStatement
                String insertSQL = "INSERT INTO tblproduct (active, code, description, image, image_name, name, price, product_category) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?,?)";
                
                try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement(insertSQL)) {
                    ps.setString(1, status);
                    ps.setString(2, code);
                    ps.setString(3, description);
                    ps.setString(4, UPLOAD_DIRECTORY + File.separator + imageName);  // Full image path
                    ps.setString(5, imageName);  // Only the image name
                    ps.setString(6, productName);
                    ps.setDouble(7, Double.parseDouble(productPrice));
                    
                    ps.setString(8, category);
                    
                    int rowsInserted = ps.executeUpdate();
                    
                    if (rowsInserted > 0) {
                        session.setAttribute("message", "Product added successfully.");
                        response.sendRedirect("admin-add-product.jsp");
                    } else {
                        session.setAttribute("message", "Failed to add product.");
                        response.sendRedirect("admin-add-product.jsp");
                    }
                }

            } catch (Exception ex) {
                ex.printStackTrace();
                session.setAttribute("message", "Error: " + ex.getMessage());
                response.sendRedirect("admin-add-product.jsp");
            }
        } else {
            session.setAttribute("message", "This servlet only handles file upload requests.");
            response.sendRedirect("admin-add-product.jsp");
        }
    }
}
