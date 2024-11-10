package com.productlist;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.connection.DatabaseConnection;



@WebServlet("/")
public class Product extends HttpServlet {
    
    // Assuming Product has name, description, price, image properties.
    private String name;
    private String description;
    private double price;
    private String image;

    public Product() {}

    public Product(String name, String description, double price, String image) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Product> products = new ArrayList<>();
        String sql = "SELECT productName, description, price, image FROM tblproduct";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Create a Product object using data from the database
//                String fullImagePath = rs.getString("image");  // This gets the full path from the database
//String relativeImagePath = fullImagePath.replace("C:\\Users\\ADMIN\\Documents\\NetBeansProjects\\ecommerce1\\web\\", "")
//                                         .replace("\\", "/")
//                                         .replace(" ", "%20");
String relativeImagePath = getServletContext().getRealPath("/") + "uploads/products";

                System.out.println("Relative path: " + relativeImagePath);
                Product product = new Product(
                        rs.getString("productName"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        relativeImagePath
                    // "uploads/" + rs.getString("image")
                );

                // Add the product to the list
                products.add(product);
            }
            System.out.println("Number of products: " + products.size());
            
            for (Product product : products) {
    System.out.println("Product: " + product.getName() + ", " +
            product.getDescription() + ", " +
            product.getPrice() + ", " +
            product.getImage());
}
            String message = products.isEmpty() ? "No products found" : "Products retrieved successfully";
request.setAttribute("message", message);



            // Set the list of products as an attribute in the request scope
            request.setAttribute("products", products);
            System.out.println("Loading main.jsp from doGet");
            System.out.println("Forwarding to main.jsp, status code: " + response.getStatus());
            request.getRequestDispatcher("main.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
