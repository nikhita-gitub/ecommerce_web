import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.connection.DatabaseConnection;
import javax.servlet.http.HttpSession;

@WebServlet("/AddProducts")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,    // 1 MB
                 maxFileSize = 1024 * 1024 * 5,      // 5 MB
                 maxRequestSize = 1024 * 1024 * 10)  // 10 MB
public class AddProducts extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "C:\\Users\\ADMIN\\Documents\\NetBeansProjects\\ecommerce1\\web\\uploads\\products";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Process form fields
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String price = request.getParameter("price");

        HttpSession hs = request.getSession();
        
        
        double productPrice = 0.0;
        try {
            productPrice = Double.parseDouble(price);
        } catch (NumberFormatException e) {
            e.printStackTrace();
         //response.sendRedirect("AddProducts.jsp?message=Invalid price format.");
         request.setAttribute("message", "Invalid price format.");
request.getRequestDispatcher("AddProducts.jsp").forward(request, response);

         
            return;
        }

        // Handle file upload
        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();

        // Save the file to the specified directory
         String categoryPath = UPLOAD_DIRECTORY + File.separator + category;
         String filePath = categoryPath + File.separator + fileName;
        File fileSaveDir = new File(categoryPath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        
        try {
            filePart.write(filePath);
        } catch (IOException e) {
            e.printStackTrace();
         hs.setAttribute("message", "File upload fail1");
response.sendRedirect("AddProducts.jsp");
         
            return;
        }

        // Insert product into database
        try {
            boolean isInserted = insertProductIntoDatabase(productName, description,productPrice, filePath, fileName, category, status);
            if (isInserted) {
              //response.sendRedirect("AddProducts.jsp?message=Product added successfully.");
              
              hs.setAttribute("message", "Product added successfully.");
              response.sendRedirect("AddProducts.jsp");
              
            } else {
              //response.sendRedirect("AddProducts.jsp?message=File upload failed.");
             hs.setAttribute("message", "File upload fail2");
             response.sendRedirect("AddProducts.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
          //response.sendRedirect("AddProducts.jsp?message=Database error occurred.");
hs.setAttribute("message", "Database error occurred");
response.sendRedirect("AddProducts.jsp");
        }
    }

    // Method to insert product details into the database
    private boolean insertProductIntoDatabase(String name, String description, double price, String imagePath, String imageName, String category, String status) {
        String sql = "INSERT INTO tblproduct(productName, description,price, image, image_name,category, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement(sql)) {
            
            ps.setString(1,name);
ps.setString(2, description);
ps.setDouble(3, price);
ps.setString(4, imagePath);
ps.setString(5, imageName);
ps.setString(6, category);
ps.setString(7, status);

         
            System.out.println("Attempting to insert product into database...");
        int rowsInserted = ps.executeUpdate();
        System.out.println("Rows inserted: " + rowsInserted);

            
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
             System.out.println("SQL Error: " + e.getMessage());
            return false;
        }
    }
    
    
}
