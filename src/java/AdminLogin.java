
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.DatabaseConnection;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            //Getting all the parameters from the frontend (admin)
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            //Retriving our session
            HttpSession hs = request.getSession();

            try {
            //Creating Resultset
            ResultSet resultset = null;
            //Query to check Login Details
            resultset = DatabaseConnection.getResultFromSqlQuery("select * from tbladmin where email='" + email + "' and password='" + password + "'");
            //Checking whether the details of user are null or not
            if (email != null && password != null) {
                if (resultset.next()) {
                    //Storing the login details in session
                    hs.setAttribute("id", resultset.getInt("id"));
                    hs.setAttribute("name", resultset.getString("name"));
                    //Redirecting response to the index.jsp
                    response.sendRedirect("dashboard.jsp");
                } else {
                    //If wrong credentials are entered
                    String message = "You have enter wrong credentials";
                    hs.setAttribute("credential", message);
                    //Redirecting response to the customer-login.jsp
                    response.sendRedirect("admin-login.jsp");
                }
            } else {
                //If username or password is empty or null
                String message = "User name or Password is not entered";
                hs.setAttribute("credential", message);
                //Redirecting response to the customer-login.jsp
                response.sendRedirect("admin-login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

